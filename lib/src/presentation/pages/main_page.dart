import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/main_page_bloc/main_page_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/main_page_bloc/main_page_event.dart';
import 'package:kurztrip_ma/src/presentation/bloc/main_page_bloc/main_page_state.dart';

import '../../../services_provider.dart';

class MainPage extends StatelessWidget {
  final MainPageBloc bloc = getIt<MainPageBloc>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => bloc,
      child: BlocBuilder<MainPageBloc, MainPageState>(
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Text('Hello World'),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {},
              shape: StadiumBorder(
                  side: BorderSide(
                      color: Theme.of(context).colorScheme.background,
                      width: 6)),
            ),
            floatingActionButtonLocation: _getIndex(state) == 3
                ? FloatingActionButtonLocation.endFloat
                : FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Theme.of(context).colorScheme.primary,
              selectedItemColor: Theme.of(context).colorScheme.secondary,
              unselectedItemColor: Theme.of(context).colorScheme.background,
              currentIndex: _getIndex(state),
              onTap: (index) =>
                  context.read<MainPageBloc>().add(TabSelected(index: index)),
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
          );
        },
      ),
    );
  }
}

int _getIndex(MainPageState state) {
  return state is PackageTab ? 0 : state.properties[0];
}
