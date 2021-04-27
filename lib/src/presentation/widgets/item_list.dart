import 'package:flutter/material.dart';

class Item {
  Item({
    @required this.expandedValue,
    @required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Camión $index',
      expandedValue: 'This is item number $index',
    );
  });
}

class ItemListTest extends StatefulWidget {
  const ItemListTest({Key key}) : super(key: key);

  @override
  _ItemListTestState createState() => _ItemListTestState();
}

class _ItemListTestState extends State<ItemListTest> {
  final List<Item> _data = generateItems(8);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          backgroundColor: Theme.of(context).colorScheme.background,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
              subtitle: Text(
                'disponible',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
            );
          },
          body: ListTile(
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Capacidad de Carga:'),
                Text('Capacidad de Volumen:'),
                Text('Combustible Disponible:'),
                Text('Tipo de Combustible:'),
                Text('Centro de Acopio:'),
                Row(
                  children: [
                    TextButton(
                      onPressed: null,
                      child: Text(
                        'Editar',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                    TextButton(
                      onPressed: null,
                      child: Text(
                        'Ver ruta',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ],
                )
              ],
            ),
            trailing: FloatingActionButton(
              mini: true,
              child: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  _data.removeWhere((Item currentItem) => item == currentItem);
                });
              },
            ),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
