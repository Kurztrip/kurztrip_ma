import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/presentation/bloc/homepage/homepage_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/homepage/homepage_event.dart';
import 'package:kurztrip_ma/src/presentation/bloc/homepage/homepage_state.dart';
import 'package:kurztrip_ma/src/presentation/pages/main_page.dart';
import 'package:kurztrip_ma/src/presentation/pages/sign_up_page.dart';
import 'package:kurztrip_ma/src/presentation/widgets/RoundedButton.dart';
import 'package:kurztrip_ma/src/presentation/widgets/RoundedInputField.dart';
import 'package:kurztrip_ma/src/presentation/widgets/RoundedPasswordField.dart';

class _HomepageState extends State<Homepage> {
  double _width = 0;
  double _opacity = 0;
  final _globalKey = GlobalKey<FormState>();
  final HomepageBloc? homepageBloc = getIt();
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider<HomepageBloc>(
        create: (context) => homepageBloc!,
        child:
            BlocBuilder<HomepageBloc, HomepageState>(builder: (context, state) {
          if (state is LoginDone) {
            Future.delayed(Duration(seconds: 1), () {
              Navigator.pushReplacement(context, _createRoute(MainPage()));
            });
          }
          return WillPopScope(
            onWillPop: () async {
              if (state is Home) {
                return true;
              } else {
                _backHome(context);
                return false;
              }
            },
            child: Scaffold(
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Spacer(
                      flex: 3,
                    ),
                    Image(
                      height: MediaQuery.of(context).viewInsets.bottom > 0
                          ? size.height * 0.15
                          : size.height * 0.25,
                      image: AssetImage('assets/label_logo.png'),
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
                        child: Form(
                          key: _globalKey,
                          child: Column(children: <Widget>[
                            state is SignInState && state.error != null
                                ? Text(
                                    'Correo o Contraseña invalidos',
                                    style: TextStyle(color: Colors.red),
                                  )
                                : Container(),
                            RoundedInputField(
                                hintText: 'Email',
                                iconColor:
                                    Theme.of(context).colorScheme.onBackground,
                                onChanged: (value) => context
                                    .read<HomepageBloc>()
                                    .add(UpdateUser(value)),
                                textInputType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (!RegExp(
                                          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                      .hasMatch(value)) {
                                    return 'Email invalido';
                                  } else {
                                    return null;
                                  }
                                }),
                            RoundedPasswordField(
                              hintText: 'Contraseña',
                              iconColor:
                                  Theme.of(context).colorScheme.onBackground,
                              onChanged: (value) => context
                                  .read<HomepageBloc>()
                                  .add(UpdatePassword(value)),
                            ),
                          ]),
                        ),
                      ),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    RoundedButton(
                      onPressed: () =>
                          state is Home ? _showLogin(context) : _submit(),
                      text: 'INICIAR\nSESIÓN',
                    ),
                    TextButton(
                        onPressed: () =>
                            state is Home ? _showSignUp() : _backHome(context),
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
      _globalKey.currentState!.reset();
      _width = MediaQuery.of(context).size.width;
      _opacity = 1;
    });
  }

  Route _createRoute(Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  void _showSignUp() {
    Navigator.push(context, _createRoute(SignUpPage()));
  }

  void _submit() {
    if (_globalKey.currentState!.validate()) homepageBloc!.add(SignIn());
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
