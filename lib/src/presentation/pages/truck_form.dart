import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/presentation/bloc/truck_form/truckform_bloc.dart';
import 'package:kurztrip_ma/src/presentation/kurztrip_icons_icons.dart';
import 'package:kurztrip_ma/src/presentation/widgets/RoundedButton.dart';
import 'package:kurztrip_ma/src/presentation/widgets/RoundedDropdown.dart';
import 'package:kurztrip_ma/src/presentation/widgets/RoundedInputField.dart';

class TruckForm extends StatefulWidget {
  final int edit;

  const TruckForm({Key key, this.edit}) : super(key: key);
  @override
  _TruckFormState createState() => _TruckFormState(this.edit);
}

class _TruckFormState extends State<TruckForm> {
  TruckformBloc bloc = getIt();
  final _globalKey = GlobalKey<FormState>();
  _TruckFormState(int edit) {
    bloc = getIt<TruckformBloc>(param1: edit);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider<TruckformBloc>(
        create: (context) => bloc,
        child: BlocBuilder<TruckformBloc, TruckformState>(
            builder: (context, state) {
          if (state is TruckformLoading) {
            return const Center(
              child: const CircularProgressIndicator(),
              key: ValueKey(0),
            );
          } else if (state is TruckformSuccess) {
            Future.delayed(Duration(seconds: 2), () async {
              Navigator.of(context).pop();
            });
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Caminón guardado correctamente"),
                  Icon(Icons.check),
                ],
              ),
              key: ValueKey(0),
            );
          } else if (state is TruckformShowing) {
            String truckState;
            switch (state.state) {
              case 'InRoute':
                truckState = "En Ruta";
                break;
              case 'Maintenance':
                truckState = "En Mantenimiento";
                break;
              default:
                truckState = "Disponible";
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
                        child: Text('Añadir camión',
                            style: Theme.of(context).textTheme.headline2),
                      ),
                      state.error == null
                          ? Container()
                          : Text(
                              state.error,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .apply(color: Colors.red),
                            ),
                      RoundedInputField(
                        iconColor: Theme.of(context).accentColor,
                        hintText: 'Placa',
                        icon: Icons.directions_bus,
                        initialValue: state.register,
                        onChanged: (value) => bloc.add(UpdateRegister(value)),
                      ),
                      RoundedInputField(
                        iconColor: Theme.of(context).accentColor,
                        hintText: 'Capacidad de carga',
                        initialValue: state.weightCapacity == null
                            ? null
                            : state.weightCapacity.toString(),
                        icon: KurztripIcons.weight,
                        textInputType: TextInputType.number,
                        onChanged: (value) =>
                            bloc.add(UpdateWeightCapacity(double.parse(value))),
                      ),
                      RoundedInputField(
                        iconColor: Theme.of(context).accentColor,
                        hintText: 'Capacidad de volumen',
                        initialValue: state.volumeCapacity == null
                            ? null
                            : state.volumeCapacity.toString(),
                        icon: KurztripIcons.size,
                        textInputType: TextInputType.number,
                        onChanged: (value) =>
                            bloc.add(UpdateVolumeCapacity(double.parse(value))),
                      ),
                      RoundedInputField(
                        iconColor: Theme.of(context).accentColor,
                        hintText: 'Capacidad de combustible',
                        initialValue: state.fuelCapacity == null
                            ? null
                            : state.fuelCapacity.toString(),
                        icon: KurztripIcons.fuel_capacity,
                        textInputType: TextInputType.number,
                        onChanged: (value) =>
                            bloc.add(UpdateFuelCapacity(double.parse(value))),
                      ),
                      RoundedInputField(
                        iconColor: Theme.of(context).accentColor,
                        hintText: 'Combustible disponible(%)',
                        initialValue:
                            state.fuel == null ? null : state.fuel.toString(),
                        icon: KurztripIcons.capacity,
                        textInputType: TextInputType.number,
                        onChanged: (value) =>
                            bloc.add(UpdateFuel(double.parse(value))),
                      ),
                      RoundedDropdown(
                        iconColor: Theme.of(context).accentColor,
                        items: {
                          "Gasolina": KurztripIcons.fuel,
                          "Diesel": KurztripIcons.fuel,
                          "Gas": KurztripIcons.fuel
                        },
                        hint: 'Tipo de combustible',
                        value: state.fuelType,
                        icon: KurztripIcons.fuel,
                        onChanged: (value) => bloc.add(UpdateFuelType(value)),
                      ),
                      RoundedInputField(
                        iconColor: Theme.of(context).accentColor,
                        hintText: 'Combustible/Km',
                        initialValue: state.fuelPerKilometer == null
                            ? null
                            : state.fuelPerKilometer.toString(),
                        icon: KurztripIcons.growth,
                        textInputType: TextInputType.number,
                        onChanged: (value) => bloc
                            .add(UpdateFuelPerKilometer(double.parse(value))),
                      ),
                      RoundedInputField(
                        iconColor: Theme.of(context).accentColor,
                        hintText: 'Centro de acopio',
                        initialValue: state.warehouse == null
                            ? null
                            : state.warehouse.toString(),
                        icon: KurztripIcons.warehouse,
                        textInputType: TextInputType.number,
                        onChanged: (value) =>
                            bloc.add(UpdateWarehouse(int.parse(value))),
                      ),
                      state.state == null
                          ? Container()
                          : RoundedDropdown(
                              iconColor: Theme.of(context).accentColor,
                              items: {
                                "Disponible": Icons.check_circle_rounded,
                                "En Ruta": Icons.alt_route,
                                "En Mantenimiento": Icons.build
                              },
                              hint: 'Estado',
                              value: truckState,
                              icon: KurztripIcons.fuel,
                              onChanged: (value) =>
                                  bloc.add(UpdateState(value)),
                            ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RoundedButton(
                          onPressed: () {
                            if (_globalKey.currentState.validate()) {
                              bloc.add(SubmitTruck());
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
          }
          return Container();
        }),
      ),
    );
  }
}
