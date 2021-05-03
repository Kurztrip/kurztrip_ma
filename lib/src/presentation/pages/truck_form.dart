import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/presentation/bloc/truck_form/truckform_bloc.dart';
import 'package:kurztrip_ma/src/presentation/kurztrip_icons_icons.dart';
import 'package:kurztrip_ma/src/presentation/widgets/RoundedButton.dart';
import 'package:kurztrip_ma/src/presentation/widgets/RoundedInputField.dart';

class TruckForm extends StatefulWidget {
  final int edit;

  const TruckForm({Key key, this.edit}) : super(key: key);
  @override
  _TruckFormState createState() => _TruckFormState();
}

class _TruckFormState extends State<TruckForm> {
  final TruckformBloc bloc = getIt();
  final _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider<TruckformBloc>(
        create: (context) => bloc,
        child: BlocBuilder<TruckformBloc, TruckformState>(
            builder: (context, snapshot) {
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
                      child: Text('Añadir camión',
                          style: Theme.of(context).textTheme.headline2),
                    ),
                    RoundedInputField(
                      iconColor: Theme.of(context).accentColor,
                      hintText: 'Placa',
                      icon: Icons.directions_bus,
                      onChanged: (value) => bloc.add(UpdateRegister(value)),
                    ),
                    RoundedInputField(
                      iconColor: Theme.of(context).accentColor,
                      hintText: 'Capacidad de carga',
                      icon: KurztripIcons.weight,
                      textInputType: TextInputType.number,
                      onChanged: (value) =>
                          bloc.add(UpdateWeightCapacity(double.parse(value))),
                    ),
                    RoundedInputField(
                      iconColor: Theme.of(context).accentColor,
                      hintText: 'Capacidad de volumen',
                      icon: KurztripIcons.size,
                      textInputType: TextInputType.number,
                      onChanged: (value) =>
                          bloc.add(UpdateVolumeCapacity(double.parse(value))),
                    ),
                    RoundedInputField(
                      iconColor: Theme.of(context).accentColor,
                      hintText: 'Capacidad de combustible',
                      icon: KurztripIcons.capacity,
                      textInputType: TextInputType.number,
                      onChanged: (value) =>
                          bloc.add(UpdateFuelCapacity(double.parse(value))),
                    ),
                    RoundedInputField(
                      iconColor: Theme.of(context).accentColor,
                      hintText: 'Tipo de combustible',
                      icon: KurztripIcons.fuel,
                      onChanged: (value) => bloc.add(UpdateFuelType(value)),
                    ),
                    RoundedInputField(
                      iconColor: Theme.of(context).accentColor,
                      hintText: 'Combustible/Km',
                      icon: KurztripIcons.growth,
                      textInputType: TextInputType.number,
                      onChanged: (value) =>
                          bloc.add(UpdateFuelPerKilometer(double.parse(value))),
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
                          _globalKey.currentState.validate();
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
