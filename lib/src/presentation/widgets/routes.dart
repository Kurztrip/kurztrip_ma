import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/presentation/bloc/routes_list_bloc/routes_list_bloc.dart';
import 'package:kurztrip_ma/src/presentation/pages/route_view.dart';

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
            child = RefreshIndicator(
              key: ValueKey(1),
              onRefresh: () async {
                bloc.add(RefreshRoutes());
              },
              child: LayoutBuilder(builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: Column(
                        children: state.routes.map((route) {
                      return ListTile(
                          title: Text("ruta ${route.truck_id}"),
                          subtitle: Text(
                            "En curso",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RouteView(
                                      onDelete: () => bloc
                                          .add(DeleteRoutes(route.truck_id)),
                                      route: route))));
                    }).toList()),
                  ),
                );
              }),
            );
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
