import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/main_page_bloc/main_page_event.dart';
import 'package:kurztrip_ma/src/presentation/bloc/main_page_bloc/main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  MainPageBloc() : super(Showing(index: 3));

  @override
  Stream<MainPageState> mapEventToState(MainPageEvent event) async* {
    if (event is TabSelected) {
      final int index = event.properties[0];
      if (index == 0) {
        yield PackageTab(
            packageList: ['PackageA', 'PackageB', 'PackageC', 'PackageD']);
      } else {
        yield Showing(index: index);
      }
    }
  }
}
