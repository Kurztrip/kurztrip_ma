import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/presentation/bloc/routes_list_bloc/routes_list_bloc.dart';

class RoutesList extends StatefulWidget {
  @override
  _RoutesListState createState() => _RoutesListState();
}

class _RoutesListState extends State<RoutesList> {
  RoutesListBloc bloc = getIt();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RoutesListBloc>(
      create: (context) => bloc,
      child: BlocBuilder<RoutesListBloc, RouteslistState>(
        builder: (context, state) {
          Widget child;
          if (state is RouteslistShowing) {
          } else if (state is RouteslistError) {
            child = Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Ha ocurrido un error al obtener los paquetes"),
                  IconButton(
                    icon: Icon(Icons.replay_outlined),
                    onPressed: () =>
                        context.read<RoutesListBloc>().add(RefreshRoutes()),
                  ),
                ],
              ),
              key: ValueKey(0),
            );
          } else {
            context.read<RoutesListBloc>().add(GetRoutes());
            child = child = const Center(
              child: const CircularProgressIndicator(),
              key: ValueKey(0),
            );
          }
          return AnimatedSwitcher(child: child, duration: Duration(seconds: 1));
        },
      ),
    );
  }
}
