import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/domain/entities/count/User.dart';
import 'package:kurztrip_ma/src/presentation/bloc/account_page_bloc/account_page_event.dart';
import 'package:kurztrip_ma/src/presentation/bloc/account_page_bloc/account_page_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPageBloc extends Bloc<AccountPageEvent, AccountPageState> {
  AccountPageBloc() : super(FetchingAccountInfo());
  SharedPreferences prefs = getIt();

  @override
  Stream<AccountPageState> mapEventToState(AccountPageEvent event) async* {
    if (event is StartFetching) {
      //metodo del repositorio para buscar información de usuario
      yield ShowingAccountInfo(
          user: User.fromJson(jsonDecode(prefs.getString('user')!)));
      // yield ShowingAccountInfo(user: User.createEmpty());
    } else if (event is AccountInfoObtained) {
      yield ShowingAccountInfo(user: event.user);
    } else if (event is ErrorOccurred) {
      yield ErrorState(message: event.message);
    } else if (event is LogOut) {
      prefs.remove('user');
    }
  }
}
