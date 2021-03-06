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
        ? LayoutBuilder(builder: (ctx,constraints){
          return Column(
            children: [
              Text(
                'No transactions added yet!',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 10,),
              Container(
                height: constraints.maxHeight *0.6,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          );
        })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return MyListTile(transaction: widget.transactions[index], deleteTx: widget.deleteTx,);
            },
            itemCount: widget.transactions.length,
          );
  }
}
