import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final String title;
  final double totalSpending;
  final String dayDate;
  final double spendingToWeekRatio;

  Chart(
      {required this.title,
      required this.totalSpending,
      required this.dayDate,
      required this.spendingToWeekRatio});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          Container(
            height: constraints.maxHeight * 0.14,
            child: FittedBox(
              child: Text('\$${totalSpending.toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.subtitle1),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.04,
          ),
          Container(
            height: constraints.maxHeight * 0.5,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingToWeekRatio,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.04,
          ),
          Container(
            height: constraints.maxHeight * 0.14,
            child: FittedBox(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.04,
          ),
          Container(
            height: constraints.maxHeight * 0.10,
            child: FittedBox(
              child: Text(
                dayDate,
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ),
        ],
      );
    });
  }
}
