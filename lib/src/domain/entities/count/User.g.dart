// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as String?,
    name: json['name'] as String?,
    lastName: json['lastName'] as String?,
    email: json['email'] as String?,
    cellphone: json['cellphone'] as String?,
    rol: json['rol'] as String?,
    token: json['token'] as String?,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lastName': instance.lastName,
      'email': instance.email,
      'cellphone': instance.cellphone,
      'rol': instance.rol,
      'token': instance.token,
    };
