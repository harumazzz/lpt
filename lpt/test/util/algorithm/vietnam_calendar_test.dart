import 'package:flutter_test/flutter_test.dart';
import 'package:lpt/util/calendar/vietnam_calendar.dart';

void main() {
  group('solar to lunar test', () {
    test('should convert known solar date to lunar correctly', () {
      final result = VietnamCalendar.convertSolar2Lunar(1, 1, 2024, 7.0);
      expect(result, equals((20, 11, 2023, 0)));
    });

    test('should convert another solar date to lunar correctly', () {
      final result = VietnamCalendar.convertSolar2Lunar(10, 5, 2025, 7.0);
      expect(result, equals((13, 4, 2025, 0)));
    });

    test('should handle leap years properly', () {
      final result = VietnamCalendar.convertSolar2Lunar(29, 2, 2024, 7.0);
      expect(result, equals((20, 1, 2024, 0)));
    });
  });
}
