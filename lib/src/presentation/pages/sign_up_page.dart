import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/domain/entities/count/User.dart';
import 'package:kurztrip_ma/src/presentation/bloc/sign_up_bloc/signup_bloc.dart';
import 'package:kurztrip_ma/src/presentation/kurztrip_icons_icons.dart';
import 'package:kurztrip_ma/src/presentation/widgets/RoundedButton.dart';
import 'package:kurztrip_ma/src/presentation/widgets/RoundedDropdown.dart';
import 'package:kurztrip_ma/src/presentation/widgets/RoundedInputField.dart';
import 'package:kurztrip_ma/src/presentation/widgets/RoundedPasswordField.dart';

class SignUpPage extends StatefulWidget {
  final User? user;
  const SignUpPage({Key? key, this.user}) : super(key: key);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final SignupBloc? bloc = getIt();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.user != null) {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignupBloc>(
        create: (context) => bloc!,
        child: BlocBuilder<SignupBloc, SignupState>(builder: (context, state) {
          if (state is SignUpSuccess) {
            Future.delayed(Duration(seconds: 2), () async {
              Navigator.pop(context);
            });
            return Scaffold(
                body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Usuario Registrado Correctamente"),
                  Icon(Icons.check),
                ],
              ),
              key: ValueKey(0),
            ));
          }
          if ((state as SignupShowing).error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error al registrar usuario')));
          }
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 60, 0, 16),
                          child: Text(
                            'Registro',
                            style: Theme.of(context).textTheme.headline2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        RoundedInputField(
                          iconColor: Theme.of(context).accentColor,
                          hintText: 'Nombre',
                          icon: KurztripIcons.id_card,
                          textInputType: TextInputType.name,
                          onChanged: (value) => bloc!.add(UpdateName(value)),
                        ),
                        RoundedInputField(
                          icon: KurztripIcons.id_card,
                          iconColor: Theme.of(context).accentColor,
                          hintText: 'Apellido',
                          onChanged: (value) =>
                              bloc!.add(UpdateLastName(value)),
                        ),
                        RoundedInputField(
                          iconColor: Theme.of(context).accentColor,
                          icon: Icons.email,
                          hintText: "Email",
                          textInputType: TextInputType.emailAddress,
                          validator: (value) {
                            if (!RegExp(
                                    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                .hasMatch(value!)) {
                              return 'Este correo electronico es invalido';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) => bloc!.add(UpdateEmail(value)),
                        ),
                        RoundedInputField(
                          iconColor: Theme.of(context).accentColor,
                          hintText: "Celular",
                          icon: Icons.phone,
                          textInputType: TextInputType.phone,
                          onChanged: (value) =>
                              bloc!.add(UpdateCellphone(value)),
                        ),
                        RoundedDropdown(
                          hint: "Elije tu rol",
                          iconColor: Theme.of(context).accentColor,
                          value: (state as SignupShowing).rol,
                          items: <String, IconData>{
                            'Administrador': Icons.supervisor_account,
                            'Conductor': Icons.directions_bus
                          },
                          onChanged: (value) => bloc!.add(UpdateRol(value!)),
                        ),
                        RoundedInputField(
                          iconColor: Theme.of(context).accentColor,
                          hintText: "Usuario",
                          onChanged: (value) =>
                              bloc!.add(UpdateUsername(value)),
                        ),
                        RoundedPasswordField(
                          iconColor: Theme.of(context).accentColor,
                          hintText: "Contrase??a",
                          onChanged: (value) =>
                              bloc!.add(UpdatePassword(value)),
                        ),
                        RoundedPasswordField(
                          iconColor: Theme.of(context).accentColor,
                          hintText: "Confirmar Contrase??a",
                          validator: (value) {
                            if (value != state.password) {
                              return "Las contrase??as no coinciden";
                            } else {
                              return null;
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: RoundedButton(
                              horizontalPadding: 30,
                              verticalPadding: 10,
                              onPressed: _submit,
                              text: 'Crear cuenta'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      bloc!.add(Submit());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Processing Data')));
    }
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
}
