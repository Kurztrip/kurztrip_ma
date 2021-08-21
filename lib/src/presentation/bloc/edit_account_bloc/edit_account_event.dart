import 'package:equatable/equatable.dart';
import 'package:kurztrip_ma/src/domain/entities/count/User.dart';
import 'package:meta/meta.dart';

abstract class EditAccountEvent extends Equatable {
  const EditAccountEvent();

  @override
  List<Object> get props => [];
}

class SendNewData extends EditAccountEvent {
  final User user;
  SendNewData({required this.user});
}

class ErrorOccurred extends EditAccountEvent {
  final String message;
  ErrorOccurred({required this.message});
}

class UpdateName extends EditAccountEvent {
  final String name;
  UpdateName(this.name);
}

class UpdateLastName extends EditAccountEvent {
  final String lastname;
  UpdateLastName(this.lastname);
}

class UpdateCellphone extends EditAccountEvent {
  final String cellphone;
  UpdateCellphone(this.cellphone);
}

class UpdateEmail extends EditAccountEvent {
  final String email;
  UpdateEmail(this.email);
}
