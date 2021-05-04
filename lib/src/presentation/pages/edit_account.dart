import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurztrip_ma/src/domain/entities/count/User.dart';
import 'package:kurztrip_ma/src/presentation/bloc/account_page_bloc/account_page_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/account_page_bloc/account_page_event.dart';
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
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider<EditAccountBloc>(
        create: (context) => bloc,
        child: BlocBuilder<EditAccountBloc, EditAccountState>(
          builder: (context, state) {
            if (state is EditShowing) {
              EditShowing fields = state as EditShowing;
              return SingleChildScrollView(
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
                            onPressed: () {
                              _submit(User(
                                  id: null,
                                  name: state.name,
                                  lastName: state.lastname,
                                  email: state.email,
                                  cellphone: state.cellphone,
                                  rol: null,
                                  createAt: null,
                                  password: null,
                                  organization: null,
                                  notifications: null));
                            },
                            text: 'Guardar'),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is SavingData) {
              return const Center(
                child: const CircularProgressIndicator(),
                key: ValueKey(0),
              );
            } else if (state is ErrorOccurredWhileSaving) {
              return Center(
                child: Text(
                  "Ha ocurrido un error: ${state.message}",
                ),
              );
            } else if (state is SavingSuccess) {
              return Center(
                child: Text(
                  "Se ha guardado la información exitosamente!",
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }

  void _submit(User user) {
    if (_formKey.currentState.validate()) {
      bloc.add(SendNewData(user: user));
    }
  }
}
