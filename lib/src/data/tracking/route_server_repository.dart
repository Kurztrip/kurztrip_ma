import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';
import 'package:kurztrip_ma/src/data/client_config.dart';
import 'package:kurztrip_ma/src/domain/entities/Tracking/Route.dart';
import 'package:kurztrip_ma/src/domain/repositories/tracking_repository.dart';
// import 'package:kurztrip_ma/src/domain/entities/truck/Truck.dart';
// import 'package:kurztrip_ma/src/domain/repositories/truck_repository.dart';

//implements TruckRepository
class TrackingServerRepository extends TrackingRepository{
  TrackingRoute route = TrackingRoute.createEmpty();

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

  final String getRoutesMA = r'''
    query getRoutesMA(){
        getRoutes() {
          truck_id
          starting_time
          p_longitudes
          p_latitudes
          driver_long
          driver_lat
          }
    }
  ''';

  final String createRouteMA = r'''
    mutation createRouteMA($new_route: TrackingIdRouteInput!){
      createRoute(new_route: $new_route){
          truck_id
          starting_time
          p_longitudes
          p_latitudes
          driver_long
          driver_lat
      }
    }
  ''';

  final String updateRouteMA = r'''
    mutation updateRouteMA($id: Int!, $route: TrackingRouteInput){
      updateRoute(id: $id, route: $route){
        starting_time
        p_longitudes
        p_latitudes
        driver_long
        driver_lat
      }
    }
  ''';

  final String deleteRouteMA = r'''
    mutation deleteRoute($id: Int!){
      deletePackage(id: $id)
    }
  ''';

  /*





  
  */
  // @override
  Future<TrackingRoute> get(int id) async {
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

    return TrackingRoute(
        truck_id: id,
        starting_time: route_result['starting_time'],
        p_longitudes: route_result['p_longitudes'],
        p_latitudes: route_result['p_latitudes'],
        driver_long: route_result['driver_long'],
        driver_lat: route_result['driver_lat']);
  }

/*








*/
  // @override
  Future<TrackingRoute> add(TrackingRoute route) async {
    final MutationOptions options = MutationOptions(document: gql(createRouteMA), variables: <String, dynamic>{
      'new_route': {
        'truck_id': route.truck_id,
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
    return TrackingRoute(
        starting_time: route_result['starting_time'],
        p_longitudes: route_result['p_longitudes'],
        p_latitudes: route_result['p_latitudes'],
        driver_long: route_result['driver_long'],
        driver_lat: route_result['driver_lat']);
  }

/*








*/
  // @override
  Future<TrackingRoute> update(int id, TrackingRoute route) async {
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
    final RouteResult = result.data['updateRoute'];
    return TrackingRoute(
        starting_time: RouteResult['starting_time'],
        p_longitudes: RouteResult['p_longitudes'].map((i) => i.toDouble()).toList(),
        p_latitudes: RouteResult['p_latitudes'].map((i) => i.toDouble()).toList(),
        driver_long: RouteResult['driver_long'].toDouble(),
        driver_lat: RouteResult['driver_lat'].toDouble());
  }

  /*








*/
  // @override
  Future<bool> delete(int id) async {
    final MutationOptions options = MutationOptions(document: gql(deleteRouteMA), variables: <String, dynamic>{'id': id});
    final result = await getGraphQLClient().mutate(options);
    if (result.hasException) {
      throw result.exception;
    }
    return true;
  }

  /*



  */
  @override
  Future<List<TrackingRoute>> getAll() async {
    final QueryOptions options = QueryOptions(document: gql(getRoutesMA) //NOMBRE DEL STRING QUERY O MUTATION

        );
    final result = await getGraphQLClient().query(options);
    if (result.hasException) {
      throw result.exception;
    }

    List<TrackingRoute> routes_to_return = result.data['getRoutes']
        .map<TrackingRoute>((RoutesResult) => TrackingRoute(
            truck_id: RoutesResult['truck_id'],
            starting_time: RoutesResult['starting_time'],
            p_longitudes: RoutesResult['p_longitudes'].map<double>((i) => double.parse(i.toString())).toList(),
            p_latitudes: RoutesResult['p_latitudes'].map<double>((i) => double.parse(i.toString())).toList()
            //driver_long: RoutesResult['driver_long'].toDouble(),
            //driver_lat: RoutesResult['driver_lat'].toDouble()))

            ))
        .toList();

    debugPrint(routes_to_return.length.toString()); //LINEA DEBUG
    return routes_to_return;
  }
}
