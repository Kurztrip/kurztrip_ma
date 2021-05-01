import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kurztrip_ma/src/presentation/widgets/expandable_item.dart';

typedef ListGetter = Future<List<ExpandableItem>> Function();

class ItemList extends StatefulWidget {
  const ItemList({Key key, @required this.getList}) : super(key: key);
  final ListGetter getList;
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  Future<List<ExpandableItem>> list;
  @override
  void initState() {
    list = widget.getList();
    super.initState();
  }

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
            child = RefreshIndicator(
                key: ValueKey(1),
                onRefresh: () async {
                  setState(() {
                    list = widget.getList();
                  });
                },
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: constraints.maxHeight),
                        child: ExpansionPanelList(
                          expansionCallback: (int index, bool isExpanded) {
                            setState(() {
                              snapshot.data[index].isExpanded = !isExpanded;
                            });
                          },
                          children: snapshot.data
                              .map<ExpansionPanel>((ExpandableItem item) {
                            return ExpansionPanel(
                              backgroundColor:
                                  Theme.of(context).colorScheme.background,
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                return ListTile(
                                  title: Text(item.title),
                                  subtitle: Text(
                                    item.subtitle,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                  ),
                                );
                              },
                              body: ListTile(
                                subtitle: Column(
                                  children: [
                                    Column(
                                      children: item.expandedValue.entries
                                          .map((e) => Row(
                                                children: [
                                                  Text(e.key),
                                                  Spacer(),
                                                  Text(e.value[0].toString()),
                                                  e.value.length == 1
                                                      ? Container()
                                                      : Text(
                                                          e.value[1].toString(),
                                                          style: TextStyle(
                                                              fontFeatures: [
                                                                FontFeature
                                                                    .enable(
                                                                        'sups')
                                                              ]),
                                                        ),
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
                                        Spacer(),
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () {
                                            return showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        AlertDialog(
                                                          title: Text(
                                                            'Eliminar ${item.title}',
                                                            style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondary),
                                                          ),
                                                          content: Text(
                                                              'Estas seguro?'),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context,
                                                                        rootNavigator:
                                                                            true)
                                                                    .pop();
                                                              },
                                                              child: Text(
                                                                'CANCELAR',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                // agregar evento al bloc de eliminar objeto.
                                                                setState(() {
                                                                  snapshot.data.removeWhere(
                                                                      (ExpandableItem
                                                                              currentItem) =>
                                                                          item ==
                                                                          currentItem);
                                                                });
                                                                Navigator.of(
                                                                        context,
                                                                        rootNavigator:
                                                                            true)
                                                                    .pop();
                                                              },
                                                              child: Text(
                                                                'ACEPTAR',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ],
                                                        ));
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              isExpanded: item.isExpanded,
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ));
          return AnimatedSwitcher(child: child, duration: Duration(seconds: 1));
        });
  }
}
