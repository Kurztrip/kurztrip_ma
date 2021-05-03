import 'package:graphql/client.dart';
import 'package:kurztrip_ma/src/data/client_config.dart';
import 'package:kurztrip_ma/src/domain/entities/Tracking/Route.dart';
import 'package:kurztrip_ma/src/domain/entities/analyse/AnalyseTruck.dart';
import 'package:kurztrip_ma/src/domain/entities/truck/Truck.dart';
import 'package:kurztrip_ma/src/domain/repositories/truck_repository.dart';

//implements TruckRepository
class AnalyseTruckServerRepository {
  AnalyseTruck analyse_truck = AnalyseTruck.createEmpty();

  //devuelve analyse truck
  final String createAnalyseRouteMA = r'''
    mutation createAnalyseRouteMA($id: Int!){
      createAnalyseRoute(id: $id){
        id
        packages
        route
        fuel
        fuel_capacity
        fuel_type
        fuel_by_kilometer
        weight_capacity
        volume_capacity
        state
        warehouse
      }
    }
  ''';
  /*
        id
        packages
        route
        fuel
        fuel_capacity
        fuel_type
        fuel_by_kilometer
        weight_capacity
        volume_capacity
        state
        warehouse
  */

  // @override
  Future<Route> createAnalyseRoute(int id) async {
    final MutationOptions options = MutationOptions(
        document: gql(createAnalyseRouteMA),
        variables: <String, dynamic>{
          'id': id,
        });
    final result = await getGraphQLClient().mutate(options);
    if (result.hasException) {
      throw result.exception;
    }
    final AT_result = result.data['createRoute'];
    return Route(
        id: AT_result['id'],
        starting_time: AT_result['starting_time'],
        p_longitudes: AT_result['p_longitudes'],
        p_latitudes: AT_result['p_latitudes'],
        driver_long: AT_result['driver_long'],
        driver_lat: AT_result['driver_lat']);
  }
}
