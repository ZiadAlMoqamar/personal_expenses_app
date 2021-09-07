import 'package:flutter/material.dart';
import 'package:personal_expenses_app/classes/chartData.dart';
import 'package:personal_expenses_app/classes/transaction.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/components/chart.dart';

class ChartsCard extends StatelessWidget {
  final List<Transaction> transactions;

  ChartsCard({required this.transactions});

  List<ChartData> get chartsItemsList {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalSum = 0.0;

      for (var tx in transactions) {
        if (tx.time.day == weekDay.day &&
            tx.time.month == weekDay.month &&
            tx.time.year == weekDay.year) {
          totalSum += tx.cost;
        }
      }
      return ChartData(
          title: DateFormat.E().format(weekDay), totalSpending: totalSum);
    });
  }

  double get totalWeekSpending {
    return chartsItemsList.fold(
        0.0, (previousValue, element) => previousValue + element.totalSpending);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 150,
      width: double.infinity,
      child: Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: chartsItemsList
                .map(
                  (e) => Flexible(
                    fit: FlexFit.tight,
                    child: Chart(
                        title: e.title,
                        totalSpending: e.totalSpending,
                        spendingToWeekRatio: totalWeekSpending == 0
                            ? 0.0
                            : e.totalSpending / totalWeekSpending),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
