import 'package:first_app/Utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget{

  Function onPressed;
  Widget child;
  Key key;
  Alignment alignment;

  CustomButton({this.child, this.onPressed, this.key, this.alignment});

  
  @override
  _CustomButtonState createState() => _CustomButtonState(child: child, onPressed: onPressed, key: key, alignment: alignment);
}

class _CustomButtonState extends State<CustomButton> {
  Widget child;
  Key key;
  Function onPressed;
  Alignment alignment;

  _CustomButtonState({this.child, this.onPressed,this.key, this.alignment});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      key: key,
      margin: const EdgeInsets.only(top:10, bottom: 10),
      child: ButtonTheme(
        minWidth: 250.0,
        height: 45,
        child: RaisedButton(
          textColor: Colors.white,
          color: fromHex("#00A4CE"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0)
          ),
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: child,
          onPressed: onPressed
        )
      )
    );
  }
}