import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';
import 'package:kurztrip_ma/src/data/client_config.dart';
import 'package:kurztrip_ma/src/domain/entities/distribution_center/DistributionCenter.dart';
import 'package:kurztrip_ma/src/domain/repositories/distribution_center_repository.dart';

class DistributionCenterServerRepository
    implements DistributionCenterRepository {
  DistributionCenter distributionCenter = DistributionCenter.createEmpty();

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
  final String createDistributionCenterMA = r'''
  mutation createDistributionCenterMA($distributionCenter:DistributionCenterInput!){
  createDistributionCenter(distribution_center:$distributionCenter){
    id
    address
    latitude_location
    longitude_location
    total_space
    available_space
  } 
}
  ''';
  final String deleteDistributionCenterMA = r'''
    mutation deleteDistributionCenterMA($id: Int!){
      deleteDistributionCenter(id: $id)
    }
  ''';

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
      throw result.exception!;
    }
    final distributionCenterResult =
        result.data!['getDistributionCenter']; //FUNCION DE GRAPHQL

    //debugPrint(distribution_center_result['address']);

    return DistributionCenter(
        id: distributionCenterResult['id'],
        address: distributionCenterResult['address'],
        latitude_location: distributionCenterResult['latitude_location'],
        longitude_location: distributionCenterResult['longitude_location'],
        total_space: distributionCenterResult['total_space'].toDouble(),
        available_space:
            distributionCenterResult['available_space'].toDouble());
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
      throw result.exception!;
    }

    List<DistributionCenter> centers = result.data!['getDistributionCenters']
        .map<DistributionCenter>((distributionCentersResult) =>
            DistributionCenter(
              id: int.parse(distributionCentersResult['id'].toString()),
              address: distributionCentersResult['address'].toString(),
              latitude_location: double.parse(
                  distributionCentersResult['latitude_location'].toString()),
              longitude_location: double.parse(
                  distributionCentersResult['longitude_location'].toString()),
              total_space: double.parse(
                  distributionCentersResult['total_space'].toString()),
              available_space: double.parse(
                  distributionCentersResult['available_space'].toString()),
            ))
        .toList();

    debugPrint(centers.toString());
    return centers;
  }

  @override
  Future<DistributionCenter> add(DistributionCenter distributionCenter) async {
    final MutationOptions options = MutationOptions(
        document: gql(createDistributionCenterMA),
        variables: <String, dynamic>{
          'distributionCenter': {
            'address': distributionCenter.address,
            'latitude_location': distributionCenter.latitude_location,
            'longitude_location': distributionCenter.longitude_location,
            'total_space': distributionCenter.total_space,
            'available_space': distributionCenter.available_space
          }
        });
    final result = await getGraphQLClient().mutate(options);
    if (result.hasException) {
      throw result.exception!;
    }
    final distributionCenterResult = result.data!['createDistributionCenter'];
    return DistributionCenter(
        id: int.parse(distributionCenterResult['id'].toString()),
        address: distributionCenterResult['address'].toString(),
        latitude_location:
            distributionCenterResult['latitude_location'].toDouble(),
        longitude_location:
            distributionCenterResult['longitude_location'].toDouble(),
        total_space: distributionCenterResult['total_space'].toDouble(),
        available_space:
            distributionCenterResult['available_space'].toDouble());
  }

  @override
  Future<bool> delete(int id) async {
    final MutationOptions options = MutationOptions(
        document: gql(deleteDistributionCenterMA),
        variables: <String, dynamic>{'id': id});
    final result = await getGraphQLClient().mutate(options);
    if (result.hasException) {
      throw result.exception!;
    }
    return true;
  }
  /*









*/

}
