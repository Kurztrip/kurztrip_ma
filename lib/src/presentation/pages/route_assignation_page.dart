import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/presentation/bloc/route_assignation_page_bloc/bloc/route_assignation_page_bloc.dart';
import 'package:kurztrip_ma/src/presentation/widgets/RoundedButton.dart';

class RouteAssignationPage extends StatelessWidget {
  const RouteAssignationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RouteAssignationPageBloc? bloc = getIt();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
            child: Text(
              'Crear ruta',
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
            child: BlocProvider<RouteAssignationPageBloc>(
              create: (context) => bloc,
              child: BlocBuilder<RouteAssignationPageBloc,
                  RouteAssignationPageState>(
                builder: (context, state) {
                  if (state is DataFetched) {
                    return Column(
                      children: [
                        Text(
                          'Seleccionar un centro de distribución',
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.center,
                        ),
                        Divider(),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: SingleChildScrollView(
                            child: Column(
                              children: state.distributionCenters!
                                  .asMap()
                                  .map((index, value) => MapEntry(
                                        index,
                                        ListTile(
                                          title: Text(value.address!),
                                          leading: Radio<int>(
                                            value: index,
                                            groupValue: state.dcIndex,
                                            onChanged: (int? newIndex) => context
                                                .read<
                                                    RouteAssignationPageBloc>()
                                                .add(RadioButtonSelected(
                                                    index: newIndex)),
                                          ),
                                        ),
                                      ))
                                  .values
                                  .toList(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: RoundedButton(
                              horizontalPadding: 30,
                              verticalPadding: 10,
                              onPressed: () => context
                                  .read<RouteAssignationPageBloc>()
                                  .add(AssignButtonPressed(state
                                      .routes![state.routeIndex].truck_id!)),
                              text: 'Crear Ruta'),
                        ),
                      ],
                    );
                  } else if (state is ShowingErrorMessage) {
                    return Center(
                      child: Column(
                        children: [
                          Text(
                            "Ha ocurrido un error: ${state.message}",
                          ),
                          IconButton(
                            icon: Icon(Icons.replay_outlined),
                            onPressed: () => context
                                .read<RouteAssignationPageBloc>()
                                .add(StartFetching()),
                          ),
                        ],
                      ),
                    );
                  } else if (state is Success) {
                    Future.delayed(Duration(seconds: 2), () async {
                      Navigator.of(context).pop();
                    });
                    return Center(
                        child: Text('Ruta ha sido creada exitosamente'));
                  } else {
                    if (state is RouteassignationpageInitial)
                      context
                          .read<RouteAssignationPageBloc>()
                          .add(StartFetching());
                    return const Center(
                      child: const CircularProgressIndicator(),
                      key: ValueKey(0),
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
