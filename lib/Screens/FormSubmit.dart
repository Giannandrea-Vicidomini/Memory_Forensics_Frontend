import 'dart:html';
import 'package:first_app/Models/SqueezeRequest.dart';
import 'package:first_app/Widgets/CustomButton.dart';
import 'package:first_app/Widgets/ShadowContainer.dart';
import 'package:first_app/Utils/utils.dart';
import 'package:flutter/material.dart';

import '../Utils/utils.dart';
import '../Utils/utils.dart';
import '../Utils/utils.dart';
import '../Utils/utils.dart';
import '../Utils/utils.dart';

class FormSubmit extends StatefulWidget{
  @override
  _FormSubmitState createState() => _FormSubmitState();
}

enum os {windows, macOS, linux}

class _FormSubmitState extends State<FormSubmit> {

  os selectedOs = os.windows;

  void _handleDropdownValueChanged(os value) {
    setState(() {
      selectedOs = value;
    });
  }

  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();
    SqueezeRequest req = SqueezeRequest.empty();

    RegExp kwRegex = RegExp(r"^([$]*[.@]*(http)*s*[:/]*[A-Za-z1-9]+[.]*[a-zA-Z]*;)+$", multiLine: false);
    RegExp ipRegex = RegExp(r"^(([$]*[.:]*[0-9]{0,3}[\*]?[.:]*)+;)*$", multiLine: false);

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
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: SingleChildScrollView(
              child: Center(
                child:
                  ShadowContainer(

                    child: Container(
                     
                      color: fromHex("#666666"),
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    RichText(text: TextSpan(text: "Target OS:", style: TextStyle(color: fromHex("#00A4CE"), fontSize: 20))),
                                    Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: fromHex("#00A4CE"),),
                                      margin: EdgeInsets.only(left: 12),
                                      padding: EdgeInsets.only(left: 5, right: 5),
                                      width: MediaQuery.of(context).size.width/10,
                                      child: DropdownButtonFormField<os>(
                                        iconEnabledColor: Colors.white,
                                        iconDisabledColor: Colors.white,
                                        dropdownColor: fromHex("#6ED0E9"),
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                                        decoration: InputDecoration(
                                          border: InputBorder.none
                                        ),
                                        value: os.windows,
                                        onChanged: _handleDropdownValueChanged,
                                        onSaved: (newValue) => req.os = newValue.toString().substring(3),
                                        items: [
                                          DropdownMenuItem(
                                            child: Text("Windows"),
                                            value: os.windows,
                                          ),
                                          DropdownMenuItem(
                                            child: Text("macOS"),
                                            value: os.macOS,
                                          ),
                                          DropdownMenuItem(
                                            child: Text("Linux"),
                                            value: os.linux,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: RichText(
                                    textAlign: TextAlign.justify,
                                    text: TextSpan(
                                    style: TextStyle(color: fromHex("#ffffff"), fontSize: 15),
                                    children: [
                                      TextSpan(
                                        text: "inserisci nei form delle parole chiave separate da ';', esse veranno ricercate come stringhe e sottostringhe."
                                      )
                                    ]
                                  )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: RichText(
                                    textAlign: TextAlign.justify,
                                    text: TextSpan(
                                    style: TextStyle(color: fromHex("#ffffff"), fontSize: 15),
                                    children: [
                                      TextSpan(
                                        text: r"Anteponendo '$' ad ogni keyword, esse verranno ricercate esclusivamente come stringhe complete."
                                      )
                                    ]
                                  )),
                                ),
                                Container(padding: const EdgeInsets.all(20),),
                                RichText(
                                  text: TextSpan(
                                    text: "Keywords: ",
                                    style: TextStyle(color: fromHex("#00A4CE"), fontSize: 15),
                                    children: [
                                      TextSpan(
                                        text: "(Processi, file, protocolli, email, domini, header, URL ...)",
                                        style: TextStyle(color: fromHex("#ffffff"), fontSize: 15),
                                      )]
                                  ),
                                ),
                                Container(padding: const EdgeInsets.all(5),),
                                TextFormField(
                                  style: TextStyle(color: fromHex("#222222")),
                                  validator: (str) {
                                    if(!kwRegex.hasMatch(str)) return "Controlla di aver inserito bene i campi";
                                    else return null;
                                  },
                                  onSaved: (newValue) => req.setKeywordsFromString(newValue),
                                  maxLines: 10,
                                  minLines: 5,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(borderSide: BorderSide(color: fromHex("#D5D5D5")))
                                  ),
                                ),
                                Container(padding: const EdgeInsets.all(20),),
                                RichText(
                                  text: TextSpan(
                                    text: "IP addresses: ",
                                    style: TextStyle(color: fromHex("#00A4CE"), fontSize: 15),
                                    children: [
                                      TextSpan(
                                        text: "(Puoi specificare anche solo parte di essi)",
                                        style: TextStyle(color: fromHex("#ffffff"), fontSize: 15),
                                      )]
                                  ),
                                ),
                                Container(padding: const EdgeInsets.all(5),),
                                TextFormField(
                                
                                  style: TextStyle(color: fromHex("#222222")),
                                  onSaved: (newValue) => req.setIpFromString(newValue),
                                  validator: (str) {
                                    if(!ipRegex.hasMatch(str)) return "Controlla di aver inserito bene i campi";
                                    else return null;
                                  },
                                  maxLines: 10,
                                  minLines: 5,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(borderSide: BorderSide(color: fromHex("#D5D5D5")))
                                  ),
                                ),
                                CustomButton(
                                  alignment: Alignment.bottomRight,
                                  child: Text("Procedi", style: TextStyle(fontSize: 22),),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()){
                                      _formKey.currentState.save();
                                      Navigator.pushNamed(context, "/loadingPage",arguments: req);
                                    }
                                  }
                                )
                              ],
                          ),
                        )
                      ),
                    ),
                  ),
              ),
            ),
          )
        ]
      )
    );
  }
}