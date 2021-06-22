// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:first_app/Screens/HomePage.dart';
import 'package:first_app/Screens/FormSubmit.dart';
import 'package:first_app/Screens/LoadingPage.dart';
import 'package:first_app/Screens/ResultsPage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'MemSqueezer',
      initialRoute: "/home",

      routes: <String, WidgetBuilder> {
        "/home": (context) => HomePage(),
        "/form": (context) => FormSubmit(),
        "/loadingPage": (context) => LoadingPage(),
        "/resultsPage": (context) => ResultsPage(),
      }
    );
  }
}