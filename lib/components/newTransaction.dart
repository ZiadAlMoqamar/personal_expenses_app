import 'package:flutter/material.dart';
import '../classes/transaction.dart';

class NewTransaction extends StatelessWidget {
  final Function addingTransaction;
  final List<Transaction> transactions;
  final titleController = TextEditingController();
  final priceController = TextEditingController();

  NewTransaction({required this.transactions, required this.addingTransaction});

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredPrice = double.parse(priceController.text);

    if(enteredTitle.isEmpty || enteredPrice <= 0){
      return;
    }
    addingTransaction(Transaction(
        title: enteredTitle,
        cost: enteredPrice,
        time: DateTime.now(),
        id: transactions.length + 1));
  }

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
            keyboardType: TextInputType.number,
            // _ means that I don't use it
            onSubmitted: (_) => submitData(),
          ),
          ElevatedButton(
            onPressed: submitData,
            child: Text('Add Transaction'),
          )
        ],
      ),
    );
  }
}
