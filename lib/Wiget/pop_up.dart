import 'package:flutter/material.dart';

class CustomPopup extends StatelessWidget {
  final String? title;
  final String content;
  final String confirmText;
  final Function()? onConfirm;
  final Function()? onCancel;

  CustomPopup({
    this.title,
    required this.content,
    required this.confirmText,
    this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: SingleChildScrollView( // Added SingleChildScrollView to make content scrollable
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 334, // Minimum width
            minHeight: 203, // Minimum height
          ),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min, // To allow vertical size to be as small as possible
              children: [
                Container(
                  // decoration: BoxDecoration(
                  //     border: Border.all()
                  // ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min, //
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          if (title != null) // Title이 존재할 경우에만 표시
                            Container(
                                width: MediaQuery.of(context).size.width*0.6,
                                alignment: Alignment.center,
                                // decoration: BoxDecoration(
                                //     border: Border.all()
                                // ),
                                child: Text(title!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                          if (onCancel != null)
                            Container(
                              width: MediaQuery.of(context).size.width*0.1,
                              alignment: Alignment.centerRight,
                              // decoration: BoxDecoration(
                              //     border: Border.all()
                              // ),
                              child: IconButton(
                                icon: Icon(Icons.close,size: 28,),
                                onPressed: onCancel,
                              ),
                            ),
                        ],
                      ),
                      // SizedBox(height: 12), // 추가한 공간
                      Text(content, style: TextStyle(fontSize: 16,),textAlign: TextAlign.center,),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: onConfirm,
                        child: Text(confirmText, style: TextStyle(fontSize: 16)),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16), // Added padding for better touch area
                          backgroundColor: Color(0xFF0066FF),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
