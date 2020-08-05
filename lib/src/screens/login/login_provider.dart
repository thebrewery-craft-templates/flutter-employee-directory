import 'package:graphql/client.dart';

import '../../../logger.dart';
import '../../resources/graphql_documents.dart';
import '../../resources/graphql_client.dart';
import '../../resources/storage/user_storage.dart';

final log = getLogger('Router');

class LoginProvider {
  LoginProviderListener _listener;

  LoginProvider(this._listener);

  loginUser(String username, String password) async {
    if (username != null && password != null) {
      _listener.onLoading(true);

      final QueryResult result = await getGraphQLClientAuth().mutate(
          MutationOptions(document: loginDocument, variables: <String, dynamic>{
        'username': username,
        'password': password
      }));

      _listener.onLoading(false);

      if (result.hasErrors) {
        _listener.onFailed(result.errors[0].message);
        return;
      }

      log.i('LoginProvider | ${result.data}');
      var loginData = result.data['logIn']['viewer'];
      UserStorage(loginData);

      _listener.onSuccess('');
    } else {
      _listener.onFailed('Please fill all the missing fields.');
      return;
    }
  }
}

class LoginProviderListener {
  void onSuccess(dynamic data) {}
  void onFailed(String error) {}
  void onLoading(bool loading) {}
}
