import 'package:flutter/material.dart';
import 'package:social_app/stream/myStream.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'Utils/global.dart';
import 'Views/RootScreen.dart';

void main() {
  Global.myStream = MyStream();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RootScreen(),
    );
  }
}

