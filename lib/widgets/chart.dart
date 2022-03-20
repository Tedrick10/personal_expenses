// Packages
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Models
import '../models/transaction.dart';

// Widgets
import './chart_bar.dart';

class Chart extends StatelessWidget {
  // Properties
  final List<Transaction> recentTransaction;

  // Constructors
  Chart(this.recentTransaction);

  // Methods

  // Get Methods
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      // Variables
      final weekDays = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;

      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDays.day &&
            recentTransaction[i].date.month == weekDays.month &&
            recentTransaction[i].date.year == weekDays.year) {
          totalSum += recentTransaction[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDays).substring(0, 1),
        'amount': totalSum
      };
    });
  }

  double get totalSpending {
    return this.groupedTransactionValues.fold(0.00, (sum, item) {
      return sum + item['amount'];
    });
  }

  // Widget
  @override
  Widget build(BuildContext context) {
    // print(this.groupedTransactionValues);
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Container(
          margin: EdgeInsets.all(10),
          child: Padding( 
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactionValues.map((data) {
                // return Text('${data['day']} : ${data['amount'].toString()}');
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                      data['day'],
                      data['amount'],
                      this.totalSpending == 0.0
                          ? 0.0
                          : (data['amount'] as double) / totalSpending),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
