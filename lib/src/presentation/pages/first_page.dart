import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/presentation/bloc/first_page_bloc/first_page_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/first_page_bloc/first_page_event.dart';
import 'package:kurztrip_ma/src/presentation/bloc/first_page_bloc/first_page_state.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'),
      ),
      body: buildBody(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward_rounded),
        onPressed: () => Navigator.pushNamed(context, '/second'),
      ),
    );
  }
}

BlocProvider<FirstPageBloc> buildBody(BuildContext context) {
  FirstPageBloc bloc = getIt<FirstPageBloc>();
  return BlocProvider(
    create: (_) => bloc,
    child: Center(
      child: BlocBuilder<FirstPageBloc, FirstPageState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                state.properties[0].toString(),
                style: TextStyle(fontSize: 50.0),
              ),
              ElevatedButton(
                  onPressed: () =>
                      context.read<FirstPageBloc>().add(ButtonPressed()),
                  child: Icon(Icons.add)),
            ],
          );
        },
      ),
    ),
  );
}
