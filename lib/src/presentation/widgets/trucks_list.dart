//Este metodo es temporal para llenar la lista de objetos
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/domain/entities/truck/Truck.dart';
import 'package:kurztrip_ma/src/presentation/bloc/truck_list_bloc/truck_list_bloc.dart';
import 'package:kurztrip_ma/src/presentation/pages/pages.dart';
import 'package:kurztrip_ma/src/presentation/widgets/expandable_item.dart';
import 'package:kurztrip_ma/src/presentation/widgets/item_list.dart';

class TrucksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TruckListBloc bloc = getIt();
    return BlocProvider<TruckListBloc>(
      create: (context) => bloc,
      child: BlocBuilder<TruckListBloc, TruckListState>(
        builder: (context, state) {
          Widget child;
          if (state is TrucklistShowing) {
            if (state.error != null) {
              Future.delayed(
                  Duration(seconds: 1),
                  () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.error),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                      )));
            }
            child = ItemList(
              list: generateTrucks(state.trucks),
              key: ValueKey(1),
              getList: () async =>
                  context.read<TruckListBloc>().add(TruckListRefresh()),
              onDelete: (id) =>
                  context.read<TruckListBloc>().add(DeleteTruck(id)),
              onEdit: (id) async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TruckForm(
                              edit: id,
                            )));
                context.read<TruckListBloc>().add(TruckListRefresh());
              },
            );
          } else if (state is TrucklistError) {
            print(state.message);
            child = Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Ha ocurrido un error al obtener los paquetes"),
                  IconButton(
                    icon: Icon(Icons.replay_outlined),
                    onPressed: () =>
                        context.read<TruckListBloc>().add(TruckListRefresh()),
                  ),
                ],
              ),
              key: ValueKey(0),
            );
          } else {
            context.read<TruckListBloc>().add(GetAllTrucks());
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

  List<ExpandableItem> generateTrucks(List<Truck> list) {
    return list.map<ExpandableItem>((truck) {
      return ExpandableItem(
        id: truck.id,
        title: 'Camión ${truck.id}',
        subtitle: 'DISPONIBLE',
        expandedValue: {
          'Capacidad de Carga:': ['${truck.weight_capacity} ', 'Kg'],
          'Capacidad de Volumen:': ['${truck.volume_capacity} ', 'm3'],
          'Combustible Disponible: ': ['${truck.fuel * 100} ', '%'],
          'Tipo de Combustible:': ['${truck.fuel_type}'],
          'Centro de Acopio:': ['${truck.warehouse}']
        },
      );
    }).toList();
  }
}
