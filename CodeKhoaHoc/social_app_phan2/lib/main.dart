import 'package:flutter/material.dart';
import 'package:social_app/stream/myStream.dart';

import 'Utils/global.dart';
import 'Views/RootScreen.dart';

void main() {
  Global.myStream = MyStream();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RootScreen(),
    );
  }
}

