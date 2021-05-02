import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/presentation/bloc/package_form/packageform_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/package_list/package_list_bloc.dart';
import 'package:kurztrip_ma/src/presentation/kurztrip_icons_icons.dart';
import 'package:kurztrip_ma/src/presentation/widgets/RoundedButton.dart';
import 'package:kurztrip_ma/src/presentation/widgets/RoundedInputField.dart';

class PackageForm extends StatefulWidget {
  @override
  _PackageFormState createState() => _PackageFormState();
}

class _PackageFormState extends State<PackageForm> {
  final PackageformBloc bloc = getIt();
  final _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider<PackageformBloc>(
        create: (context) => bloc,
        child: BlocBuilder<PackageformBloc, PackageformState>(
            builder: (context, state) {
          if (state is PackageformLoading) {
            return const Center(
              child: const CircularProgressIndicator(),
              key: ValueKey(0),
            );
          } else if (state is PackageformSuccess) {
            Future.delayed(Duration(seconds: 2), () async {
              Navigator.of(context).pop();
            });
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("paquete creado correctamente"),
                  Icon(Icons.check),
                ],
              ),
              key: ValueKey(0),
            );
          } else if (state is PackagelistError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Ha ocurrido un error al obtener los paquetes"),
                  Icon(Icons.replay_outlined),
                ],
              ),
              key: ValueKey(0),
            );
          }
          return SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Form(
                key: _globalKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text('Añadir paquete',
                          style: Theme.of(context).textTheme.headline2),
                    ),
                    RoundedInputField(
                      iconColor: Theme.of(context).accentColor,
                      hintText: 'Destino',
                      icon: KurztripIcons.map,
                      onChanged: (value) => bloc.add(UpdateAddress(value)),
                    ),
                    RoundedInputField(
                      iconColor: Theme.of(context).accentColor,
                      hintText: 'Destinatario',
                      icon: KurztripIcons.id_card,
                      onChanged: (value) => bloc.add(UpdateReceiver(value)),
                    ),
                    RoundedInputField(
                      iconColor: Theme.of(context).accentColor,
                      hintText: 'D.I del destinatario',
                      icon: KurztripIcons.di,
                      onChanged: (value) => bloc.add(UpdateReceiverId(value)),
                    ),
                    RoundedInputField(
                      iconColor: Theme.of(context).accentColor,
                      hintText: 'Peso',
                      icon: KurztripIcons.weight,
                      textInputType: TextInputType.number,
                      onChanged: (value) =>
                          bloc.add(UpdateWeight(double.parse(value))),
                    ),
                    RoundedInputField(
                      iconColor: Theme.of(context).accentColor,
                      hintText: 'Volumen',
                      icon: KurztripIcons.size_1,
                      textInputType: TextInputType.number,
                      onChanged: (value) =>
                          bloc.add(UpdateVolume(double.parse(value))),
                    ),
                    RoundedInputField(
                      iconColor: Theme.of(context).accentColor,
                      hintText: 'Centro de acopio',
                      icon: KurztripIcons.warehouse,
                      textInputType: TextInputType.number,
                      onChanged: (value) =>
                          bloc.add(UpdateWarehouse(int.parse(value))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RoundedButton(
                        onPressed: () {
                          if (_globalKey.currentState.validate()) {
                            bloc.add(Submit());
                          }
                        },
                        text: 'GUARDAR',
                        verticalPadding: 10,
                        horizontalPadding: 20,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
