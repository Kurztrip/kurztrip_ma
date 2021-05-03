import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';
import 'package:kurztrip_ma/src/data/client_config.dart';
import 'package:kurztrip_ma/src/domain/entities/distribution_center/DistributionCenter.dart';
import 'package:kurztrip_ma/src/domain/repositories/distribution_center_repository.dart';

class DistributionCenterServerRepository
    implements DistributionCenterRepository {
  DistributionCenter distribution_center = DistributionCenter.createEmpty();

  final String getDistributionCenterMA = r'''
    query getDistributionCenterMA($id: Int!){
        getDistributionCenter(id: $id) {
          id
          address
          latitude_location
          longitude_location
          total_space
          available_space
          }
    }
  ''';

  final String getDistributionCentersMA = r'''
  query getDistributionCentersMA(){
  getDistributionCenters{
    id
    address
    latitude_location
    longitude_location
    total_space
    available_space
  } 
}
  ''';

/*









*/
  @override
  Future<DistributionCenter> get(int id) async {
    final QueryOptions options = QueryOptions(
      document:
          gql(getDistributionCenterMA), //NOMBRE DEL STRING QUERY O MUTATION
      variables: <String, dynamic>{
        'id': id,
      },
    );
    final result = await getGraphQLClient().query(options);
    if (result.hasException) {
      throw result.exception;
    }
    final distribution_center_result =
        result.data['getDistributionCenter']; //FUNCION DE GRAPHQL

    //debugPrint(distribution_center_result['address']);

    return DistributionCenter(
        id: distribution_center_result['id'],
        address: distribution_center_result['address'],
        latitude_location: distribution_center_result['latitude_location'],
        longitude_location: distribution_center_result['longitude_location'],
        total_space: distribution_center_result['total_space'].toDouble(),
        available_space:
            distribution_center_result['available_space'].toDouble());
  }

/*









*/
  @override
  Future<List<DistributionCenter>> getAll() async {
    final QueryOptions options = QueryOptions(
        document:
            gql(getDistributionCentersMA) //NOMBRE DEL STRING QUERY O MUTATION

        );
    final result = await getGraphQLClient().query(options);
    if (result.hasException) {
      throw result.exception;
    }

    List<DistributionCenter> centers = result.data['getDistributionCenters']
        .map<DistributionCenter>((DistributionCentersResult) =>
            DistributionCenter(
              id: int.parse(DistributionCentersResult['id'].toString()),
              address: DistributionCentersResult['address'].toString(),
              latitude_location: double.parse(
                  DistributionCentersResult['latitude_location'].toString()),
              longitude_location: double.parse(
                  DistributionCentersResult['longitude'].toString()),
              total_space: double.parse(
                  DistributionCentersResult['total_space'].toString()),
              available_space: double.parse(
                  DistributionCentersResult['available_space'].toString()),
            ))
        .toList();

    debugPrint(centers.length.toString());
    return centers;
  }
  /*









*/

}
