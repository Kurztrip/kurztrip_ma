import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kurztrip_ma/src/presentation/widgets/expandable_item.dart';

class ItemList extends StatefulWidget {
  ItemList({
    Key? key,
    required this.getList,
    required this.onEdit,
    required this.onDelete,
    required this.list,
  }) : super(key: key);
  final Function(int?) onEdit;
  final Function(int?) onDelete;
  final Function getList;
  final List<ExpandableItem> list;

  @override
  _ItemListState createState() => _ItemListState(this.list);
}

class _ItemListState extends State<ItemList> {
  List<ExpandableItem> list;
  _ItemListState(this.list);
  @override
  Widget build(BuildContext context) {
    return _buildPanel();
  }

  Widget _buildPanel() {
    return RefreshIndicator(
        key: ValueKey(1),
        onRefresh: () async {
          widget.getList();
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: ExpansionPanelList(
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      list[index].isExpanded = !isExpanded;
                    });
                  },
                  children: list.map<ExpansionPanel>((ExpandableItem item) {
                    return ExpansionPanel(
                      backgroundColor: Theme.of(context).colorScheme.background,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text(item.title),
                          subtitle: Text(
                            item.subtitle!,
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
                                        children: [
                                          Text(e.key),
                                          Spacer(),
                                          Text(e.value[0].toString()),
                                          e.value.length == 1
                                              ? Container()
                                              : Text(
                                                  e.value[1].toString(),
                                                  style:
                                                      TextStyle(fontFeatures: [
                                                    FontFeature.enable('sups')
                                                  ]),
                                                ),
                                        ],
                                      ))
                                  .toList(),
                            ),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () => widget.onEdit(item.id),
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
                                        builder: (BuildContext context) =>
                                            AlertDialog(
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
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    widget.onDelete(item.id);
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pop();
                                                  },
                                                  child: Text(
                                                    'ACEPTAR',
                                                    style: TextStyle(
                                                        color: Colors.white),
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
  }
}
