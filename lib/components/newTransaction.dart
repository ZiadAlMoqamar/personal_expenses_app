import 'package:flutter/material.dart';
import '../classes/transaction.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addingTransaction;
  final List<Transaction> transactions;

  NewTransaction({required this.transactions, required this.addingTransaction});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  DateTime? selectedDate = null;

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredPrice = double.parse(priceController.text);

    if (enteredTitle.isEmpty || enteredPrice <= 0) {
      return;
    }
    widget.addingTransaction(Transaction(
        title: enteredTitle,
        cost: enteredPrice,
        time: selectedDate!,
        id: widget.transactions.length + 1));

    //to close the modal bottom sheet after submitting new transaction
    Navigator.of(context).pop();
  }

  void openDatePicker() {
    showDatePicker(
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            context: context,
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        top: 15,
        right: 8,
        left: 8,
      ),
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
            //onSubmitted: (_) => submitData(),
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                selectedDate == null
                    ? 'No date is chosen yet'
                    : 'Picked Date: ${DateFormat.yMd().format(selectedDate!)}',
              )),
              TextButton(
                  onPressed: openDatePicker,
                  child: Text('Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold)))
            ],
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
