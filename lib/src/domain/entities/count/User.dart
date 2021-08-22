import 'package:json_annotation/json_annotation.dart';
part 'User.g.dart';

@JsonSerializable()
class User {
  const User(
      {this.id,
      this.name,
      this.lastName,
      this.email,
      this.cellphone,
      this.rol,
      this.createAt,
      this.password,
      this.organization,
      this.notifications,
      this.token});

  final String? id;
  final String? name;
  final String? lastName;
  final String? email;
  final String? cellphone;
  final String? rol;
  @JsonKey(ignore: true)
  final DateTime? createAt;
  @JsonKey(ignore: true)
  final String? password;
  @JsonKey(ignore: true)
  final String? organization;
  @JsonKey(ignore: true)
  final List<String>? notifications;
  final String? token;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  static User createEmpty() {
    return User(
        id: '',
        name: '',
        lastName: '',
        email: '',
        cellphone: '',
        rol: '',
        createAt: DateTime.now(),
        password: 'password',
        organization: '',
        notifications: []);
  }
}
