import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_expenses_app/classes/transaction.dart';
import 'package:personal_expenses_app/components/newTransaction.dart';
import 'package:personal_expenses_app/components/userTransactions.dart';
import 'components/myListTile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(title: 'Personal Expenses'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [
    Transaction(id: 1, title: "New Shoes", cost: 93.2, time: DateTime.now()),
    Transaction(id: 2, title: "phone", cost: 150.2, time: DateTime.now())
  ];

  void addingTransaction(Transaction tx) {
    setState(() {
      transactions.add(tx);
    });
  }

  void triggerModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: (){},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(
                transactions: transactions, addingTransaction: addingTransaction),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => triggerModalBottomSheet(),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            height: 150,
            width: double.infinity,
            child: Card(
              elevation: 5,
              color: Colors.white,
              child: Text('charts'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          UserTransactionsList(transactions: transactions)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => triggerModalBottomSheet(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
