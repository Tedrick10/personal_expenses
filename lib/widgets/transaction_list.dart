import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransaction;
  final Function deleteTransaction;

  TransactionList(
      {@required this.userTransaction, @required this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    print('builder(): TransactionList');
    return this.userTransaction.isEmpty
        ? LayoutBuilder(builder: (ctx, constraint) {
            return Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: constraint.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.fill,
                    ))
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: FittedBox(
                          child: Text(
                              this.userTransaction[index].amount.toString()),
                        ),
                      )),
                  title: Text(
                    this.userTransaction[index].title,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  subtitle: Text(DateFormat.yMMMMd()
                      .format(this.userTransaction[index].date)),
                  trailing: MediaQuery.of(context).size.width > 360
                      ? FlatButton.icon(
                          onPressed: () {
                            this.deleteTransaction(
                                this.userTransaction[index].id);
                          },
                          icon: Icon(Icons.delete,
                              color: Theme.of(context).errorColor),
                          label: Text(
                            'Delete',
                            style:
                                TextStyle(color: Theme.of(context).errorColor),
                          ),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => this.deleteTransaction(
                              this.userTransaction[index].id),
                        ),
                ),
              );
            },
            itemCount: this.userTransaction.length,
          );

    // itemCount: this.userTransaction.length,
  }
}
