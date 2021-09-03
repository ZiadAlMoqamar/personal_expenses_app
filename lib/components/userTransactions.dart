import 'package:flutter/material.dart';
import '../classes/transaction.dart';
import 'myListTile.dart';

class UserTransactionsList extends StatefulWidget {

   final List<Transaction> transactions;
   UserTransactionsList({required this.transactions});

  @override
  _UserTransactionsListState createState() => _UserTransactionsListState();
}

class _UserTransactionsListState extends State<UserTransactionsList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
            child: ListView(
              children: widget.transactions
                  .map((tx) => MyListTile(
                        transaction: tx,
                      ))
                  .toList(),
            ),
          );
  }
}