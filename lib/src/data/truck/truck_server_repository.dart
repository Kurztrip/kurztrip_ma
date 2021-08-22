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
    final truckResult = result.data!['getTruck'];

    debugPrint(truckResult['registration'].toString()); //LINEA DEBUG

    return Truck(
        id: int.parse(truckResult['id'].toString()),
        registration: truckResult['registration'].toString(),
        status: truckResult['status'].toString(),
        weight_capacity: truckResult['weight_capacity'].toDouble(),
        volume_capacity: truckResult['volume_capacity'].toDouble(),
        fuel_type: truckResult['fuel_type'].toString(),
        fuel_capacity: truckResult['weight_capacity'].toDouble(),
        fuel_by_kilometer: truckResult['volume_capacity'].toDouble(),
        fuel: truckResult['fuel'].toDouble(),
        warehouse: int.parse(truckResult['warehouse'].toString()));
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
    final QueryOptions options = QueryOptions(
        document: gql(getTrucksMA) //NOMBRE DEL STRING QUERY O MUTATION

        );
    final result = await getGraphQLClient().query(options);
    if (result.hasException) {
      throw result.exception!;
    }

    List<Truck> trucksToReturn = result.data!['getTrucks']
        .map<Truck>((trucksResult) => Truck(
            id: int.parse(trucksResult['id'].toString()),
            registration: trucksResult['registration'].toString(),
            status: trucksResult['status'].toString(),
            weight_capacity: trucksResult['weight_capacity'].toDouble(),
            volume_capacity: trucksResult['volume_capacity'].toDouble(),
            fuel_type: trucksResult['fuel_type'].toString(),
            fuel_capacity: trucksResult['weight_capacity'].toDouble(),
            fuel_by_kilometer: trucksResult['volume_capacity'].toDouble(),
            fuel: trucksResult['fuel'].toDouble(),
            warehouse: int.parse(trucksResult['warehouse'].toString())))
        .toList();

    //debugPrint(centers.length.toString());
    debugPrint(trucksToReturn.length.toString()); //LINEA DEBUG
    return trucksToReturn;
  }

  /*







        
        
        
        

  */
  @override
  Future<Truck> add(Truck truck) async {
    final MutationOptions options = MutationOptions(
        document: gql(createTruckMA),
        variables: <String, dynamic>{
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
    final truckResult = result.data!['createTruck'];
    return Truck(
        id: int.parse(truckResult['id'].toString()),
        registration: truckResult['registration'].toString(),
        status: truckResult['status'].toString(),
        weight_capacity: truckResult['weight_capacity'].toDouble(),
        volume_capacity: truckResult['volume_capacity'].toDouble(),
        fuel_type: truckResult['fuel_type'].toString(),
        fuel_capacity: truckResult['weight_capacity'].toDouble(),
        fuel_by_kilometer: truckResult['volume_capacity'].toDouble(),
        fuel: truckResult['fuel'].toDouble(),
        warehouse: int.parse(truckResult['warehouse'].toString()));
  }

  /*





  */
  @override
  Future<int?> update(int? id, Truck truck) async {
    final MutationOptions options = MutationOptions(
        document: gql(updateTruckMA),
        variables: <String, dynamic>{
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
    final MutationOptions options = MutationOptions(
        document: gql(deleteTruckMA), variables: <String, dynamic>{'id': id});
    final result = await getGraphQLClient().mutate(options);
    if (result.hasException) {
      throw result.exception!;
    }
    return true;
  }
}
