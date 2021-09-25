import 'package:flutter/material.dart';
import '../classes/transaction.dart';
import 'myListTile.dart';

class UserTransactionsList extends StatefulWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  UserTransactionsList({required this.transactions, required this.deleteTx});

  @override
  _UserTransactionsListState createState() => _UserTransactionsListState();
}

class _UserTransactionsListState extends State<UserTransactionsList> {
  @override
  Widget build(BuildContext context) {
    return widget.transactions.isEmpty
        ? Column(
            children: [
              Text(
                'No transactions added yet!',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 10,),
              Container(
                height: MediaQuery.of(context).size.height *0.4,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return MyListTile(transaction: widget.transactions[index], deleteTx: widget.deleteTx,);
            },
            itemCount: widget.transactions.length,
          );
  }
}
