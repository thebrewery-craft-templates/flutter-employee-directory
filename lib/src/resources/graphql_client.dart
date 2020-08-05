import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

import '../utils/config.dart';
import 'storage/user_storage.dart';

final HttpLink authHttpLink = HttpLink(uri: graphQLUrl, headers: {
  "X-Parse-Application-Id": appId,
  "X-Parse-Client-Key": clientKey
});

GraphQLClient getGraphQLClientAuth() {
  return GraphQLClient(
    link: authHttpLink,
    cache: InMemoryCache(),
  );
}

Future<GraphQLClient> getGraphQLClient(BuildContext context) async {
  HttpLink httpLink = await _getHttpLink(context);
  return GraphQLClient(
    link: httpLink,
    cache: InMemoryCache(),
  );
}

Future<HttpLink> _getHttpLink(BuildContext context) async {
  String _sessionToken = await UserStorage.getToken();

  return HttpLink(uri: graphQLUrl, headers: {
    "X-Parse-Application-Id": appId,
    "X-Parse-Client-Key": clientKey,
    "X-Parse-Session-Token": _sessionToken
  });
}
