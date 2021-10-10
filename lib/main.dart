import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

import 'package:personal_expenses_app/classes/transaction.dart';
import 'package:personal_expenses_app/components/chartsCard.dart';
import 'package:personal_expenses_app/components/newTransaction.dart';
import 'package:personal_expenses_app/components/userTransactions.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //used to prevent landscape mode
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
  bool showChart = false;
  void addingTransaction(Transaction tx) {
    setState(() {
      transactions.add(tx);
      transactions.sort((a, b) => b.time.compareTo(a.time));
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
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = AppBar(
      title: Text(widget.title),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => triggerModalBottomSheet(),
        ),
      ],
    );
    final IOSAppBar = CupertinoNavigationBar(
      middle: Text(
        'Personal Expenses',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: () => triggerModalBottomSheet(),
          ),
        ],
      ),
    );
    final txListWidget = Container(
      child: UserTransactionsList(
        transactions: transactions,
        deleteTx: deleteTransaction,
      ),
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
    );
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Show Chart',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Switch.adaptive(
                      activeColor: Theme.of(context).accentColor,
                      value: showChart,
                      onChanged: (val) {
                        setState(() {
                          showChart = val;
                        });
                      })
                ],
              ),
            if (!isLandscape)
              Container(
                child: ChartsCard(transactions: _userRecentTransactions),
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
              ),
            if (!isLandscape) txListWidget,
            if (isLandscape && showChart)
              Container(
                child: ChartsCard(transactions: _userRecentTransactions),
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.6,
              ),
            txListWidget
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
          backgroundColor: Colors.grey[200],
            child: pageBody,
            navigationBar: IOSAppBar,
          )
        : Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: appBar,
            body: pageBody,
            floatingActionButton: !isLandscape
                ? FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => triggerModalBottomSheet(),
                  )
                : Container(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
