//Este metodo es temporal para llenar la lista de objetos
import 'package:flutter/material.dart';
import 'package:kurztrip_ma/src/presentation/widgets/expandable_item.dart';
import 'package:kurztrip_ma/src/presentation/widgets/item_list.dart';

class TrucksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ItemList(
      getList: generateTrucks,
    );
  }

  Future<List<ExpandableItem>> generateTrucks() async {
    return Future.delayed(
        Duration(milliseconds: 500),
        () => List<ExpandableItem>.generate(10, (int index) {
              return ExpandableItem(
                title: 'Camión $index',
                subtitle: 'DISPONIBLE',
                expandedValue: {
                  'Capacidad de Carga:': ['500', 'Kg'],
                  'Capacidad de Volumen:': ['3', 'm3'],
                  'Combustible Disponible: ': ['30', '%'],
                  'Tipo de Combustible:': ['Gasolina'],
                  'Centro de Acopio:': ['Álamos']
                },
              );
            }));
  }
}
