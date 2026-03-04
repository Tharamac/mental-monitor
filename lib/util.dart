import 'package:intl/intl.dart';

String formatDateInThai(DateTime date) {
  final thaiDate = DateTime(date.year + 543, date.month, date.day);
  return DateFormat.yMMMMd().format(thaiDate).replaceAll('ค.ศ.', 'พ.ศ.');
}
