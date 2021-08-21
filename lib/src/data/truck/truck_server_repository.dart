import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';
import 'package:kurztrip_ma/src/data/client_config.dart';
import 'package:kurztrip_ma/src/domain/entities/truck/Truck.dart';
import 'package:kurztrip_ma/src/domain/repositories/truck_repository.dart';

class TruckServerRepository implements TruckRepository {
  Truck truck = Truck.createEmpty();
  final String getTruckMA = r'''
    query getTruckMA($id: Int!){
      getTruck(id: $id) {
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
    }
  ''';

  final String getTrucksMA = r'''
    query getTrucksMA(){
      getTrucks() {
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
    }
  ''';

  final String createTruckMA = r'''
    mutation createTruckMA($truck: TruckInput!){
      createTruck(truck: $truck){
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
    }
  ''';

  final String updateTruckMA = r'''
    mutation updateTruckMA($id: Int!, $truck: TruckInput!){
      updateTruck(id: $id, truck: $truck)
    }
  ''';

  final String deleteTruckMA = r'''
    mutation deleteTruckMA($id: Int!){
      deleteTruck(id: $id){
        id
      }
    }
  ''';

//        registration
  //     status
  //     weight_capacity
  //     volume_capacity
  //     fuel_type
  //     fuel_capacity
  //     fuel_by_kilometer
  //     fuel
  //
  //

  @override
  Future<Truck> get(int id) async {
    final QueryOptions options = QueryOptions(
      document: gql(getTruckMA),
      variables: <String, dynamic>{
        'id': id,
      },
    );
    final result = await getGraphQLClient().query(options);
    if (result.hasException) {
      throw result.exception!;
    }
    final TruckResult = result.data!['getTruck'];

    debugPrint(TruckResult['registration'].toString()); //LINEA DEBUG

    return Truck(
        id: int.parse(TruckResult['id'].toString()),
        registration: TruckResult['registration'].toString(),
        status: TruckResult['status'].toString(),
        weight_capacity: TruckResult['weight_capacity'].toDouble(),
        volume_capacity: TruckResult['volume_capacity'].toDouble(),
        fuel_type: TruckResult['fuel_type'].toString(),
        fuel_capacity: TruckResult['weight_capacity'].toDouble(),
        fuel_by_kilometer: TruckResult['volume_capacity'].toDouble(),
        fuel: TruckResult['fuel'].toDouble(),
        warehouse: int.parse(TruckResult['warehouse'].toString()));
    // return Future.delayed(const Duration(milliseconds: 100), () => truck);
  }

  /*





  
  */

  /*
  @override
  Future<bool> save(Truck truck) async {
    return Future.delayed(const Duration(milliseconds: 100), () {
      this.truck = truck;
      return true;
    });
  }
  */

  /*
  id
        
        
        
        
        
        
        
        
        warehouse
  */

  @override
  Future<List<Truck>> getAll() async {
    final QueryOptions options = QueryOptions(document: gql(getTrucksMA) //NOMBRE DEL STRING QUERY O MUTATION

        );
    final result = await getGraphQLClient().query(options);
    if (result.hasException) {
      throw result.exception!;
    }

    List<Truck> trucks_to_return = result.data!['getTrucks']
        .map<Truck>((TrucksResult) => Truck(
            id: int.parse(TrucksResult['id'].toString()),
            registration: TrucksResult['registration'].toString(),
            status: TrucksResult['status'].toString(),
            weight_capacity: TrucksResult['weight_capacity'].toDouble(),
            volume_capacity: TrucksResult['volume_capacity'].toDouble(),
            fuel_type: TrucksResult['fuel_type'].toString(),
            fuel_capacity: TrucksResult['weight_capacity'].toDouble(),
            fuel_by_kilometer: TrucksResult['volume_capacity'].toDouble(),
            fuel: TrucksResult['fuel'].toDouble(),
            warehouse: int.parse(TrucksResult['warehouse'].toString())))
        .toList();

    //debugPrint(centers.length.toString());
    debugPrint(trucks_to_return.length.toString()); //LINEA DEBUG
    return trucks_to_return;
  }

  /*







        
        
        
        

  */
  @override
  Future<Truck> add(Truck truck) async {
    final MutationOptions options = MutationOptions(document: gql(createTruckMA), variables: <String, dynamic>{
      'truck': {
        //'id': truck.id,
        'registration': truck.registration,
        'status': truck.status,
        'weight_capacity': truck.weight_capacity,
        'volume_capacity': truck.volume_capacity,
        'fuel_type': truck.fuel_type,
        'fuel_capacity': truck.fuel_capacity,
        'fuel_by_kilometer': truck.fuel_by_kilometer,
        'fuel': truck.fuel,
        'warehouse': truck.warehouse
      }
    });
    final result = await getGraphQLClient().mutate(options);
    if (result.hasException) {
      throw result.exception!;
    }
    final TruckResult = result.data!['createTruck'];
    return Truck(
        id: int.parse(TruckResult['id'].toString()),
        registration: TruckResult['registration'].toString(),
        status: TruckResult['status'].toString(),
        weight_capacity: TruckResult['weight_capacity'].toDouble(),
        volume_capacity: TruckResult['volume_capacity'].toDouble(),
        fuel_type: TruckResult['fuel_type'].toString(),
        fuel_capacity: TruckResult['weight_capacity'].toDouble(),
        fuel_by_kilometer: TruckResult['volume_capacity'].toDouble(),
        fuel: TruckResult['fuel'].toDouble(),
        warehouse: int.parse(TruckResult['warehouse'].toString()));
  }

  /*





  */
  @override
  Future<int?> update(int? id, Truck truck) async {
    final MutationOptions options = MutationOptions(document: gql(updateTruckMA), variables: <String, dynamic>{
      'id': id,
      'truck': {
        'id': truck.id,
        'registration': truck.registration,
        'status': truck.status,
        'weight_capacity': truck.weight_capacity,
        'volume_capacity': truck.volume_capacity,
        'fuel_type': truck.fuel_type,
        'fuel_capacity': truck.fuel_capacity,
        'fuel_by_kilometer': truck.fuel_by_kilometer,
        'fuel': truck.fuel,
        'warehouse': truck.warehouse
      }
    });
    final result = await getGraphQLClient().mutate(options);
    if (result.hasException) {
      throw result.exception!;
    }

    return truck.id;
  }

  /*





  */
  @override
  Future<bool> delete(int id) async {
    final MutationOptions options = MutationOptions(document: gql(deleteTruckMA), variables: <String, dynamic>{'id': id});
    final result = await getGraphQLClient().mutate(options);
    if (result.hasException) {
      throw result.exception!;
    }
    return true;
  }
}
