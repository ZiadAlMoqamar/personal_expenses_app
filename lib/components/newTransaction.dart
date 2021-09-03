import 'package:flutter/material.dart';
import '../classes/transaction.dart';

class NewTransaction extends StatelessWidget {
  final Function addingTransaction;
  final List<Transaction> transactions;
  final titleController = TextEditingController();
  final priceController = TextEditingController();

  NewTransaction({required this.transactions,required this.addingTransaction});

  @override
  Widget build(BuildContext context) {
    return Card(
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: "Title"),
                  controller: titleController,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Price"),
                  controller: priceController,
                ),
                ElevatedButton(
                    onPressed: () { 
                      addingTransaction(Transaction(
                        title: titleController.text,
                        cost: double.parse(priceController.text),
                        time: DateTime.now(),
                        id: transactions.length + 1));},
                    child: Text('Add Transaction'))
              ],
            ),
          );
  }
}