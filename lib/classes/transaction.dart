import 'package:flutter/material.dart';

class Transaction {
  final int id;
  final String title;
  final double cost;
  final DateTime time;

  Transaction(
      {required this.id,
      required this.title,
      required this.cost,
      required this.time});
}
