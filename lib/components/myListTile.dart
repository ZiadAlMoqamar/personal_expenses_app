import 'package:flutter/material.dart';
import 'package:personal_expenses_app/classes/transaction.dart';

class myListTile extends StatelessWidget {
  final Transaction transaction;
  myListTile({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
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
            child: Text("\$${transaction.cost}",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          ),
          title: Text(
            transaction.title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(transaction.time.toString()),
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
      ),
    );
  }
}
