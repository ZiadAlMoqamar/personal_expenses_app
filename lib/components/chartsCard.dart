import 'package:flutter/material.dart';
import 'package:personal_expenses_app/classes/transaction.dart';

class ChartsCard extends StatelessWidget {
  final List<Transaction> transactions;

  ChartsCard({required this.transactions});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 150,
      width: double.infinity,
      child: Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [],
          ),
        ),
      ),
    );
  }
}
