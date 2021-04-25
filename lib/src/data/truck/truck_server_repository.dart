import 'package:graphql/client.dart';
import 'package:kurztrip_ma/src/data/client_config.dart';
import 'package:kurztrip_ma/src/domain/entities/truck/Truck.dart';
import 'package:kurztrip_ma/src/domain/repositories/truck_repository.dart';

class TruckServerRepository implements TruckRepository {
  Truck truck = Truck.createEmpty();
  final String getTruck = r'''
    query getTruck($id: Int!) {
      id
      registration
      status
      weight_capacity
      volume_capacity
      fuel_type
      fuel_capacity
      fuel_by_kilometer
      fuel
      warehouse
    }
  ''';
  @override
  Future<Truck> get(int id) async {
    final QueryOptions options = QueryOptions(
      document: gql(getTruck),
      variables: <String, dynamic>{
        'id': id,
      },
    );
    final result = await getGraphQLClient().query(options);
    if (result.hasException) {
      throw result.exception;
    }
    return Truck(id: result.data['id']);
    // return Future.delayed(const Duration(milliseconds: 100), () => truck);
  }

  @override
  Future<bool> save(Truck truck) async {
    return Future.delayed(const Duration(milliseconds: 100), () {
      this.truck = truck;
      return true;
    });
  }

  @override
  Future<List<Truck>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }
}
