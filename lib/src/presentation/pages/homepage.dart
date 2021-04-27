import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/presentation/bloc/homepage/homepage_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/homepage/homepage_event.dart';
import 'package:kurztrip_ma/src/presentation/bloc/homepage/homepage_state.dart';
import 'package:kurztrip_ma/src/presentation/widgets/RoundedInputField.dart';

class _HomepageState extends State<Homepage> {
  double _width = 0;
  double _opacity = 0;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    HomepageBloc homepageBloc = getIt();
    return BlocProvider<HomepageBloc>(
        create: (context) => homepageBloc,
        child:
            BlocBuilder<HomepageBloc, HomepageState>(builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Spacer(
                      flex: 3,
                    ),
                    Image(
                      image: AssetImage('assets/label_logo.png'),
                      height: size.height * 0.25,
                      fit: BoxFit.fitHeight,
                    ),
                    Spacer(),
                    Text(
                      'LAS MEJORES RUTAS PARA TUS ENTREGAS',
                      style: Theme.of(context).textTheme.subtitle2,
                      textAlign: TextAlign.center,
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    AnimatedOpacity(
                      opacity: _opacity,
                      duration: Duration(milliseconds: 900),
                      child: AnimatedContainer(
                        width: _width,
                        duration: Duration(seconds: 1),
                        child: Column(children: <Widget>[
                          RoundedInputField(
                            hintText: 'Usuario',
                            iconColor:
                                Theme.of(context).colorScheme.onBackground,
                          ),
                          RoundedInputField(
                            hintText: 'Contraseña',
                            icon: Icons.lock,
                            iconColor:
                                Theme.of(context).colorScheme.onBackground,
                            obscureText: true,
                          ),
                        ]),
                      ),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          state is Home ? _showLogin(context) : _submit(),
                      child: Text(
                        'INICIAR\nSESIÓN',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0))),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).colorScheme.primaryVariant),
                        elevation: MaterialStateProperty.all<double>(5.0),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(horizontal: 60, vertical: 5)),
                      ),
                    ),
                    TextButton(
                        onPressed: () =>
                            state is Home ? _showSignUp : _backHome(context),
                        child: Text(
                          state is Home ? 'Regístrate' : 'Atrás',
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontFamily: 'Kameron'),
                        )),
                    Spacer(),
                  ],
                ),
              ),
            ),
          );
        }));
  }

  void _showLogin(BuildContext context) {
    context.read<HomepageBloc>().add(SignInButtonPressed());
    setState(() {
      _width = MediaQuery.of(context).size.width;
      _opacity = 1;
    });
  }

  void _showSignUp() {}
  void _submit() {
    Navigator.pushNamed(context, '/main_page');
  }

  void _backHome(BuildContext context) {
    context.read<HomepageBloc>().add(BackToHome());
    setState(() {
      _width = 0;
      _opacity = 0;
    });
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}
