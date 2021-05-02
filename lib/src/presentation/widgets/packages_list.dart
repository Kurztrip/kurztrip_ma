//Este metodo es temporal para llenar la lista de objetos
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/domain/entities/package/Package.dart';
import 'package:kurztrip_ma/src/presentation/bloc/package_list/package_list_bloc.dart';
import 'package:kurztrip_ma/src/presentation/widgets/expandable_item.dart';
import 'package:kurztrip_ma/src/presentation/widgets/item_list.dart';

class PackagesList extends StatelessWidget {
  final PackageListBloc bloc = getIt();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PackageListBloc>(
      create: (context) => bloc,
      child: BlocBuilder<PackageListBloc, PackageListState>(
        builder: (context, state) {
          Widget child;
          if (state is PackagelistShowing) {
            child = ItemList(
              list: generatePackages(state.packages),
              key: ValueKey(1),
              getList: () => bloc.add(GetAllPackages()),
              onDelete: (id) {},
              onEdit: (id) {},
            );
          } else if (state is PackagelistError) {
            return Center(
              child: Text(state.message),
              key: ValueKey(0),
            );
          } else {
            bloc.add(GetAllPackages());
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

  List<ExpandableItem> generatePackages(List<Package> list) {
    return list.map<ExpandableItem>((package) {
      return ExpandableItem(
        id: package.id,
        title: 'Paquete ' + package.id.toString(),
        subtitle: 'EN CAMINO',
        expandedValue: {
          'Destino:': [package.address],
          'Destinatario:': [package.receiver],
          'D.I. del destinatario: ': [package.idReceiver],
          'peso:': [package.weight.toString(), ' Kg'],
          'volumen:': [package.volume.toString(), 'cm3'],
          'centro de acopio': [package.storeId.toString()]
        },
      );
    });
  }
}
