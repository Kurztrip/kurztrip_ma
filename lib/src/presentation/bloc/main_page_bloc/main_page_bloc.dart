import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/domain/entities/count/User.dart';
import 'package:kurztrip_ma/src/presentation/bloc/main_page_bloc/main_page_event.dart';
import 'package:kurztrip_ma/src/presentation/bloc/main_page_bloc/main_page_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  factory MainPageBloc() {
    SharedPreferences prefs = getIt();
    User user = User.fromJson(jsonDecode(prefs.getString('user')!));
    return MainPageBloc._(user.rol != 'Administrador');
  }
  MainPageBloc._(bool driver) : super(TruckTab(driver));

  @override
  Stream<MainPageState> mapEventToState(MainPageEvent event) async* {
    if (event is TabSelected) {
      final int? index = event.properties[0];
      if (index == 0) {
        yield TruckTab(state.driver);
      } else if (index == 1) {
        yield PackageTab(state.driver);
      } else if (index == 2) {
        yield RouteTab(state.driver);
      } else if (index == 3) {
        yield AccountTab(state.driver);
      } else {
        yield ErrorState(state.driver);
      }
    }
  }
}
