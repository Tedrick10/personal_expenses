import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  // Properties
  final String label;
  final double spendingAmount;
  final double spendingPercentage;

  // Constructor
  ChartBar(this.label, this.spendingAmount, this.spendingPercentage);

  // Methods

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraint) {
      return Column(
        children: <Widget>[
          Container(
              height: constraint.maxHeight * 0.1,
              child: FittedBox(
                child: Text('\$${this.spendingAmount.toStringAsFixed(0)}'),
              )),
          SizedBox(
            height: constraint.maxHeight * 0.05,
          ),
          Container(
            height: constraint.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        color: Color.fromRGBO(220, 220, 220, 1),
                        borderRadius: BorderRadius.circular(10))),
                FractionallySizedBox(
                  heightFactor: spendingPercentage,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: constraint.maxHeight * 0.05),
          Container(
              height: constraint.maxHeight * 0.1,
              child: FittedBox(child: Text(label))),
        ],
      );
    });
  }
}
