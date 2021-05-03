import 'dart:html';

import 'package:graphql/client.dart';
import 'package:kurztrip_ma/src/data/client_config.dart';
import 'package:kurztrip_ma/src/domain/entities/Tracking/Route.dart';
import 'package:kurztrip_ma/src/domain/entities/truck/Truck.dart';
import 'package:kurztrip_ma/src/domain/repositories/truck_repository.dart';

//implements TruckRepository
class TrackingServerRepository {
  Route route = Route.createEmpty();

  final String getRouteMA = r'''
    query getRouteMA($id: Int!){
        getRoute(id: $id) {
          starting_time
          p_longitudes
          p_latitudes
          driver_long
          driver_lat
          }
    }
  ''';

  final String createRouteMA = r'''
    mutation createRouteMA(new_route: TrackingIdRouteInput!){
      createRoute(new_route: $new_route){
          id
          starting_time
          p_longitudes
          p_latitudes
          driver_long
          driver_lat
      }
    }
  ''';

  final String updateRouteMA = r'''
    mutation updateRouteMA(id: Int!, route: TrackingRouteInput){
      updateRoute(id: $id, route: $route){
        id
        starting_time
        p_longitudes
        p_latitudes
        driver_long
        driver_lat
      }
    }
  ''';

  final String deleteRouteMA = r'''
    mutation deletePackage($id: Int!){
      deletePackage(id: $id)
    }
  ''';

  /*





  
  */
  @override
  Future<Route> get(int id) async {
    final QueryOptions options = QueryOptions(
      document: gql(getRouteMA), //NOMBRE DEL STRING QUERY O MUTATION
      variables: <String, dynamic>{
        'id': id,
      },
    );
    final result = await getGraphQLClient().query(options);
    if (result.hasException) {
      throw result.exception;
    }
    final route_result = result.data['getRoute']; //FUNCION DE GRAPHQL

    //debugPrint(distribution_center_result['address']);

    return Route(
        id: id,
        starting_time: route_result['starting_time'],
        p_longitudes: route_result['p_longitudes'],
        p_latitudes: route_result['p_latitudes'],
        driver_long: route_result['driver_long'],
        driver_lat: route_result['driver_lat']);
  }

/*








*/
  @override
  Future<Route> add(Route route) async {
    final MutationOptions options = MutationOptions(document: gql(createRouteMA), variables: <String, dynamic>{
      'new_route': {
        'starting_time': route.starting_time,
        'p_longitudes': route.p_longitudes,
        'p_latitudes': route.p_latitudes,
        'driver_long': route.driver_long,
        'driver_lat': route.driver_lat
      }
    });
    final result = await getGraphQLClient().mutate(options);
    if (result.hasException) {
      throw result.exception;
    }
    final route_result = result.data['createRoute'];
    return Route(
        id: route_result['id'],
        starting_time: route_result['starting_time'],
        p_longitudes: route_result['p_longitudes'],
        p_latitudes: route_result['p_latitudes'],
        driver_long: route_result['driver_long'],
        driver_lat: route_result['driver_lat']);
  }

/*








*/
  @override
  Future<Route> update(int id, Route route) async {
    final MutationOptions options = MutationOptions(document: gql(updateRouteMA), variables: <String, dynamic>{
      'id': id,
      'route': {
        'starting_time': route.starting_time,
        'p_longitudes': route.p_longitudes,
        'p_latitudes': route.p_latitudes,
        'driver_long': route.driver_long,
        'driver_lat': route.driver_lat
      }
    });
    final result = await getGraphQLClient().mutate(options);
    if (result.hasException) {
      throw result.exception;
    }
    final route_result = result.data['updateRoute'];
    return Route(
        id: route_result['id'],
        starting_time: route_result['starting_time'],
        p_longitudes: route_result['p_longitudes'],
        p_latitudes: route_result['p_latitudes'],
        driver_long: route_result['driver_long'],
        driver_lat: route_result['driver_lat']);
  }

  /*








*/
  @override
  Future<bool> delete(int id) async {
    final MutationOptions options = MutationOptions(document: gql(deleteRouteMA), variables: <String, dynamic>{'id': id});
    final result = await getGraphQLClient().mutate(options);
    if (result.hasException) {
      throw result.exception;
    }
    return true;
  }
}
