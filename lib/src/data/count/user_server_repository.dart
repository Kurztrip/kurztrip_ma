import 'package:kurztrip_ma/src/domain/entities/count/User.dart';
import 'package:kurztrip_ma/src/domain/repositories/user_repository.dart';
import 'package:graphql/client.dart';
import 'package:kurztrip_ma/src/data/client_config.dart';
import '../client_config.dart';
import 'package:kurztrip_ma/services_provider.dart';

class UserServerRepository extends UserRepository {
  User user = User.createEmpty();
  final String getUser = r'''
    query getOneUser($id: String!){
      getUserById(id: $id){
        _id
        name
        lastName
        email
        cellphone
        rol
        createAt
        password
        organization
        notifications
      }
    }
  ''';

  final String createUser = r'''
    mutation createOneUser($user: UserInput!){
      createUser(user: $user){
        _id
        name
        lastName
        email
        cellphone
        rol
        createAt
        password
        organization
        notifications
      }
    }
  ''';

  final String deleteUser = r'''
    mutation deleteOneUser($id: String!){
      deleteUser(id: $id){
        _id
        name
        lastName
        email
        cellphone
        rol
        createAt
        password
        organization
        notifications
      }
    }
  ''';

  final String sendMail = r'''
    mutation sendMail($mail: MailInput!){
      sendMailTo(mail: $mail){
        sended
      }
    }
  ''';

  final String loginUser = r'''
    mutation loginUser($login: LoginInput!){
      Login(login: $login){
        access_token
        email
        rol
        name
        lastName
        cellphone
        id
      }
    }
  ''';

  @override
  Future<User> get(String id) async {
    final QueryOptions options = QueryOptions(
      document: gql(getUser),
      variables: <String, dynamic>{'id': id},
    );
    final result = await getGraphQLClient().query(options);
    if (result.hasException) {
      throw result.exception!;
    }
    final userResult = result.data!['getUserById'];
    return User(
        id: userResult['_id'].toString(),
        name: userResult['name'].toString(),
        lastName: userResult['lastName'].toString(),
        email: userResult['email'].toString(),
        cellphone: userResult['cellphone'].toString(),
        rol: userResult['rol'].toString(),
        createAt: userResult['createAt'],
        password: userResult['password'].toString(),
        organization: userResult['organization'].toString(),
        notifications: userResult['notifications']);
  }

  @override
  Future<User> add(User user) async {
    final MutationOptions options =
        MutationOptions(document: gql(createUser), variables: <String, dynamic>{
      'user': {
        'name': user.name,
        'lastName': user.lastName,
        'email': user.email,
        'cellphone': user.cellphone,
        'rol': user.rol,
        'password': user.password
      }
    });
    final result = await getGraphQLClient().mutate(options);
    if (result.hasException) {
      throw result.exception!;
    }
    final userResult = result.data!['createUser'];
    return User(
        id: userResult['_id'].toString(),
        name: userResult['name'].toString(),
        lastName: userResult['lastName'].toString(),
        email: userResult['email'].toString(),
        cellphone: userResult['cellphone'].toString(),
        rol: userResult['rol'].toString(),
        password: userResult['password'].toString(),
        organization: userResult['organization'].toString());
  }

  @override
  Future<User> delete(String id) async {
    final MutationOptions options = MutationOptions(
        document: gql(deleteUser), variables: <String, dynamic>{'id': id});
    final result = await getGraphQLClient().mutate(options);
    if (result.hasException) {
      throw result.exception!;
    }
    final userResult = result.data!['deleteUser'];
    return User(
        id: userResult['_id'].toString(),
        name: userResult['name'].toString(),
        lastName: userResult['lastName'].toString(),
        email: userResult['email'].toString(),
        cellphone: userResult['cellphone'].toString(),
        rol: userResult['rol'].toString(),
        createAt: userResult['createAt'],
        password: userResult['password'].toString(),
        organization: userResult['organization'].toString(),
        notifications: userResult['notifications']);
  }

  Future<String> sendMailTo(String mail) async {
    final MutationOptions options =
        MutationOptions(document: gql(sendMail), variables: <String, dynamic>{
      'mail': {'email': mail}
    });
    final result = await getGraphQLClient().mutate(options);
    if (result.hasException) {
      throw result.exception!;
    }
    final mailResult = result.data!['createUser'];
    return mailResult.toString();
  }

  Future<User> login(String? email, String? password) async {
    final MutationOptions options =
        MutationOptions(document: gql(loginUser), variables: <String, dynamic>{
      'login': {'email': email, 'password': password, 'device_id': device_id}
    });
    final result = await getGraphQLClient().mutate(options);
    if (result.hasException) {
      throw result.exception!;
    }
    final loginResult = result.data!['Login'];
    final user = User(
        id: loginResult['id'].toString(),
        name: loginResult['name'].toString(),
        lastName: loginResult['lastName'].toString(),
        email: loginResult['email'].toString(),
        cellphone: loginResult['cellphone'].toString(),
        rol: loginResult['rol'].toString(),
        token: loginResult['access_token'].toString());
    return user;
  }
}
