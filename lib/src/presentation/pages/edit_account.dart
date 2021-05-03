import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurztrip_ma/src/domain/entities/count/User.dart';
import 'package:kurztrip_ma/src/presentation/bloc/edit_account_bloc/edit_account_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/edit_account_bloc/edit_account_event.dart';
import 'package:kurztrip_ma/src/presentation/bloc/edit_account_bloc/edit_account_state.dart';
import 'package:kurztrip_ma/src/presentation/widgets/RoundedButton.dart';
import 'package:kurztrip_ma/src/presentation/widgets/RoundedInputField.dart';

import '../../../services_provider.dart';
import '../kurztrip_icons_icons.dart';

class EditAccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccountPage> {
  final EditAccountBloc bloc = getIt<EditAccountBloc>(
    param1: User(
        name: 'Pepito',
        lastName: 'Perez',
        email: 'correo@mail.com',
        cellphone: '234525647',
        id: 0,
        createAt: null,
        notifications: null,
        organization: null,
        password: null,
        rol: null),
  );
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditAccountBloc>(
      create: (context) => bloc,
      child: BlocBuilder<EditAccountBloc, EditAccountState>(
        builder: (context, state) {
          EditShowing fields = state as EditShowing;
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.1),
                      child: Text(
                        'Editar datos de cuenta',
                        style: Theme.of(context).textTheme.headline3,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    RoundedInputField(
                      iconColor: Theme.of(context).accentColor,
                      hintText: 'Nombre',
                      initialValue: fields.name,
                      icon: KurztripIcons.id_card,
                      textInputType: TextInputType.name,
                      onChanged: (value) => bloc.add(UpdateName(value)),
                    ),
                    RoundedInputField(
                      icon: KurztripIcons.id_card,
                      iconColor: Theme.of(context).accentColor,
                      hintText: 'Apellido',
                      initialValue: fields.lastname,
                      onChanged: (value) => bloc.add(UpdateLastName(value)),
                    ),
                    RoundedInputField(
                      iconColor: Theme.of(context).accentColor,
                      icon: Icons.email,
                      hintText: "Email",
                      initialValue: fields.email,
                      textInputType: TextInputType.emailAddress,
                      validator: (value) {
                        if (!RegExp(
                                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                            .hasMatch(value)) {
                          return 'Este correo electronico es invalido';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) => bloc.add(UpdateEmail(value)),
                    ),
                    RoundedInputField(
                      iconColor: Theme.of(context).accentColor,
                      hintText: "Teléfono",
                      initialValue: fields.cellphone,
                      icon: Icons.phone,
                      textInputType: TextInputType.phone,
                      onChanged: (value) => bloc.add(UpdateCellphone(value)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: RoundedButton(
                          horizontalPadding: 30,
                          verticalPadding: 10,
                          onPressed: _submit,
                          text: 'Guardar'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState.validate()) {
      //Enviar evento al bloc
      Navigator.pop(context);
    }
  }
}
