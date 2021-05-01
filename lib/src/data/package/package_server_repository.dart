import 'package:graphql/client.dart';
import 'package:kurztrip_ma/src/data/client_config.dart';
import 'package:kurztrip_ma/src/domain/entities/package/Package.dart';
import 'package:kurztrip_ma/src/domain/repositories/package_repository.dart';

import '../client_config.dart';

class PackageServerRepository implements PackageRepository{
  Package package = Package.createEmpty();
  final String getPackage = r'''
    query getOnePackage($id: Int!){
      getPackage(id: $id){
        id
        storeId
        weight
        volume
        latitude
        longitude
        address
      }
    }
  ''';

  final String getPackages = r'''
    query getAllPackages(){
      getPackages{
        id
        storeId
        weight
        volume
        latitude
        longitude
        address
      }
    }
  ''';

  final String createPackage = r'''
    mutation createPackage($new_package: PackageInput!){
      createPackage(new_package: $new_package){
        id
        storeId
        weight
        volume
        latitude
        longitude
        address
      }
    }
  ''';

  final String updatePackage = r'''
    mutation updateOnePackage($id: Int!, $package: PackageInput!){
      updatePackage(id: $id, package: $package){
        id
        storeId
        weight
        volume
        latitude
        longitude
        address
      }
    }
  ''';

  final String deletePackage = r'''
    mutation deletePackage($id: Int!){
      deletePackage(id: $id)
    }
  ''';

// weight
// volume
// latitude
// longitude
// address

@override
Future<Package> get(int id) async {
  final QueryOptions options = QueryOptions(
    document: gql(getPackage),
    variables: <String, dynamic>{
      'id': id
    },
  );
  final result = await getGraphQLClient().query(options);
  if(result.hasException) {
    throw result.exception;
  }
  print(result.data);
  final packageResult = result.data['getPackage'];
  return Package(id: int.parse(packageResult['id'].toString()), storeId: int.parse(packageResult['storeId'].toString()), address: packageResult['address'].toString(), weight: double.parse(packageResult['weight'].toString()), volume: double.parse(packageResult['volume'].toString()), latitude: double.parse(packageResult['latitude'].toString()), longitude: double.parse(packageResult['longitude'].toString()), receiver: packageResult['receiver'].toString(), idReceiver: packageResult['idReceiver'].toString());
}

@override
Future<Package> add(Package package) async {
  final MutationOptions options = MutationOptions(
    document: gql(createPackage),
    variables: <String, dynamic>{
      'new_package':{
        'address': package.address,
        'weight': package.weight,
        'volume': package.volume,
        'longitude': package.longitude,
        'latitude': package.latitude,
        'storeId': package.storeId,
        'receiver': package.receiver,
        'idReceiver': package.idReceiver
      }
    }
  );
  final result = await getGraphQLClient().mutate(options);
  if(result.hasException){
    throw result.exception;
  }
  final packageResult = result.data['createPackage'];
  return Package(id: int.parse(packageResult['id'].toString()), storeId: int.parse(packageResult['storeId'].toString()), address: packageResult['address'].toString(), weight: double.parse(packageResult['weight'].toString()), volume: double.parse(packageResult['volume'].toString()), latitude: double.parse(packageResult['latitude'].toString()), longitude: double.parse(packageResult['longitude'].toString()), receiver: packageResult['receiver'].toString(), idReceiver: packageResult['idReceiver'].toString());
}



@override
Future<List<Package>> getAll() async{
  final QueryOptions options = QueryOptions(
    document: gql(getPackages)
  );
  final result = await getGraphQLClient().query(options);
  if(result.hasException){
    throw result.exception;
  }

}

@override
Future<Package> update(int id, Package package) async{
  final MutationOptions options = MutationOptions(
      document: gql(updatePackage),
      variables: <String, dynamic>{
        'id': id,
        'package':{
          'address': package.address,
          'weight': package.weight,
          'volume': package.volume,
          'longitude': package.longitude,
          'latitude': package.latitude,
          'storeId': package.storeId,
          'receiver': package.receiver,
          'idReceiver': package.idReceiver
        }
      }
  );
  final result = await getGraphQLClient().mutate(options);
  if(result.hasException){
    throw result.exception;
  }
  final packageResult = result.data['updatePackage'];
  return Package(id: int.parse(packageResult['id'].toString()), storeId: int.parse(packageResult['storeId'].toString()), address: packageResult['address'].toString(), weight: double.parse(packageResult['weight'].toString()), volume: double.parse(packageResult['volume'].toString()), latitude: double.parse(packageResult['latitude'].toString()), longitude: double.parse(packageResult['longitude'].toString()), receiver: packageResult['receiver'].toString(), idReceiver: packageResult['idReceiver'].toString());
}

@override
Future<bool> delete(int id) async{
  final MutationOptions options = MutationOptions(
    document: gql(deletePackage),
    variables: <String, dynamic>{
      'id': id
    }
  );
  final result = await getGraphQLClient().mutate(options);
  if(result.hasException){
    throw result.exception;
  }
  return true;
}

}
