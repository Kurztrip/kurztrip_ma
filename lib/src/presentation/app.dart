import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/pages.dart';

class MobileApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var mySystemTheme = SystemUiOverlayStyle.light
        .copyWith(systemNavigationBarColor: Color(0xFF1E1E1E));
    SystemChrome.setSystemUIOverlayStyle(mySystemTheme);
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
              headline1:
                  TextStyle(color: Color(0xFF5549A6), fontFamily: 'Teko'),
              headline2:
                  TextStyle(color: Color(0xFF5549A6), fontFamily: 'Teko'),
              headline3:
                  TextStyle(color: Color(0xFF5549A6), fontFamily: 'Teko'),
              headline4:
                  TextStyle(color: Color(0xFF5549A6), fontFamily: 'Teko'),
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
        '/truck_form': (context) => TruckForm(),
        '/package_form': (context) => PackageForm(),
        '/db_center_form': (context) => DBCenterFormPage(),
        '/edit_account': (context) => EditAccountPage(),
        '/route_addition_page': (context) => RouteAdditionPage(),
      },
    );
  }
}
