import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/presentation/bloc/package_form/packageform_bloc.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:kurztrip_ma/src/presentation/kurztrip_icons_icons.dart';
import 'package:kurztrip_ma/src/presentation/widgets/RoundedButton.dart';
import 'package:kurztrip_ma/src/presentation/widgets/RoundedInputField.dart';
import 'package:google_maps_webservice/places.dart';

class PackageForm extends StatefulWidget {
  final int? edit;

  const PackageForm({Key? key, this.edit}) : super(key: key);
  @override
  _PackageFormState createState() => _PackageFormState(edit);
}

class _PackageFormState extends State<PackageForm> {
  _PackageFormState(int? edit) {
    bloc = getIt<PackageformBloc>(param1: edit);
  }
  PackageformBloc? bloc;
  final _globalKey = GlobalKey<FormState>();
  final TextEditingController mapsController = TextEditingController();
  Prediction? prediction;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider<PackageformBloc>(
        create: (context) => bloc!,
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
                  Text("paquete guardado correctamente"),
                  Icon(Icons.check),
                ],
              ),
              key: ValueKey(0),
            );
          } else if (state is PackageformShowing) {
            mapsController.text = state.address;
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
                      state.error == null
                          ? Container()
                          : Text(
                              state.error!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .apply(color: Colors.red),
                            ),
                      RoundedInputField(
                        iconColor: Theme.of(context).accentColor,
                        hintText: 'Destino',
                        icon: KurztripIcons.map,
                        controller: mapsController,
                        onTap: (fieldContext) async {
                          prediction = await PlacesAutocomplete.show(
                            startText: mapsController.text,
                            context: fieldContext,
                            apiKey: mapsApiKey,
                            mode: Mode.overlay,
                            onError: (response) {},
                            language: "es",
                            types: [],
                            components: [Component(Component.country, "co")],
                            strictbounds: false,
                            hint: "Destino",
                          );
                          if (prediction != null) {
                            mapsController.text = prediction!.description!;
                            bloc!.add(UpdateAddress(prediction!.description));
                          }
                        },
                      ),
                      RoundedInputField(
                        iconColor: Theme.of(context).accentColor,
                        hintText: 'Destinatario',
                        initialValue: state.receiver,
                        icon: KurztripIcons.id_card,
                        onChanged: (value) => bloc!.add(UpdateReceiver(value)),
                      ),
                      RoundedInputField(
                        iconColor: Theme.of(context).accentColor,
                        hintText: 'D.I del destinatario',
                        initialValue: state.receiverID,
                        icon: KurztripIcons.di,
                        onChanged: (value) =>
                            bloc!.add(UpdateReceiverId(value)),
                      ),
                      RoundedInputField(
                        iconColor: Theme.of(context).accentColor,
                        hintText: 'Peso',
                        icon: KurztripIcons.weight,
                        initialValue: state.weight == null
                            ? null
                            : state.weight.toString(),
                        textInputType: TextInputType.number,
                        onChanged: (value) =>
                            bloc!.add(UpdateWeight(double.parse(value))),
                      ),
                      RoundedInputField(
                        iconColor: Theme.of(context).accentColor,
                        hintText: 'Volumen',
                        icon: KurztripIcons.size_1,
                        textInputType: TextInputType.number,
                        initialValue: state.volume == null
                            ? null
                            : state.volume.toString(),
                        onChanged: (value) =>
                            bloc!.add(UpdateVolume(double.parse(value))),
                      ),
                      RoundedInputField(
                        iconColor: Theme.of(context).accentColor,
                        hintText: 'Centro de acopio',
                        icon: KurztripIcons.warehouse,
                        textInputType: TextInputType.number,
                        initialValue: state.warehouse == null
                            ? null
                            : state.warehouse.toString(),
                        onChanged: (value) =>
                            bloc!.add(UpdateWarehouse(int.parse(value))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RoundedButton(
                          onPressed: () async {
                            if (_globalKey.currentState!.validate()) {
                              bloc!.add(Submit());
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
