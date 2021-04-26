import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kurztrip_ma/src/presentation/widgets/RoundedInputField.dart';


class _HomePageState extends State<HomePage> {
  double _width = 0;
  double _opacity = 0;
  bool _open = false;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
    Size size= MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(flex: 3,),
              Image(
                image: AssetImage('assets/label_logo.png'),
                height: size.height*0.25,
                fit: BoxFit.fitHeight,
              ),
              Spacer(),
              Text(
                'LAS MEJORES RUTAS PARA TUS ENTREGAS',
                style: Theme.of(context).textTheme.subtitle2,
                textAlign: TextAlign.center,
              ),
              Spacer(flex: 2,),

              AnimatedOpacity(
                opacity: _opacity,
                duration: Duration(milliseconds: 900),
                child: AnimatedContainer(
                  width: _width,
                  duration: Duration(seconds: 1),
                  child: Form(
                    child: Column(
                        children: <Widget>[
                          RoundedInputField(
                            hintText: 'Usuario',
                            iconColor: Theme.of(context).colorScheme.onBackground,
                          ),
                          RoundedInputField(
                            hintText: 'Contraseña',
                            icon: Icons.lock,
                            iconColor: Theme.of(context).colorScheme.onBackground,
                          ),
                        ]),
                  ),
                ),
              ),
              Spacer(flex: 2,),
              ElevatedButton(
                onPressed: _incrementCounter,
                child: Text(
                  'INICIAR\nSESIÓN',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primaryVariant),
                  elevation: MaterialStateProperty.all<double>(5.0),
                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 60,vertical: 5)),
                ),
              ),
              TextButton(
                  onPressed: _incrementCounter,
                  child: Text(
                    'Regístrate',
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontFamily: 'Kameron'
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
  void _incrementCounter(){
    setState(() {
      if(_open){
        _width = 0;
        _opacity = 0;
      }else{
        _width=MediaQuery.of(context).size.width;
        _opacity = 1;
      }
      _open = !_open;
    });
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();


}
