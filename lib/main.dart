import 'package:flutter/material.dart';
import 'package:personal_expenses_app/classes/transaction.dart';
import 'package:personal_expenses_app/components/chartsCard.dart';
import 'package:personal_expenses_app/components/newTransaction.dart';
import 'package:personal_expenses_app/components/userTransactions.dart';

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
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
          )),
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
    // Transaction(id: 1, title: "New Shoes", cost: 93.2, time: DateTime.now()),
    // Transaction(id: 2, title: "phone", cost: 150.2, time: DateTime.now())
  ];

  void addingTransaction(Transaction tx) {
    setState(() {
      transactions.add(tx);
    });
  }

  void triggerModalBottomSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(
                transactions: transactions,
                addingTransaction: addingTransaction),
          );
        });
  }

  List<Transaction> get _userRecentTransactions {
    return transactions
        .where(
          (element) => element.time.isAfter(
            DateTime.now().subtract(
              Duration(days: 7),
            ),
          ),
        )
        .toList();
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
          ChartsCard(transactions: _userRecentTransactions),
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
