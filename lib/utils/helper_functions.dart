import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String dateFormater(DateTime dt, {String pattern = "dd/MM/yyyy"}) {
  return DateFormat(pattern).format(dt);
}

void showErrMsg(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}

int getGrandTotal(int discount, int totalSeatsBooked, int price, int fee) {
  final subtotal = totalSeatsBooked * price;
  final priceAfterDiscount = subtotal - ((subtotal * discount) / 100);
  return (priceAfterDiscount + fee).toInt();
}
