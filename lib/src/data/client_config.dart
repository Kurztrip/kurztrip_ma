import 'package:graphql/client.dart';

GraphQLClient getGraphQLClient() {
  final _httpLink = HttpLink(
    'http://18.209.20.0/graphql',
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
