//Este metodo es temporal para llenar la lista de objetos
import 'package:flutter/material.dart';
import 'package:kurztrip_ma/src/presentation/widgets/expandable_item.dart';
import 'package:kurztrip_ma/src/presentation/widgets/item_list.dart';

class PackagesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ItemList(
      getList: generatePackages,
    );
  }

  Future<List<ExpandableItem>> generatePackages() async {
    return Future.delayed(
        Duration(milliseconds: 500),
        () => List<ExpandableItem>.generate(10, (int index) {
              return ExpandableItem(
                title: 'Paquete $index',
                subtitle: 'EN CAMINO',
                expandedValue: {
                  'Destino:': ['Cll 80 70-50'],
                  'Destinatario:': ['dsdsd'],
                  'D.I. del destinatario: ': ['4549846548'],
                  'peso:': ['3', ' Kg'],
                  'volumen:': ['50', 'cm3'],
                  'centro de acopio': ['3']
                },
              );
            }));
  }
}
