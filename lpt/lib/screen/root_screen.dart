import 'package:flutter/cupertino.dart';
import 'package:lpt/screen/day/day_screen.dart';
import 'package:lpt/screen/home/home_screen.dart';
import 'package:lpt/screen/month/month_screen.dart';
import 'package:lpt/screen/year/year_screen.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      backgroundColor: CupertinoColors.white,
      resizeToAvoidBottomInset: true,
      tabBar: CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/resources/home.png',
              color: Color(0xffa2a2a2),
            ),
            activeIcon: Image.asset(
              'assets/resources/home.png',
              color: Color(0xff3477f9),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/resources/year.png',
              color: Color(0xffa2a2a2),
            ),
            activeIcon: Image.asset(
              'assets/resources/year.png',
              color: Color(0xff3477f9),
            ),
            label: 'Năm',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/resources/month.png',
              color: Color(0xffa2a2a2),
            ),
            activeIcon: Image.asset(
              'assets/resources/month.png',
              color: Color(0xff3477f9),
            ),
            label: 'Tháng',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/resources/day.png',
              color: Color(0xffa2a2a2),
            ),
            activeIcon: Image.asset(
              'assets/resources/day.png',
              color: Color(0xff3477f9),
            ),
            label: 'Ngày',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return [HomeScreen(), YearScreen(), MonthScreen(), DayScreen()][index];
      },
    );
  }
}
