import 'package:flutter/widgets.dart';

class Notification{
  const Notification({
    required this.id,
    required this.type ,
    required this.message,
    required this.createAt
  });

  final String id;
  final String type;
  final String message;
  final DateTime createAt;
}