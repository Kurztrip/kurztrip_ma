import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurztrip_ma/src/domain/entities/count/User.dart';
import 'package:kurztrip_ma/src/presentation/bloc/account_page_bloc/account_page_event.dart';
import 'package:kurztrip_ma/src/presentation/bloc/account_page_bloc/account_page_state.dart';

class AccountPageBloc extends Bloc<AccountPageEvent, AccountPageState> {
  AccountPageBloc() : super(FetchingAccountInfo());

  @override
  Stream<AccountPageState> mapEventToState(AccountPageEvent event) async* {
    if (event is StartFetching) {
      //metodo del repositorio para buscar información de usuario
      await Future.delayed(Duration(seconds: 2));
      this.add(
        AccountInfoObtained(
          user: User(
            id: 0,
            name: 'Pepito',
            lastName: 'Perez',
            rol: 'administrador',
            cellphone: '234525647',
            email: 'correo@mail.com',
            password: null,
            organization: null,
            notifications: null,
            createAt: null,
          ),
        ),
      );
    } else if (event is AccountInfoObtained) {
      yield ShowingAccountInfo(user: event.user);
    } else if (event is ErrorOccurred) {
      yield ErrorState(message: event.message);
    }
  }
}
