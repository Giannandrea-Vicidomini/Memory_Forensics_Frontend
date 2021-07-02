//import 'dart:js';

import 'package:first_app/Widgets/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:first_app/Utils/utils.dart';

class HomePage extends StatelessWidget {

  HomePage({
    Key key,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/BackgroundHomeAlt.png"),
                fit:BoxFit.fill
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 100, top: 100),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(
                      "Benvenuto",
                      style: TextStyle(
                        color: fromHex("#ffffff"),
                        fontSize: 35,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: fromHex("#aaaaaa"),
                          fontSize: 30
                        ),
                        text: "Questo è",
                        children: <TextSpan> [
                          TextSpan(text:" ", style: TextStyle(color: fromHex("#ffffff"), fontSize: 30)),
                          TextSpan(text:" il tuo tool di", style: TextStyle(color: fromHex("#aaaaaa"), fontSize: 30)),
                        ]
                      )
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: fromHex("#aaaaaa"),
                          fontSize: 30
                        ),
                        text: "Memory Forensics sul tuo desktop!"
                      )
                    ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:10),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: fromHex("#929292"),
                          fontSize: 20
                        ),
                        text: ""
                      )
                    )
                  ),
                  CustomButton(
                    child: Text("Inizia!", style: TextStyle(fontSize: 22),),
                    onPressed: () => Navigator.pushNamed(context, "/form"),
                    
                  )
                ],
              )
            )
          )
        ],
      )
    );
  }
}