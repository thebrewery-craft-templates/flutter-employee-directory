import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../logger.dart';
import '../../models/employee.dart';
import '../../resources/graphql_documents.dart';
import '../../resources/graphql_client.dart';
import '../../resources/storage/user_storage.dart';

final log = getLogger('HomeProvider');

class HomeProvider {
  HomeProviderListener _listener;

  HomeProvider(this._listener);

  logoutUser(BuildContext context) async {
    GraphQLClient _client = await getGraphQLClient(context);
    final QueryResult result =
        await _client.mutate(MutationOptions(document: logoutDocument));

    if (result.hasErrors) {
      _listener.onLogoutFailed(result.errors[0].message);
      return;
    }

    var isLoggedOut = result.data['logOut'];
    if (isLoggedOut['viewer'] != null) {
      UserStorage.clear();
      _listener.onLogoutSuccess();
    } else {
      _listener.onLogoutFailed('Cannot logout user. Please try again.');
    }
  }

  getMyInfo(BuildContext context) async {
    GraphQLClient _client = await getGraphQLClient(context);
    final QueryResult result =
        await _client.query(QueryOptions(document: getMyInfoDocument));

    if (result.hasErrors) {
      log.e('GraphQL | ${result.errors[0].message}');
      return;
    }

    log.i('UserInfo | ${result.data}');
    var userInfo = result.data['viewer']['user'];
    if (userInfo['employee'] != null) {
      //UserStorage(userInfo);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(
          'my_employee_info', '${json.encode(userInfo['employee'])}');

      log.i('SharedPref | ${result.data}');
      var myEmployeeInfo = prefs.get('my_employee_info');

      _listener.onGetMyInfoSuccess(
          Employee.fromInfoJSON(json.decode(myEmployeeInfo)));
    }
  }
}

class HomeProviderListener {
  void onLogoutFailed(String error) {}
  void onLogoutSuccess() {}
  void onLoading(bool loading) {}
  void onGetMyInfoSuccess(Employee employee) {}
}
