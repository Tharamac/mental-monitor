import 'package:intl/intl.dart';

String formatDateInThai(DateTime date, {bool shorten = false}) {
  final thaiDate = DateTime(date.year + 543, date.month, date.day);
  return (shorten)
      ? DateFormat.yMMMd().format(thaiDate).replaceAll('ค.ศ.', 'พ.ศ.')
      : DateFormat.yMMMMd().format(thaiDate).replaceAll('ค.ศ.', 'พ.ศ.');
}

// String formatDateInThaiAbbr(DateTime date) {
//   final thaiDate = DateTime(date.year + 543, date.month, date.day);
//   return DateFormat.yMMMMd().format(thaiDate).replaceAll('ค.ศ.', 'พ.ศ.');
// }