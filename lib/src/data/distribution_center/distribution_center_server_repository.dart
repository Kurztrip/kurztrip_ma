import 'package:graphql/client.dart';
import 'package:kurztrip_ma/src/data/client_config.dart';
import 'package:kurztrip_ma/src/domain/entities/distribution_center/DistributionCenter.dart';
import 'package:kurztrip_ma/src/domain/repositories/distribution_center_repository.dart';

class DistributionCenterServerRepository
    implements DistributionCenterRepository {
  DistributionCenter distribution_center = DistributionCenter.createEmpty();
  final String getDistributionCenter = r'''
    query{
  getDistributionCenter($id: Int!){
    id
    address
    latitude_location
    longitude_location
    total_space
    available_space
  }
  
}
  ''';

  @override
  Future<DistributionCenter> get(int id) async {
    final QueryOptions options = QueryOptions(
      document: gql(getDistributionCenter),
      variables: <String, dynamic>{
        'id': id,
      },
    );
    final result = await getGraphQLClient().query(options);
    if (result.hasException) {
      throw result.exception;
    }
    final distribution_center_result = result.data['getDistributionCenter'];
    return DistributionCenter(
        id: distribution_center_result['id'],
        address: distribution_center_result['address'],
        latitude_location: distribution_center_result['latitude_location'],
        longitude_location: distribution_center_result['longitude_location'],
        total_space: distribution_center_result['total_space'],
        available_space: distribution_center_result['available_space']);
  }

  @override
  Future<bool> save(DistributionCenter distribution_center) async {
    return Future.delayed(const Duration(milliseconds: 100), () {
      this.distribution_center = distribution_center;
      return true;
    });
  }

  @override
  Future<List<DistributionCenter>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }
}
