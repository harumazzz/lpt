import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpt/bloc/auth_bloc/auth_bloc.dart';
import 'package:lpt/util/calendar/vietnam_calendar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (BuildContext context) {
        return BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is! AuthLogInState) {
              return const Center(child: Text('Lỗi xảy ra'));
            }

            final lunarInfo = _getLunarInfo(state.user.birthday);
            if (lunarInfo == null) {
              return const Center(child: Text('Lỗi dữ liệu ngày sinh'));
            }

            return _HomeContent(
              userName: state.user.name,
              birthday: state.user.birthday,
              lunarInfo: lunarInfo,
            );
          },
        );
      },
    );
  }

  (
    int lunarDay,
    int lunarMonth,
    int lunarYear,
    String canChiYear,
    String nguHanhMenh,
  )?
  _getLunarInfo(String birthday) {
    try {
      final birthdayParts = birthday.split('/').map(int.parse).toList();
      if (birthdayParts.length != 3) return null;

      final (
        lunarDay,
        lunarMonth,
        lunarYear,
        _,
      ) = VietnamCalendar.convertSolar2Lunar(
        birthdayParts[0],
        birthdayParts[1],
        birthdayParts[2],
      );

      return (
        lunarDay,
        lunarMonth,
        lunarYear,
        VietnamCalendar.getCanChiYear(lunarYear),
        VietnamCalendar.getNguHanhMenh(lunarYear),
      );
    } catch (e) {
      return null;
    }
  }
}

class _HomeContent extends StatelessWidget {
  final String userName;
  final String birthday;
  final (
    int lunarDay,
    int lunarMonth,
    int lunarYear,
    String canChiYear,
    String nguHanhMenh,
  )
  lunarInfo;

  const _HomeContent({
    required this.userName,
    required this.birthday,
    required this.lunarInfo,
  });

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final (lunarDay, lunarMonth, lunarYear, canChiYear, nguHanhMenh) =
        lunarInfo;
    final (
      todayLunarDay,
      todayLunarMonth,
      todayLunarYear,
      _,
    ) = VietnamCalendar.convertSolar2Lunar(today.day, today.month, today.year);

    return Container(
      color: CupertinoColors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100.0),
              _buildTitle(),
              const SizedBox(height: 10),
              Image.asset('assets/resources/logo.png'),
              const SizedBox(height: 20),
              Text(
                'LỊCH PHONG THỦY\nNăm ${today.year}',
                style: _titleTextStyle(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$userName, Sinh ngày $birthday, Tuổi $canChiYear, mệnh $nguHanhMenh\n(Sinh từ ngày $lunarDay/$lunarMonth/$lunarYear đến ngày $lunarDay/$lunarMonth/${lunarYear + 1})',
                  style: _bodyTextStyle(),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Hôm nay ngày ${today.day} tháng ${today.month} năm ${today.year}\nNhằm ngày $todayLunarDay tháng $todayLunarMonth năm ${VietnamCalendar.getCanChiYear(todayLunarYear)}',
                style: _highlightTextStyle(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                'HÃY LÀ THẦY CỦA CHÍNH MÌNH',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.destructiveRed,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: const [
        Text(
          'NHÂN SINH HỌC VIỆT NAM TRONG THỜI ĐẠI MỚI',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: CupertinoColors.activeGreen,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Text(
          'DỰ BÁO THEO THÁI CỰC HOA GIÁP',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: CupertinoColors.activeGreen,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          'Tác giả: TS. Nguyễn Ngọc Thạch',
          style: TextStyle(
            fontSize: 16,
            color: CupertinoColors.activeGreen,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  TextStyle _titleTextStyle() => const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: CupertinoColors.activeGreen,
  );
  TextStyle _bodyTextStyle() =>
      const TextStyle(fontSize: 18, color: CupertinoColors.activeGreen);
  TextStyle _highlightTextStyle() =>
      const TextStyle(fontSize: 18, color: CupertinoColors.destructiveRed);
}
