// Widgets
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  // Properties
  String text;
  Function datePickerHandler;

  // Constructor
  AdaptiveFlatButton(this.text, this.datePickerHandler);

  // Stateless Build Widget
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: datePickerHandler)
        : FlatButton(
            textColor: Theme.of(context).primaryColor,
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: datePickerHandler,
          );
  }
}
