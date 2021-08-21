import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/presentation/bloc/route_addition_bloc/route_addition_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/route_addition_bloc/route_addition_event.dart';
import 'package:kurztrip_ma/src/presentation/bloc/route_addition_bloc/route_addition_state.dart';
import 'package:kurztrip_ma/src/presentation/widgets/RoundedButton.dart';

class RouteAdditionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RouteAdditionBloc? bloc = getIt();
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
            child: BlocProvider<RouteAdditionBloc>(
              create: (context) => bloc,
              child: BlocBuilder<RouteAdditionBloc, RouteAdditionState>(
                builder: (context, state) {
                  if (state is FetchingList || state is CreatingRoute) {
                    if (state is FetchingList) {
                      context.read<RouteAdditionBloc>().add(StartFetching());
                    }
                    return const Center(
                      child: const CircularProgressIndicator(),
                      key: ValueKey(0),
                    );
                  } else if (state is ShowingDBCenterList) {
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
                              children: state.dbList!
                                  .asMap()
                                  .map((index, value) => MapEntry(
                                        index,
                                        ListTile(
                                          title: Text(value.address!),
                                          leading: Radio<int>(
                                            value: index,
                                            groupValue: state.index,
                                            onChanged: (int? newIndex) => context
                                                .read<RouteAdditionBloc>()
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
                                  .read<RouteAdditionBloc>()
                                  .add(CreateButtonPressed(
                                      id: state.dbList![state.index!].id)),
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
                                .read<RouteAdditionBloc>()
                                .add(StartFetching()),
                          ),
                        ],
                      ),
                    );
                  } else if (state is Success) {
                    return Center(
                        child: Text('Ruta ha sido creada exitosamente'));
                  } else {
                    return SizedBox();
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
