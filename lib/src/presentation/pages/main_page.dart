import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/main_page_bloc/main_page_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/main_page_bloc/main_page_event.dart';
import 'package:kurztrip_ma/src/presentation/bloc/main_page_bloc/main_page_state.dart';
import 'package:kurztrip_ma/src/presentation/kurztrip_icons_icons.dart';
import 'package:kurztrip_ma/src/presentation/widgets/account.dart';
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
            floatingActionButton: _getIndex(state) == 3
                ? null
                : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _floatingActionButton(state, context),
            ),
            floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.09,
              child: BottomAppBar(
                shape: const CircularNotchedRectangle(),
                color: Theme
                    .of(context)
                    .colorScheme
                    .primary,
                clipBehavior: Clip.antiAlias,
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Theme
                      .of(context)
                      .colorScheme
                      .primary,
                  selectedItemColor: Theme
                      .of(context)
                      .colorScheme
                      .onPrimary,
                  unselectedItemColor:
                  Theme
                      .of(context)
                      .colorScheme
                      .onPrimary
                      .withAlpha(130),
                  currentIndex: index,
                  onTap: (index) =>
                      context
                          .read<MainPageBloc>()
                          .add(TabSelected(index: index)),
                  items: [
                    BottomNavigationBarItem(
                      icon: new Icon(KurztripIcons.frontal_truck),
                      label: 'Camiones',
                    ),
                    BottomNavigationBarItem(
                      icon: new Icon(KurztripIcons.paquetes),
                      label: 'Paquetes',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(KurztripIcons.ruta),
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
            body: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery
                      .of(context)
                      .size
                      .height * 0.05),
              child: _getItemView(index),
            ),
          );
        },
      ),
    );
  }

  void _floatingActionButton(MainPageState state, BuildContext context) {
    int index = _getIndex(state);
    switch (index) {
      case 0:
        {
          Navigator.of(context).pushNamed('/truck_form');
          break;
        }
      case 1:
        {
          break;
        }
      case 2:
        {
          break;
        }
      default:
        {
          break;
        }
    }
  }

  int _getIndex(MainPageState state) {
    if (state is TruckTab) {
      return 0;
    }
    if (state is PackageTab) {
      return 1;
    }
    if (state is RouteTab) {
      return 2;
    }
    if (state is AccountTab) {
      return 3;
    }
    return 0;
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
          return AccountPage();
        }
      default:
        {
          return Center(
            child: Text(
              'Se presentó un error!',
              style: TextStyle(fontSize: 30.0, color: Colors.white),
            ),
          );
        }
    }
  }
}
