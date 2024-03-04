import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostBtn extends StatefulWidget {
  const PostBtn({super.key, required this.btnName, required this.btnFunction,required this.isPhoneVerified});
  final String btnName;
  final void Function() btnFunction;
  final bool isPhoneVerified;

  @override
  State<PostBtn> createState() => _PostBtnState();
}



class _PostBtnState extends State<PostBtn> {


  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height/13,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: widget.isPhoneVerified ? Color(0xFF0066FF) : Colors.grey
        ),
        child: TextButton(
          onPressed: widget.isPhoneVerified ? widget.btnFunction : null,
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(16),
          ),
          child: Text(widget.btnName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      );
    }
  }
