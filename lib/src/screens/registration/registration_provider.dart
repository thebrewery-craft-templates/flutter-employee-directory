import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

import '../../../logger.dart';
import '../../resources/graphql_documents.dart';
import '../../resources/graphql_client.dart';
import '../../resources/storage/user_storage.dart';

final log = getLogger('RegistrationProvider');

class RegistrationProvider {
  RegistrationProviderListener _listener;

  String _username;
  String _password;
  String _firstname;
  String _lastname;

  RegistrationProvider(this._listener);

  signup(BuildContext context, String username, String password,
      String firstname, String lastname) async {
    this._username = username;
    this._password = password;
    this._firstname = firstname;
    this._lastname = lastname;

    if (_username != null &&
        _password != null &&
        _firstname != null &&
        _lastname != null) {
      _listener.onLoading(true);
      _checkEmployee(context);
    } else {
      _listener.onFailed('Please fill all the missing fields.');
    }
  }

  _checkEmployee(BuildContext context) async {
    log.i('Username | $_username');
    GraphQLClient _client = getGraphQLClientAuth();
    final QueryResult result = await _client.query(QueryOptions(
        document: checkEmployeeDocument,
        variables: <String, dynamic>{'username': _username}));

    if (result.hasErrors) {
      _listener.onLoading(false);
      _listener.onFailed(result.errors[0].message);
      return;
    }

    log.i('UserInfo | ${result.data}');
    var results = result.data['employees'];
    if (results['count'] > 0) {
      var id = results['edges'][0]['node']['objectId'];
      if (id != null) {
        await _signupUser(context, id);
      } else {
        _listener.onLoading(false);
        _listener.onFailed('Your email does not exist in our records');
      }
    } else {
      _listener.onLoading(false);
      _listener.onFailed('Your email does not exist in our records');
    }
  }

  _signupUser(BuildContext context, String employeeId) async {
    final QueryResult result = await getGraphQLClientAuth().mutate(
        MutationOptions(document: signupDocument, variables: <String, dynamic>{
      'username': _username,
      'password': _password,
      'employee': {'link': '$employeeId'}
    }));

    if (result.hasErrors) {
      _listener.onLoading(false);
      _listener.onFailed(result.errors[0].message);
      return;
    }

    log.i('CreatedUser | ${result.data}');
    //var signupData = result.data['createUser']['user'];
    //UserStorage(signupData);
    _updateUserInfo(context, employeeId);
    _listener.onSignupSuccess();
  }

  _updateUserInfo(BuildContext context, String employeeId) async {
    GraphQLClient _client = await getGraphQLClient(context);
    final QueryResult result = await _client.mutate(MutationOptions(
        document: updateEmloyeeInfo,
        variables: <String, dynamic>{
          'employeeId': employeeId,
          'firstname': _firstname,
          'lastname': _lastname,
        }));

    if (result.hasErrors) {
      _listener.onLoading(false);
      _listener.onFailed(result.errors[0].message);
      return;
    }

    //endSession(context);
  }

  endSession(BuildContext context) async {
    GraphQLClient _client = await getGraphQLClient(context);
    final QueryResult result =
        await _client.mutate(MutationOptions(document: logoutDocument));

    _listener.onLoading(false);
    if (result.hasErrors) {
      _listener.onFailed(result.errors[0].message);
      return;
    }

    UserStorage.clear();
    _listener.onSignupSuccess();
  }
}

class RegistrationProviderListener {
  void onSignupSuccess() {}
  void onFailed(String errors) {}
  void onLoading(bool loading) {}
}
