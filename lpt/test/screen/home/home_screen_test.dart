import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lpt/screen/home/home_screen.dart';

void main() {
  testWidgets('Hiển thị tiêu đề chính xác', (WidgetTester tester) async {
    await tester.pumpWidget(const CupertinoApp(home: HomeScreen()));

    expect(
      find.text('NHÂN SINH HỌC VIỆT NAM TRONG THỜI ĐẠI MỚI'),
      findsOneWidget,
    );
    expect(find.text('DỰ BÁO THEO THÁI CỰC HOA GIÁP'), findsOneWidget);
    expect(find.text('Tác giả: TS. Nguyễn Ngọc Thạch'), findsOneWidget);
  });

  testWidgets('Hiển thị lỗi khi không có dữ liệu', (WidgetTester tester) async {
    await tester.pumpWidget(const CupertinoApp(home: HomeScreen()));

    expect(find.text('Lỗi xảy ra'), findsOneWidget);
  });
}
