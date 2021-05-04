import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/presentation/bloc/account_page_bloc/account_page_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/account_page_bloc/account_page_event.dart';
import 'package:kurztrip_ma/src/presentation/bloc/account_page_bloc/account_page_state.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AccountPageBloc bloc = getIt();
    return BlocProvider<AccountPageBloc>(
      create: (context) => bloc,
      child: BlocBuilder<AccountPageBloc, AccountPageState>(
        builder: (context, state) {
          if (state is FetchingAccountInfo) {
            context.read<AccountPageBloc>().add(StartFetching());
            return const Center(
              child: const CircularProgressIndicator(),
              key: ValueKey(0),
            );
          } else if (state is ShowingAccountInfo) {
            return Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    radius: MediaQuery.of(context).size.width * 0.12,
                    child: Icon(
                      Icons.person_sharp,
                      size: MediaQuery.of(context).size.width * 0.2,
                    ),
                  ),
                ),
                Text(state.user.email),
                Text(state.user.rol),
                Divider(),
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Nombre: ${state.user.name}'),
                      Text('Apellido: ${state.user.lastName}'),
                      Text('Correo: ${state.user.email}'),
                      Text('Telefono: ${state.user.cellphone}'),
                    ],
                  ),
                ),
                Divider(),
                ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0))),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/edit_account");
                    },
                    child: Text('Editar Información')),
                ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0))),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/db_center_form');
                    },
                    child: Text('Crear Centro de Distribución')),
                OutlinedButton.icon(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0))),
                  ),
                  onPressed: () {
                    return showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: Text(
                                'Cerrar Sesión',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                              content: Text('Estas seguro?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  },
                                  child: Text(
                                    'CANCELAR',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    // agregar evento al bloc de cerrar sesión.
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil('/',
                                            (Route<dynamic> route) => false);
                                  },
                                  child: Text(
                                    'ACEPTAR',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ));
                  },
                  icon: Icon(Icons.logout),
                  label: Text('Cerrar Sesión'),
                ),
              ],
            );
          } else if (state is ErrorState) {
            return Center(
              child: Column(
                children: [
                  Text(
                    "Ha ocurrido un error: ${state.message}",
                  ),
                  IconButton(
                    icon: Icon(Icons.replay_outlined),
                    onPressed: () =>
                        context.read<AccountPageBloc>().add(StartFetching()),
                  ),
                ],
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
