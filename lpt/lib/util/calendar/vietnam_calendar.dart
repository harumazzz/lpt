import 'dart:math' as math;

class VietnamCalendar {
  static int jdFromDate(int dd, int mm, int yy) {
    final a = ((14 - mm) / 12).floor();
    final y = yy + 4800 - a;
    final m = mm + 12 * a - 3;
    var jd =
        dd +
        ((153 * m + 2) / 5).floor() +
        365 * y +
        (y / 4).floor() -
        (y / 100).floor() +
        (y / 400).floor() -
        32045;
    if (jd < 2299161) {
      jd = (dd + (153 * m + 2) / 5 + 365 * y + y / 4 - 32083).floor();
    }
    return jd;
  }

  static (int, int, int) jdToDate(int jd) {
    final (b, c) = (() {
      if (jd > 2299160) {
        var a = jd + 32044;
        var b = ((4 * a + 3) / 146097).floor();
        var c = (a - (b * 146097) / 4).floor();
        return (b, c);
      } else {
        return (0, jd + 32082);
      }
    }());
    final d = ((4 * c + 3) / 1461).floor();
    final e = (c - (1461 * d) / 4).floor();
    final m = ((5 * e + 2) / 153).floor();
    final day = (e - (153 * m + 2) / 5 + 1).floor();
    final month = (m + 3 - 12 * (m / 10)).floor();
    final year = (b * 100 + d - 4800 + m / 10).floor();
    return (day, month, year);
  }

  static double sunLongitude(double jdn) {
    return sunLongitudeAA98(jdn);
  }

  static double sunLongitudeAA98(double jdn) {
    final T = (jdn - 2451545.0) / 36525;
    final t2 = T * T;
    final dr = math.pi / 180;
    final M =
        357.52910 + 35999.05030 * T - 0.0001559 * t2 - 0.00000048 * T * t2;
    final l0 = 280.46645 + 36000.76983 * T + 0.0003032 * t2;
    var dl = (1.914600 - 0.004817 * T - 0.000014 * t2) * math.sin(dr * M);
    dl =
        dl +
        (0.019993 - 0.000101 * T) * math.sin(dr * 2 * M) +
        0.000290 * math.sin(dr * 3 * M);
    var L = l0 + dl;
    L = L - 360 * (integerOf(L / 360));
    return L;
  }

  static int integerOf(double d) {
    return d.floor();
  }

  static double newMoon(int k) {
    return newMoonAA98(k);
  }

  static double newMoonAA98(int k) {
    final T = k / 1236.85;
    final t2 = T * T;
    final t3 = t2 * T;
    final dr = math.pi / 180;
    var jd1 =
        2415020.75933 + 29.53058868 * k + 0.0001178 * t2 - 0.000000155 * t3;
    jd1 = jd1 + 0.00033 * math.sin((166.56 + 132.87 * T - 0.009173 * t2) * dr);
    final M = 359.2242 + 29.10535608 * k - 0.0000333 * t2 - 0.00000347 * t3;
    final mpr = 306.0253 + 385.81691806 * k + 0.0107306 * t2 + 0.00001236 * t3;
    final F = 21.2964 + 390.67050646 * k - 0.0016528 * t2 - 0.00000239 * t3;
    var c1 =
        (0.1734 - 0.000393 * T) * math.sin(M * dr) +
        0.0021 * math.sin(2 * dr * M);
    c1 = c1 - 0.4068 * math.sin(mpr * dr) + 0.0161 * math.sin(dr * 2 * mpr);
    c1 = c1 - 0.0004 * math.sin(dr * 3 * mpr);
    c1 = c1 + 0.0104 * math.sin(dr * 2 * F) - 0.0051 * math.sin(dr * (M + mpr));
    c1 =
        c1 -
        0.0074 * math.sin(dr * (M - mpr)) +
        0.0004 * math.sin(dr * (2 * F + M));
    c1 =
        c1 -
        0.0004 * math.sin(dr * (2 * F - M)) -
        0.0006 * math.sin(dr * (2 * F + mpr));
    c1 =
        c1 +
        0.0010 * math.sin(dr * (2 * F - mpr)) +
        0.0005 * math.sin(dr * (2 * mpr + M));
    final deltat =
        (() {
          if (T < -11) {
            return 0.001 +
                0.000839 * T +
                0.0002261 * t2 -
                0.00000845 * t3 -
                0.000000081 * T * t3;
          } else {
            return -0.000278 + 0.000265 * T + 0.000262 * t2;
          }
        })();
    final jdNew = jd1 + c1 - deltat;
    return jdNew;
  }

  static double getSunLongitude(int dayNumber, double timeZone) {
    return sunLongitude(dayNumber - 0.5 - timeZone / 24);
  }

  static int getNewMoonDay(int k, double timeZone) {
    final jd = newMoon(k);
    return integerOf(jd + 0.5 + timeZone / 24);
  }

  static int getLunarMonth11(int yy, double timeZone) {
    final off = jdFromDate(31, 12, yy) - 2415021.076998695;
    final k = integerOf(off / 29.530588853);
    var nm = getNewMoonDay(k, timeZone);
    final sunLong = integerOf(getSunLongitude(nm, timeZone) / 30);
    if (sunLong >= 9) {
      nm = getNewMoonDay(k - 1, timeZone);
    }
    return nm;
  }

  static int getLeapMonthOffset(int a11, double timeZone) {
    final k = integerOf(0.5 + (a11 - 2415021.076998695) / 29.530588853);
    var last = null as int?;
    var i = 1;
    var arc = integerOf(
      getSunLongitude(getNewMoonDay(k + i, timeZone), timeZone) / 30,
    );
    do {
      last = arc;
      i++;
      arc = integerOf(
        getSunLongitude(getNewMoonDay(k + i, timeZone), timeZone) / 30,
      );
    } while (arc != last && i < 14);
    return i - 1;
  }

  static (int, int, int, int) convertSolar2Lunar(
    int dd,
    int mm,
    int yy, [
    double timeZone = 7.0,
  ]) {
    var lunarDay = null as int?;
    var lunarMonth = null as int?;
    var lunarYear = null as int?;
    var lunarLeap = null as int?;
    final dayNumber = jdFromDate(dd, mm, yy);
    final k = integerOf((dayNumber - 2415021.076998695) / 29.530588853);
    var monthStart = getNewMoonDay(k + 1, timeZone);
    if (monthStart > dayNumber) {
      monthStart = getNewMoonDay(k, timeZone);
    }
    var a11 = getLunarMonth11(yy, timeZone);
    var b11 = a11;
    if (a11 >= monthStart) {
      lunarYear = yy;
      a11 = getLunarMonth11(yy - 1, timeZone);
    } else {
      lunarYear = yy + 1;
      b11 = getLunarMonth11(yy + 1, timeZone);
    }
    lunarDay = dayNumber - monthStart + 1;
    final diff = integerOf((monthStart - a11) / 29);
    lunarLeap = 0;
    lunarMonth = diff + 11;
    if (b11 - a11 > 365) {
      final leapMonthDiff = getLeapMonthOffset(a11, timeZone);
      if (diff >= leapMonthDiff) {
        lunarMonth = diff + 10;
        if (diff == leapMonthDiff) {
          lunarLeap = 1;
        }
      }
    }
    if (lunarMonth > 12) {
      lunarMonth = lunarMonth - 12;
    }
    if (lunarMonth >= 11 && diff < 4) {
      lunarYear -= 1;
    }
    return (lunarDay, lunarMonth, lunarYear, lunarLeap);
  }

  static (int, int, int) convertLunar2Solar(
    int lunarDay,
    int lunarMonth,
    int lunarYear,
    int lunarLeap,
    double timeZone,
  ) {
    final (a11, b11) = (() {
      if (lunarMonth < 11) {
        return (
          getLunarMonth11(lunarYear - 1, timeZone),
          getLunarMonth11(lunarYear, timeZone),
        );
      } else {
        return (
          getLunarMonth11(lunarYear, timeZone),
          getLunarMonth11(lunarYear + 1, timeZone),
        );
      }
    }());
    final k = integerOf(0.5 + (a11 - 2415021.076998695) / 29.530588853);
    var off = lunarMonth - 11;
    if (off < 0) {
      off += 12;
    }
    if (b11 - a11 > 365) {
      final leapOff = getLeapMonthOffset(a11, timeZone);
      var leapMonth = leapOff - 2;
      if (leapMonth < 0) {
        leapMonth += 12;
      }
      if (lunarLeap != 0 && lunarMonth != leapMonth) {
        throw Exception('Invalid input argument');
      } else if (lunarLeap != 0 || off >= leapOff) {
        off += 1;
      }
    }
    final monthStart = getNewMoonDay(k + off, timeZone);
    return jdToDate(monthStart + lunarDay - 1);
  }

  static String getCanChiYear(int lunarYear) {
    const can = [
      'Canh',
      'Tân',
      'Nhâm',
      'Quý',
      'Giáp',
      'Ất',
      'Bính',
      'Đinh',
      'Mậu',
      'Kỷ',
    ];
    const chi = [
      'Thân',
      'Dậu',
      'Tuất',
      'Hợi',
      'Tý',
      'Sửu',
      'Dần',
      'Mão',
      'Thìn',
      'Tỵ',
      'Ngọ',
      'Mùi',
    ];
    return '${can[lunarYear % 10]} ${chi[lunarYear % 12]}';
  }

  static String getNguHanhMenh(int lunarYear) {
    const canValues = [4, 4, 5, 5, 1, 1, 2, 2, 3, 3];
    const chiValues = [1, 1, 2, 2, 0, 0, 1, 1, 2, 2, 0, 0];
    final canIndex = lunarYear % 10;
    final chiIndex = lunarYear % 12;
    var menhValue = canValues[canIndex] + chiValues[chiIndex];
    if (menhValue >= 5) {
      menhValue -= 5;
    }
    return {1: 'Kim', 2: 'Thủy', 3: 'Hỏa', 4: 'Thổ', 5: 'Mộc'}[menhValue]!;
  }
}
