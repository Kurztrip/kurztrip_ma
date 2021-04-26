import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/second_page_bloc/second_page_bloc.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/presentation/bloc/second_page_bloc/second_page_event.dart';
import 'package:kurztrip_ma/src/presentation/bloc/second_page_bloc/second_page_state.dart';

class SecondPage extends StatelessWidget {
  SecondPageBloc bloc = getIt<SecondPageBloc>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => bloc,
      child: BlocBuilder<SecondPageBloc, SecondPageState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Second Page'),
            ),
            backgroundColor: getPageColor(state.properties[0]),
            body: Center(
              child: getItemView(state.properties[0]),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.arrow_back),
              backgroundColor: Colors.red,
              onPressed: () => Navigator.pop(context),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.properties[0],
              onTap: (index) =>
                  context.read<SecondPageBloc>().add(TabSelected(index: index)),
              items: [
                BottomNavigationBarItem(
                  icon: new Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: new Icon(Icons.mail),
                  label: 'Messages',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget getItemView(int index) {
  switch (index) {
    case 0:
      {
        return Text(
          'You are in home!',
          style: TextStyle(fontSize: 30.0, color: Colors.white),
        );
      }
    case 1:
      {
        return Text(
          'Here are your messages!',
          style: TextStyle(fontSize: 30.0, color: Colors.white),
        );
      }
    case 2:
      {
        return Text(
          'This is your profile!',
          style: TextStyle(fontSize: 30.0, color: Colors.white),
        );
      }
    default:
      {
        return Text('Error');
      }
  }
}

Color getPageColor(int index) {
  switch (index) {
    case 0:
      {
        return Colors.green;
      }
    case 1:
      {
        return Colors.pink;
      }
    case 2:
      {
        return Colors.indigo;
      }
    default:
      {
        return Colors.white;
      }
  }
}
