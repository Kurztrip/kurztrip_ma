import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:kurztrip_ma/src/domain/entities/distribution_center/DistributionCenter.dart';
import 'package:kurztrip_ma/src/presentation/bloc/db_center_form_bloc/db_center_form_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/db_center_form_bloc/db_center_form_event.dart';
import 'package:kurztrip_ma/src/presentation/bloc/db_center_form_bloc/db_center_form_state.dart';
import 'package:kurztrip_ma/src/presentation/widgets/RoundedButton.dart';
import 'package:kurztrip_ma/src/presentation/widgets/RoundedInputField.dart';

import '../../../services_provider.dart';
import '../kurztrip_icons_icons.dart';

class DBCenterFormPage extends StatefulWidget {
  final DistributionCenter edit;

  const DBCenterFormPage({Key key, this.edit}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DBCenterFormState();
}

class _DBCenterFormState extends State<DBCenterFormPage> {
  final DBCenterFormBloc bloc = getIt();
  final _globalKey = GlobalKey<FormState>();
  final TextEditingController mapsController = TextEditingController();
  Prediction prediction;

  @override
  void initState() {
    if (widget.edit != null) {
      bloc.add(DBCenterFormAutofill(
        widget.edit,
      ));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider<DBCenterFormBloc>(
        create: (context) => bloc,
        child: BlocBuilder<DBCenterFormBloc, DBCenterFormState>(
          builder: (contex, state) {
            if (state is DBCenterFormLoading) {
              return const Center(
                child: const CircularProgressIndicator(),
                key: ValueKey(0),
              );
            } else if (state is DBCenterFormSuccess) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Centro de Operaciones creado correctamente"),
                    Icon(Icons.check),
                  ],
                ),
                key: ValueKey(0),
              );
            } else if (state is DBCenterFormShowing) {
              return SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Form(
                    key: _globalKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.1),
                          child: Text('Añadir Centro de Operaciones',
                              style: Theme.of(context).textTheme.headline3),
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
                          hintText: 'Dirección',
                          icon: KurztripIcons.map,
                          initialValue:
                              widget.edit != null ? widget.edit.address : null,
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
                              hint: "Dirección",
                            );
                            if (prediction != null) {
                              mapsController.text = prediction.description;
                              bloc.add(UpdateAddress(prediction.description));
                            }
                          },
                        ),
                        RoundedInputField(
                          iconColor: Theme.of(context).accentColor,
                          hintText: 'Espacio Total de Almacenamiento',
                          textInputType: TextInputType.number,
                          initialValue: widget.edit != null
                              ? widget.edit.total_space.toString()
                              : null,
                          icon: Icons.disc_full,
                          onChanged: (value) =>
                              bloc.add(UpdateTotalStorage(double.parse(value))),
                        ),
                        RoundedInputField(
                          iconColor: Theme.of(context).accentColor,
                          hintText: 'Espacio libre de Almacenamiento',
                          textInputType: TextInputType.number,
                          initialValue: widget.edit != null
                              ? widget.edit.total_space.toString()
                              : null,
                          icon: Icons.disc_full_outlined,
                          onChanged: (value) => bloc
                              .add(UpdateAvailableStorage(double.parse(value))),
                        ),
                        Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.1),
                          child: RoundedButton(
                            onPressed: () async {
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
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
