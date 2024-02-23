import 'package:flutter/material.dart';

class CustomPopup extends StatelessWidget {
  final String title;
  final String content;
  final Function()? onConfirm;
  final Function()? onCancel;

  CustomPopup({
    required this.title,
    required this.content,
    this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            if (onCancel != null) {
              onCancel!();
            } else {
              Navigator.of(context).pop();
            }
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (onConfirm != null) {
              onConfirm!();
            } else {
              Navigator.of(context).pop();
            }
          },
          child: Text('Confirm'),
        ),
      ],
    );
  }
}
