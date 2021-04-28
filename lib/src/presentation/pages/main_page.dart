import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/main_page_bloc/main_page_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/main_page_bloc/main_page_event.dart';
import 'package:kurztrip_ma/src/presentation/bloc/main_page_bloc/main_page_state.dart';
import 'package:kurztrip_ma/src/presentation/widgets/item_list.dart';
import 'package:kurztrip_ma/services_provider.dart';

class MainPage extends StatelessWidget {
  final MainPageBloc bloc = getIt<MainPageBloc>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => bloc,
      child: BlocBuilder<MainPageBloc, MainPageState>(
        builder: (context, state) {
          final index = _getIndex(state);
          return Scaffold(
            appBar: AppBar(
              title: Text("Pagina Principal"),
            ),
            floatingActionButton: _getIndex(state) == 3
                ? null
                : Visibility(
                    visible: _getIndex(state) != 3,
                    child: FloatingActionButton(
                      child: Icon(Icons.add),
                      onPressed: () {},
                      // shape: StadiumBorder(
                      //     side: BorderSide(
                      //         color: Theme.of(context).colorScheme.background,
                      //         width: 6)),
                    ),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: SizedBox(
              height: MediaQuery.of(context).size.height * 0.09,
              child: BottomAppBar(
                shape: const CircularNotchedRectangle(),
                color: Theme.of(context).colorScheme.primary,
                clipBehavior: Clip.antiAlias,
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  selectedItemColor: Theme.of(context).colorScheme.secondary,
                  unselectedItemColor: Theme.of(context).colorScheme.background,
                  currentIndex: index,
                  onTap: (index) => context
                      .read<MainPageBloc>()
                      .add(TabSelected(index: index)),
                  items: [
                    BottomNavigationBarItem(
                      icon: new Icon(Icons.airport_shuttle_outlined),
                      label: 'Camiones',
                    ),
                    BottomNavigationBarItem(
                      icon: new Icon(Icons.inbox_rounded),
                      label: 'Paquetes',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.alt_route),
                      label: 'Rutas',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'Cuenta',
                    ),
                  ],
                ),
              ),
            ),
            body: _getItemView(index),
          );
        },
      ),
    );
  }
}

int _getIndex(MainPageState state) {
  return state is PackageTab ? 0 : state.properties[0];
}

Widget _getItemView(int index) {
  switch (index) {
    case 0:
      {
        return ItemListTest();
      }
    case 1:
      {
        return Center(
          child: Text(
            'Paquetes!',
            style: TextStyle(fontSize: 30.0, color: Colors.white),
          ),
        );
      }
    case 2:
      {
        return Center(
          child: Text(
            'Rutas!',
            style: TextStyle(fontSize: 30.0, color: Colors.white),
          ),
        );
      }
    case 3:
      {
        return Center(
          child: Text(
            'This is your profile!',
            style: TextStyle(fontSize: 30.0, color: Colors.white),
          ),
        );
      }
  }
}
