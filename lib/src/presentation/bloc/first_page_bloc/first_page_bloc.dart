import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/first_page_bloc/first_page_event.dart';
import 'package:kurztrip_ma/src/presentation/bloc/first_page_bloc/first_page_state.dart';

class FirstPageBloc extends Bloc<FirstPageEvent, FirstPageState> {
  FirstPageBloc() : super(Showing(number: 0));

  @override
  Stream<FirstPageState> mapEventToState(FirstPageEvent event) async* {
    if (event is ButtonPressed) {
      final Showing currState = this.state as Showing;
      yield Showing(number: currState.number + 1);
    }
  }
}
