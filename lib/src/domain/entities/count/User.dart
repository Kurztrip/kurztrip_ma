import 'package:flutter/widgets.dart';

class User{
  const User({
    @required this.id,
    @required this.name,
    @required this.lastName,
    @required this.email,
    @required this.cellphone,
    @required this.rol,
    @required this.createAt,
    @required this.password,
    @required this.organization,
    @required this.notifications
  });
  final int id;
  final String name;
  final String lastName;
  final String email;
  final String cellphone;
  final String rol;
  final DateTime createAt;
  final String password;
  final String organization;
  final List<String> notifications;

}