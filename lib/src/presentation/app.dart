import 'package:flutter/material.dart';
import 'pages/pages.dart';

class MobileApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kurztrip Mobile App',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(85, 73, 166, 1),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FirstPage(),
        '/second': (context) => SecondPage(),
      },
    );
  }
}
