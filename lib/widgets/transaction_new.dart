// Packages
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Widgets
import './adaptive_flat_button.dart';

class TransactionNew extends StatefulWidget {
  // Properties
  final Function _newTransactionHandler;

  TransactionNew(this._newTransactionHandler);

  @override
  _TransactionNewState createState() => _TransactionNewState();
}

class _TransactionNewState extends State<TransactionNew> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _pickedDate;

  void _onSubmitted() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || (enteredAmount <= 0) || (_pickedDate == null)) {
      return;
    } else {
      this
          .widget
          ._newTransactionHandler(enteredTitle, enteredAmount, _pickedDate);
    }
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019, 1, 1),
            lastDate: DateTime(2020, 12, 31))
        .then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          this._pickedDate = pickedDate;
        });
      }
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Card(
          child: Container(
            margin: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: _titleController,
                  onSubmitted: (_) => _onSubmitted(),
                  // onChanged: (value) {
                  //   // this.titleInput = value;
                  // },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: _amountController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onSubmitted: (_) => _onSubmitted(),
                ),
                Container(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text((this._pickedDate == null)
                          ? 'No Date Chosen!'
                          : 'Picked Date: ${DateFormat.yMd().format(this._pickedDate)}'),
                      AdaptiveFlatButton(
                          'Choose Date', this._presentDatePicker),
                    ],
                  ),
                ),
                RaisedButton(
                  child: Text('Add Transaction'),
                  onPressed: _onSubmitted,
                  textColor: Theme.of(context).textTheme.button.color,
                  color: Theme.of(context).primaryColor,
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.end,
            ),
          ),
          elevation: 5,
        ),
      ),
    );
  }
}
