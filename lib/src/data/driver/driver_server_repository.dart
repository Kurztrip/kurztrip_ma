import 'package:graphql/client.dart';
import 'package:kurztrip_ma/src/data/client_config.dart';
import 'package:kurztrip_ma/src/domain/entities/driver/Locations.dart';
import 'package:kurztrip_ma/src/domain/repositories/locations_repository.dart';

import '../client_config.dart';

class DriverServerRepository implements LocationsRepository {
  Locations locations = Locations.createEmpty();
  final String getLocations = r'''
    query getLocations(){
      getAllLocations{
        id
        truck_id
        longitude
        latitude
      }
    }
  ''';

  final String getLocation = r'''
    query getOneLocation($id: Int!){
      getLocation(id: $id){
        id
        truck_id
        longitude
        latitude
      }
    }
  ''';

  final String createLocation = r'''
    mutation createOneLocation($location: LocationInput!){
      createLocation(location: $location)
    }
  ''';

  final String updateLocation = r'''
    mutation updateOneLocation($id: Int!, $location: LocationInput!){
      updateLocation(id: $id, location: $location)
    }
  ''';

  final String deleteLocation = r'''
    mutation deleteOneLocation($id: Int!){
      deleteLocation(id: $id)
      
    }
  ''';

  @override
  Future<List<Locations>> getAll() async {
    final QueryOptions options = QueryOptions(document: gql(getLocations));
    final result = await getGraphQLClient().query(options);
    if (result.hasException) {
      throw result.exception;
    }
    List<Locations> locations = result.data['getAllLocations']
        .map<Locations>((LocationsResult) => Locations(
            id: int.parse(LocationsResult['id'].toString()),
            //truckId: int.parse(LocationsResult['truck_id'].toString()),
            latitude: double.parse(LocationsResult['latitude'].toString()),
            longitude: double.parse(LocationsResult['longitude'].toString())))
        .toList();
    return locations;
  }

  @override
  Future<Locations> get(int id) async {
    final QueryOptions options = QueryOptions(
      document: gql(getLocation),
      variables: <String, dynamic>{'id': id},
    );
    final result = await getGraphQLClient().query(options);
    if (result.hasException) {
      throw result.exception;
    }
    final locationResult = result.data['getLocation'];
    return Locations(
        id: int.parse(locationResult['id'].toString()),
        //truckId: int.parse(locationResult['truck_id'].toString()),
        latitude: double.parse(locationResult['latitude'].toString()),
        longitude: double.parse(locationResult['longitude'].toString()));
  }

  @override
  Future<bool> add(Locations locations) async {
    final MutationOptions options = MutationOptions(
        document: gql(createLocation),
        variables: <String, dynamic>{
          'location': {
            //'truck_id': locations.truckId,
            'latitude': locations.latitude,
            'longitude': locations.longitude
          }
        });
    final result = await getGraphQLClient().mutate(options);
    if (result.hasException) {
      throw result.exception;
    }
    return true;
  }

  @override
  Future<bool> update(int id, Locations locations) async {
    final MutationOptions options = MutationOptions(
        document: gql(updateLocation),
        variables: <String, dynamic>{
          'id': id,
          'location': {
            //'truck_id': locations.truckId,
            'latitude': locations.latitude,
            'longitude': locations.longitude
          }
        });
    final result = await getGraphQLClient().mutate(options);
    if (result.hasException) {
      throw result.exception;
    }
    return true;
  }

  @override
  Future<bool> delete(int id) async {
    final MutationOptions options = MutationOptions(
        document: gql(deleteLocation), variables: <String, dynamic>{'id': id});
    final result = await getGraphQLClient().mutate(options);
    if (result.hasException) {
      throw result.exception;
    }
    return true;
  }
}
