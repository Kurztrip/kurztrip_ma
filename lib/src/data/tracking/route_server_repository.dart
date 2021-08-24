import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';
import 'package:kurztrip_ma/src/data/client_config.dart';
import 'package:kurztrip_ma/src/domain/entities/Tracking/Route.dart';
import 'package:kurztrip_ma/src/domain/repositories/tracking_repository.dart';
// import 'package:kurztrip_ma/src/domain/entities/truck/Truck.dart';
// import 'package:kurztrip_ma/src/domain/repositories/truck_repository.dart';

//implements TruckRepository
class TrackingServerRepository extends TrackingRepository {
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
  final String getFreeRoutesMA = r'''
    query getFreeRoutesMA(){
        getFreeRoutes()
    }
  ''';
  final String createDriverRouteLinkMA = r'''
    mutation createDriverRouteLinkMA($id: String!, $route: Int!){
      createDriverRouteLink(new_link:{driver_id: $id, route_id: $route}){
        route_id
      }
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
      throw result.exception!;
    }
    final routeResult = result.data!['getRoute']; //FUNCION DE GRAPHQL

    //debugPrint(distribution_center_result['address']);

    return TrackingRoute(
        truck_id: id,
        starting_time: routeResult['starting_time'],
        p_longitudes: routeResult['p_longitudes'],
        p_latitudes: routeResult['p_latitudes'],
        driver_long: routeResult['driver_long'],
        driver_lat: routeResult['driver_lat']);
  }

/*








*/
  // @override
  Future<TrackingRoute> add(TrackingRoute route) async {
    final MutationOptions options = MutationOptions(
        document: gql(createRouteMA),
        variables: <String, dynamic>{
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
      throw result.exception!;
    }
    final routeResult = result.data!['createRoute'];
    return TrackingRoute(
        starting_time: routeResult['starting_time'],
        p_longitudes: routeResult['p_longitudes'],
        p_latitudes: routeResult['p_latitudes'],
        driver_long: routeResult['driver_long'],
        driver_lat: routeResult['driver_lat']);
  }

/*








*/
  // @override
  Future<TrackingRoute> update(int id, TrackingRoute route) async {
    final MutationOptions options = MutationOptions(
        document: gql(updateRouteMA),
        variables: <String, dynamic>{
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
      throw result.exception!;
    }
    final routeResult = result.data!['updateRoute'];
    return TrackingRoute(
        starting_time: routeResult['starting_time'],
        p_longitudes:
            routeResult['p_longitudes'].map((i) => i.toDouble()).toList(),
        p_latitudes:
            routeResult['p_latitudes'].map((i) => i.toDouble()).toList(),
        driver_long: routeResult['driver_long'].toDouble(),
        driver_lat: routeResult['driver_lat'].toDouble());
  }

  /*








*/
  @override
  Future<bool> delete(int id) async {
    final MutationOptions options = MutationOptions(
        document: gql(deleteRouteMA), variables: <String, dynamic>{'id': id});
    final result = await getGraphQLClient().mutate(options);
    if (result.hasException) {
      throw result.exception!;
    }
    return true;
  }

  /*



  */
  @override
  Future<List<TrackingRoute>> getAll() async {
    final QueryOptions options = QueryOptions(
        document: gql(getRoutesMA) //NOMBRE DEL STRING QUERY O MUTATION

        );
    final result = await getGraphQLClient().query(options);
    if (result.hasException) {
      throw result.exception!;
    }

    List<TrackingRoute> routesToReturn = result.data!['getRoutes']
        .map<TrackingRoute>((routesResult) => TrackingRoute(
            truck_id: routesResult['truck_id'],
            starting_time: routesResult['starting_time'],
            p_longitudes: routesResult['p_longitudes']
                .map<double>((i) => double.parse(i.toString()))
                .toList(),
            p_latitudes: routesResult['p_latitudes']
                .map<double>((i) => double.parse(i.toString()))
                .toList()
            //driver_long: RoutesResult['driver_long'].toDouble(),
            //driver_lat: RoutesResult['driver_lat'].toDouble()))

            ))
        .toList();

    debugPrint(routesToReturn.length.toString()); //LINEA DEBUG
    return routesToReturn;
  }

  @override
  Future<List<int>> getFree() async {
    final QueryOptions options = QueryOptions(
        document: gql(getFreeRoutesMA) //NOMBRE DEL STRING QUERY O MUTATION

        );
    final result = await getGraphQLClient().query(options);
    if (result.hasException) {
      throw result.exception!;
    }

    List<int> routesToReturn = result.data!['getFreeRoutes']
        .map<int>((routesResult) => int.parse(routesResult.toString()))
        .toList();

    debugPrint(routesToReturn.length.toString()); //LINEA DEBUG
    return routesToReturn;
  }

  // @override
  Future<bool> assign(String id, int route) async {
    final MutationOptions options = MutationOptions(
        document: gql(createDriverRouteLinkMA),
        variables: <String, dynamic>{'id': id, 'route': route});
    final result = await getGraphQLClient().mutate(options);
    if (result.hasException) {
      throw result.exception!;
    }
    return true;
  }
}
