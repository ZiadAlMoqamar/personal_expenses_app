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
        child: widget.transactions.isEmpty
            ? Column(
                children: [
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return MyListTile(transaction: widget.transactions[index]);
                },
                itemCount: widget.transactions.length,
              ));
  }
}
