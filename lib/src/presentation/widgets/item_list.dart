import 'package:flutter/material.dart';

class ExpandableItem {
  ExpandableItem({
    @required this.expandedValue,
    @required this.title,
    this.subtitle,
    this.isExpanded = false,
  });

  String title;
  String subtitle;
  Map<String, dynamic> expandedValue;
  bool isExpanded;
}

//Este metodo es temporal para llenar la lista de objetos
Future<List<ExpandableItem>> generatePackages(int numberOfItems) async {
  return Future.delayed(
      Duration(milliseconds: 500),
      () => List<ExpandableItem>.generate(numberOfItems, (int index) {
            return ExpandableItem(
              title: 'Camión $index',
              subtitle: 'DISPONIBLE',
              expandedValue: {
                'Capacidad de Carga:': '500kg',
                'Capacidad de Volumen:': '3m^3',
                'Combustible Disponible: ': '30%',
                'Tipo de Combustible:': 'Gasolina',
                'Centro de Acopio:': 'Álamos'
              },
            );
          }));
}

class ItemListTest extends StatefulWidget {
  const ItemListTest({Key key}) : super(key: key);
  @override
  _ItemListTestState createState() => _ItemListTestState();
}

class _ItemListTestState extends State<ItemListTest> {
  Future<List<ExpandableItem>> list = generatePackages(3);

  @override
  Widget build(BuildContext context) {
    return _buildPanel();
  }

  Widget _buildPanel() {
    return FutureBuilder(
        future: list,
        builder: (context, snapshot) {
          Widget child;
          if (snapshot.data == null)
            child = const Center(
              child: const CircularProgressIndicator(),
              key: ValueKey(0),
            );
          else
            child = Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                key: ValueKey(1),
                child: ExpansionPanelList(
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      snapshot.data[index].isExpanded = !isExpanded;
                    });
                  },
                  children:
                      snapshot.data.map<ExpansionPanel>((ExpandableItem item) {
                    return ExpansionPanel(
                      backgroundColor: Theme.of(context).colorScheme.background,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text(item.title),
                          subtitle: Text(
                            item.subtitle,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                        );
                      },
                      body: ListTile(
                        subtitle: Column(
                          children: [
                            Column(
                              children: item.expandedValue.entries
                                  .map((e) => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(e.key),
                                          Text(e.value.toString()),
                                        ],
                                      ))
                                  .toList(),
                            ),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    // hacer push a la pagina de editar
                                  },
                                  child: Text(
                                    'EDITAR',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // hacer push a la pagina de ver ruta
                                  },
                                  child: Text(
                                    'VER RUTA',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
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
                            return showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: Text(
                                        'Eliminar ${item.title}',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                      ),
                                      content: Text('Estas seguro?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();
                                          },
                                          child: Text(
                                            'CANCELAR',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // agregar evento al bloc de eliminar objeto.
                                            setState(() {
                                              snapshot.data.removeWhere(
                                                  (ExpandableItem
                                                          currentItem) =>
                                                      item == currentItem);
                                            });
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();
                                          },
                                          child: Text(
                                            'ACEPTAR',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ));
                          },
                        ),
                      ),
                      isExpanded: item.isExpanded,
                    );
                  }).toList(),
                ),
              ),
            );
          return AnimatedSwitcher(child: child, duration: Duration(seconds: 1));
        });
  }
}
