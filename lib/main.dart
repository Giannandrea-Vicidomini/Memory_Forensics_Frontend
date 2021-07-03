// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:first_app/Screens/HomePage.dart';
import 'package:first_app/Screens/FormSubmit.dart';
import 'package:first_app/Screens/LoadingPage.dart';
import 'package:first_app/Screens/ResultsPage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:window_size/window_size.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle("Digital Forensics Framework");
    //setWindowMinSize(Size(1080, 720));
    //setWindowMaxSize(Size(1200, 1000));
    setWindowFrame(Rect.fromLTRB(100, 100, 1200, 720));
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'DF Framework',
      initialRoute: "/home",
      debugShowCheckedModeBanner: false,

      routes: <String, WidgetBuilder> {
        "/home": (context) => HomePage(),
        "/form": (context) => FormSubmit(),
        "/loadingPage": (context) => LoadingPage(),
        "/resultsPage": (context) => ResultsPage(),
      }
    );
  }
}