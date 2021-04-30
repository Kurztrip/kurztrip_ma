import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/second_page_bloc/second_page_event.dart';
import 'package:kurztrip_ma/src/presentation/bloc/second_page_bloc/second_page_state.dart';

class SecondPageBloc extends Bloc<SecondPageEvent, SecondPageState> {
  SecondPageBloc() : super(Showing(index: 0));

  @override
  Stream<SecondPageState> mapEventToState(SecondPageEvent event) async* {
    if (event is TabSelected) {
      yield Showing(index: event.properties[0]);
    }
  }
}
