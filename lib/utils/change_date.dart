import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

//日付変換
String changeDateFormat(String date) {
  initializeDateFormatting('ja_JP');
  // StringからDate
  final DateTime datetime = DateTime.parse(date);

  final DateFormat formatter = DateFormat('yyyy/MM/dd', 'ja_JP');
  // DateからString
  final String formatted = formatter.format(datetime);
  return formatted;
}
