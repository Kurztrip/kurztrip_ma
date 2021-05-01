//Este metodo es temporal para llenar la lista de objetos
import 'package:flutter/material.dart';
import 'package:kurztrip_ma/src/domain/entities/truck/Truck.dart';
import 'package:kurztrip_ma/src/presentation/widgets/expandable_item.dart';
import 'package:kurztrip_ma/src/presentation/widgets/item_list.dart';

class TrucksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ItemList(
      list: [],
      getList: generateTrucks,
      onDelete: (i) {},
      onEdit: (i) {},
    );
  }

  List<ExpandableItem> generateTrucks(List<Truck> list) {
    return list.map<ExpandableItem>((truck) {
      return ExpandableItem(
        id: truck.id,
        title: 'Camión',
        subtitle: 'DISPONIBLE',
        expandedValue: {
          'Capacidad de Carga:': ['500', 'Kg'],
          'Capacidad de Volumen:': ['3', 'm3'],
          'Combustible Disponible: ': ['30', '%'],
          'Tipo de Combustible:': ['Gasolina'],
          'Centro de Acopio:': ['Álamos']
        },
      );
    });
  }
}
