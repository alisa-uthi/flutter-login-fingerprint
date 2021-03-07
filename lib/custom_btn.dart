import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final Function onPressed;
  final String text;

  const CustomBtn({
    Key key,
    @required this.onPressed,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // ignore: deprecated_member_use
      child: RaisedButton(
        onPressed: onPressed,
        elevation: 0,
        color: Color(0xFF04A5ED),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 24,
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
