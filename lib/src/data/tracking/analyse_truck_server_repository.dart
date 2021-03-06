import 'package:graphql/client.dart';
import 'package:kurztrip_ma/src/data/client_config.dart';
import 'package:kurztrip_ma/src/domain/entities/analyse/AnalyseTruck.dart';
import 'package:kurztrip_ma/src/domain/repositories/analyse_repository.dart';

//implements TruckRepository
class AnalyseTruckServerRepository extends AnalyseRepository {
  AnalyseTruck analyseTruck = AnalyseTruck.createEmpty();

  //devuelve analyse truck
  final String createAnalyseRouteMA = r'''
    mutation createAnalyseRouteMA($id: Int!){
      createAnalyseRoute(id: $id){
        id
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

  @override
  Future<bool> createAnalyseRoute(int id) async {
    final MutationOptions options = MutationOptions(
        document: gql(createAnalyseRouteMA),
        variables: <String, dynamic>{
          'id': id,
        });
    final result = await getGraphQLClient().mutate(options);
    if (result.hasException) {
      throw result.exception!;
    }
    // final ATResult = result.data!['createAnalyseRoute'];
    return true;
  }
}
