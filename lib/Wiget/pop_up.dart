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
        if (onCancel != null) // onCancel 콜백이 제공된 경우에만 취소 버튼을 표시
          TextButton(
            onPressed: () {
              onCancel!();
            },
            child: Text('Cancel'),
          ),
        TextButton(
          onPressed: () {
            onConfirm!();
          },
          child: Text('Confirm'),
        ),
      ],
    );
  }
}
