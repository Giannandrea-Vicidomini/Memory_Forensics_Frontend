import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShadowContainer extends StatefulWidget{
  
  Widget child;

  ShadowContainer({@required this.child});

  @override
  _ShadowContainerState createState() => _ShadowContainerState(child);
}

class _ShadowContainerState extends State<ShadowContainer> {
    Widget child;

  _ShadowContainerState(this.child);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 9,
              blurRadius: 3,
              offset: Offset(0, 5),
            )
          ]
        ),
        child: child,
      ),
    );
  }
}