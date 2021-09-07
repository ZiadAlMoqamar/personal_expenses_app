import 'package:flutter/material.dart';
import 'package:personal_expenses_app/classes/transaction.dart';
import 'package:intl/intl.dart';

class MyListTile extends StatelessWidget {
  final Transaction transaction;
  MyListTile({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(context).primaryColor,
          child: FittedBox(
            child: Container(
              padding: EdgeInsets.all(5),
              child: Text("\$${transaction.cost.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, fontFamily: 'OpenSans')),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.headline6
        ),
        subtitle: Text(DateFormat.yMMMd().format(transaction.time),style: Theme.of(context).textTheme.bodyText2,),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () => print('delete'),
        ),
        tileColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
