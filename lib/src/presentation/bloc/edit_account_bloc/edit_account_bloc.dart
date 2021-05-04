import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:kurztrip_ma/src/domain/entities/count/User.dart';
import 'package:kurztrip_ma/src/presentation/bloc/edit_account_bloc/edit_account_event.dart';
import 'package:kurztrip_ma/src/presentation/bloc/edit_account_bloc/edit_account_state.dart';

class EditAccountBloc extends Bloc<EditAccountEvent, EditAccountState> {
  EditAccountBloc(User user)
      : super(EditShowing(
            name: user.name,
            lastname: user.lastName,
            email: user.email,
            cellphone: user.cellphone));
  @override
  Stream<EditAccountState> mapEventToState(
    EditAccountEvent event,
  ) async* {
    if (state is EditShowing) {
      EditShowing old = state as EditShowing;
      if (event is UpdateCellphone) {
        yield old.copyWith(cellphone: event.cellphone);
      } else if (event is UpdateEmail) {
        yield old.copyWith(email: event.email);
      } else if (event is UpdateLastName) {
        yield old.copyWith(lastname: event.lastname);
      } else if (event is UpdateName) {
        yield old.copyWith(name: event.name);
      }
    }
    if (event is SendNewData) {
      yield SavingData();
      //llamar metodo de repositorio de editar usuario
      await Future.delayed(Duration(seconds: 2));
      //this.add(ErrorOccurred(message: 'Error de Conexión'));
      yield SavingSuccess();
    } else if (event is ErrorOccurred) {
      yield ErrorOccurredWhileSaving(message: event.message);
    }
  }
}
