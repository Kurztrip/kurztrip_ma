import 'dart:io';

import 'package:graphql/client.dart';
import 'package:http/io_client.dart';

GraphQLClient getGraphQLClient() {
  final HttpClient _httpClient = new HttpClient();
  _httpClient.badCertificateCallback =
      (X509Certificate cert, String host, int port) => true;
  final IOClient _ioClient = new IOClient(_httpClient);
  final _httpLink = HttpLink(
    'https://api.apps.3.93.103.212.nip.io/graphql',
    httpClient: _ioClient,
  );

  // final _authLink = AuthLink(
  //   getToken: () async => 'Bearer $YOUR_PERSONAL_ACCESS_TOKEN',
  // );
  // Link _link = _authLink.concat(_httpLink);
  return GraphQLClient(

      /// **NOTE** The default store is the InMemoryStore, which does NOT persist to disk
      cache: GraphQLCache(),
      link: _httpLink,
      defaultPolicies:
          DefaultPolicies(query: Policies(fetch: FetchPolicy.cacheAndNetwork)));
}
