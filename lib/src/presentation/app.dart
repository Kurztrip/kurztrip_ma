import 'package:flutter/material.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/domain/entities/truck/Truck.dart';
import 'package:kurztrip_ma/src/domain/repositories/truck_repository.dart';
import 'package:kurztrip_ma/src/presentation/pages/homepage.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
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
        brightness:Brightness.dark,
        textTheme: TextTheme(
          subtitle1: TextStyle(
            fontSize: 20,
            // color: Color(0xFFFFFBFA),
              color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.w600
          ),
          subtitle2: TextStyle(
              fontSize: 16,
              // color: Color(0xFFFFFBFA),
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.w600
          ),
          bodyText1: TextStyle(
            fontSize: 16
          )
        )
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _id = 0;
  int _warehouse = 0;
  TruckRepository _rep;
  Future<void> _getTruck() async {
    Truck truck = await _rep.get(10);
    setState(() {
      _id = truck.id;
      _warehouse = truck.warehouse;
    });
  }

  void _incrementCounter() {
    _getTruck();
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    _rep = getIt();
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text('id: $_id'),
            Divider(),
            Text('warehouse: $_warehouse'),
            ElevatedButton(onPressed: _incrementCounter, child: Text('Obtener camion'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _homePage,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  void _homePage(){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return HomePage();
      })
    );
  }
}
