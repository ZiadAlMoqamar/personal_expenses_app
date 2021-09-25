import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_expenses_app/classes/transaction.dart';
import 'package:personal_expenses_app/components/chartsCard.dart';
import 'package:personal_expenses_app/components/newTransaction.dart';
import 'package:personal_expenses_app/components/userTransactions.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
          buttonColor: Colors.white,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 15,
              )),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 15,
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
  final List<Transaction> transactions = [];

  void addingTransaction(Transaction tx) {
    setState(() {
      transactions.add(tx);
    });
  }

  void deleteTransaction(int id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
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
    final appBar = AppBar(
      title: Text(widget.title),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => triggerModalBottomSheet(),
        ),
      ],
    );
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: ChartsCard(transactions: _userRecentTransactions),
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.3,
            ),
            Container(
              child: UserTransactionsList(
                transactions: transactions,
                deleteTx: deleteTransaction,
              ),
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.7,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => triggerModalBottomSheet(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
