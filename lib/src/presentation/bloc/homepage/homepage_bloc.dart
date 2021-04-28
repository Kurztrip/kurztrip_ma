import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/homepage/homepage_event.dart';
import 'package:kurztrip_ma/src/presentation/bloc/homepage/homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  HomepageBloc() : super(Home());

  @override
  Stream<HomepageState> mapEventToState(HomepageEvent event) async* {
    if(event is SignInButtonPressed){
      yield SignInState();
    }else if(event is BackToHome){
      yield Home();
    }
  }
}
