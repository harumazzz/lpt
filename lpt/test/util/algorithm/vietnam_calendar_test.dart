import 'package:flutter_test/flutter_test.dart';
import 'package:lpt/util/calendar/vietnam_calendar.dart';

void main() {
  group('solar to lunar test', () {
    test('should convert known solar date to lunar correctly', () {
      final result = VietnamCalendar.convertSolar2Lunar(1, 1, 2024);
      expect(result, equals((20, 11, 2023, 0)));
    });

    test('should convert another solar date to lunar correctly', () {
      final result = VietnamCalendar.convertSolar2Lunar(10, 5, 2025);
      expect(result, equals((13, 4, 2025, 0)));
    });

    test('should handle leap years properly', () {
      final result = VietnamCalendar.convertSolar2Lunar(29, 2, 2024);
      expect(result, equals((20, 1, 2024, 0)));
    });

    test('should convert known solar date to lunar correctly', () {
      final result = VietnamCalendar.convertSolar2Lunar(1, 1, 1980);
      expect(result, equals((14, 11, 1979, 0)));
    });
    // Test case : https://phongthuyhomang.vn/cach-tinh-thien-can-dia-chi-va-ngu-hanh-nam-sinh-cuc-nhanh
    test('Should return correctly', () {
      expect(VietnamCalendar.getCanChiYear(1995), equalsIgnoringCase('Ất Hợi'));
      expect(
        VietnamCalendar.getCanChiYear(2000),
        equalsIgnoringCase('Canh Thìn'),
      );
      expect(
        VietnamCalendar.getCanChiYear(2004),
        equalsIgnoringCase('Giáp Thân'),
      );
      expect(
        VietnamCalendar.getCanChiYear(2011),
        equalsIgnoringCase('Tân Mão'),
      );
      expect(
        VietnamCalendar.getCanChiYear(2016),
        equalsIgnoringCase('Bính Thân'),
      );
      expect(
        VietnamCalendar.getCanChiYear(2020),
        equalsIgnoringCase('Canh Tý'),
      );
    });
    test('Should convert correctly', () {
      expect(
        VietnamCalendar.getNguHanhMenh(1996),
        equalsIgnoringCase('Thủy'),
      ); // Bính Tý
      expect(
        VietnamCalendar.getNguHanhMenh(2000),
        equalsIgnoringCase('Kim'),
      ); // Canh Thìn
      expect(
        VietnamCalendar.getNguHanhMenh(2023),
        equalsIgnoringCase('Kim'),
      ); // Quý Mão
      expect(
        VietnamCalendar.getNguHanhMenh(2024),
        equalsIgnoringCase('Hỏa'),
      ); // Giáp Thìn
      expect(
        VietnamCalendar.getNguHanhMenh(1930),
        equalsIgnoringCase('Thổ'),
      ); // Canh Ngọ
      expect(
        VietnamCalendar.getNguHanhMenh(1931),
        equalsIgnoringCase('Thổ'),
      ); // Tân Mùi
      expect(
        VietnamCalendar.getNguHanhMenh(1932),
        equalsIgnoringCase('Kim'),
      ); // Nhâm Thân
      expect(
        VietnamCalendar.getNguHanhMenh(1936),
        equalsIgnoringCase('Thủy'),
      ); // Bính Tý
      expect(
        VietnamCalendar.getNguHanhMenh(1938),
        equalsIgnoringCase('Thổ'),
      ); // Mậu Dần
    });
  });
}
