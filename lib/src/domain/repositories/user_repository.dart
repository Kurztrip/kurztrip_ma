import 'package:kurztrip_ma/src/domain/entities/count/User.dart';

abstract class UserRepository {
  Future<User> get(String id);
  Future<User> add(User user);
  Future<User> delete(String id);
  Future<String> sendMailTo(String mail);
  Future<User> login(String? email, String? password);
}
