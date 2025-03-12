import 'package:intl/intl.dart';

extension SolarExtension on (int, int, int) {
  DateTime toDateTime() {
    return DateTime($1, $2, $3);
  }

  String toVietnameseDate() {
    final date = toDateTime();
    return DateFormat('dd/MM/yyyy').format(date);
  }
}
