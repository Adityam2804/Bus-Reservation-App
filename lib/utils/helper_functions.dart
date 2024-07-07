import 'package:intl/intl.dart';

String dateFormater(DateTime dt, {String pattern = "dd/MM/yyyy"}) {
  return DateFormat(pattern).format(dt);
}
