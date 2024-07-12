import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String dateFormater(DateTime dt, {String pattern = "dd/MM/yyyy"}) {
  return DateFormat(pattern).format(dt);
}

void showErrMsg(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}
