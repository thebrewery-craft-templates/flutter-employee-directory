import 'package:flutter/material.dart';

import '../../../logger.dart';
import 'directory_provider.dart';
import '../profile/profile_screen.dart';
import '../../models/employee.dart';
import '../../utils/routes.dart';
import '../../widgets/brewery/brewery_scrollablelist_with_header.dart';

final log = getLogger('DirectoryScreen');

class DirectoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DirectoryScreenState();
}

class _DirectoryScreenState extends State<DirectoryScreen>
    implements ScrollableListWithHeaderListener, DirectoryProviderListener {
  List<Employee> _employeeList = [];
  DirectoryProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = DirectoryProvider(this);
    _provider.getAllEmployees(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }

  Widget _buildBody() {
    return ScrollableListWithHeader(
      _employeeList,
      boldFirstText: true,
      listener: this,
    );
  }

  @override
  void onListItemClick(String id, item) {
    if (item is Employee) {
      Navigator.pushNamed(context, Routes.profile,
          arguments: ProfileArguments(employee: item, enableEdit: false));
    }
  }

  @override
  void onFailed(String error) {
    // ignore: unnecessary_brace_in_string_interps
    log.e('onFailed | ${error}');
  }

  @override
  void onLoading(bool loading) {
    // TODO: implement onLoading
  }

  @override
  void onSuccess(List<Employee> employeeList) {
    setState(() {
      _employeeList = employeeList;
    });
  }
}
