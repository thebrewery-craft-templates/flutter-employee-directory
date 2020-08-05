import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

import '../../../logger.dart';
import '../../models/employee.dart';
import '../../resources/graphql_client.dart';
import '../../resources/graphql_documents.dart';

final log = getLogger('DirectoryProvider');

class DirectoryProvider {
  DirectoryProviderListener _listener;

  DirectoryProvider(this._listener);

  getAllEmployees(BuildContext context) async {
    GraphQLClient _client = await getGraphQLClient(context);
    final QueryResult result =
        await _client.mutate(MutationOptions(document: getAllEmployeeDocument));

    if (result.hasErrors) {
      log.e('GraphQL | ${result.errors}');
      _listener.onFailed(result.errors[0].message);
      return;
    }

    var data = result.data['employees']['edges'];
    List<Employee> employeeList = [];
    if (data is List) {
      data.forEach((item) {
        Employee employee = Employee.fromJson(item);
        employeeList.add(employee);
      });
    }

    _listener.onSuccess(employeeList);
  }
}

class DirectoryProviderListener {
  void onSuccess(List<Employee> employeeList) {}
  void onFailed(String error) {}
  void onLoading(bool loading) {}
}
