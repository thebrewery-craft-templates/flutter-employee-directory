import 'dart:convert';

import '../../models/employee.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../logger.dart';
import 'secure_storage.dart';

final log = getLogger('UserStorage');

class UserStorage {
  UserStorage(dynamic data) {
    var sessionToken = data['sessionToken'];
    //var employee = data['employee'];

    if (sessionToken != null) {
      _setSessionToken(sessionToken);
    }

    // if (employee != null) {
    //   _setMyEmployeeInfo(employee);
    // }
  }

  _setSessionToken(dynamic sessionToken) {
    SecureStorage.instance.save('session_token', sessionToken);
  }

  // _setMyEmployeeInfo(dynamic userInfo) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('my_employee_info', '${json.encode(userInfo)}');
  // }

  static Future<String> getToken() {
    return SecureStorage.instance.read('session_token');
  }

  static Future<Employee> getMyEmployeeInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var myEmployeeInfo = prefs.get('my_employee_info');
    // ignore: unnecessary_brace_in_string_interps
    log.i('SharedPref - my_employee_info | ${myEmployeeInfo}');
    return Employee.fromInfoJSON(json.decode(myEmployeeInfo));
  }

  static Future<String> getMyEmployeeID() async {
    Employee employee = await getMyEmployeeInfo();
    return employee.id;
  }

  static clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    SecureStorage.instance.delete('session_token');
  }
}
