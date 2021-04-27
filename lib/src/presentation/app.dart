import 'package:flutter/material.dart';
import 'pages/pages.dart';

class MobileApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kurztrip Mobile App',
      theme: ThemeData(
          colorScheme: ColorScheme(
            primary: Color(0xFF5549A6),
            primaryVariant: Color(0xFF3E3C73),
            secondary: Color(0xFF4BC6B9),
            secondaryVariant: Color(0xFF00958A),
            background: Color(0xFF1E1E1E),
            onPrimary: Color(0xFFFFFBFA),
            onSecondary: Color(0xFFFFFBFA),
            onBackground: Color(0xFFFFFBFA),
            brightness: Brightness.dark,
            error: Colors.red,
            onError: Color(0xFFFFFBFA),
            surface: Color(0xFF1E1E1E),
            onSurface: Color(0xFFFFFBFA),
          ),
          primaryColor: Color(0xFF5549A6),
          accentColor: Color(0xFF4BC6B9),
          scaffoldBackgroundColor: Color(0xFF1E1E1E),
          backgroundColor: Color(0xFF1E1E1E),
          fontFamily: 'WorkSans',
          brightness: Brightness.dark,
          textTheme: TextTheme(
              subtitle1: TextStyle(
                  fontSize: 20,
                  // color: Color(0xFFFFFBFA),
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w600),
              subtitle2: TextStyle(
                  fontSize: 16,
                  // color: Color(0xFFFFFBFA),
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w600),
              bodyText1: TextStyle(fontSize: 16))),
      initialRoute: '/',
      routes: {
        '/': (context) => Homepage(),
        '/main_page': (context) => MainPage(),
        '/first': (context) => FirstPage(),
        '/second': (context) => SecondPage(),
        '/test': (context) => MyHomePage(
              title: "test Homepage",
            ),
      },
    );
  }
}
