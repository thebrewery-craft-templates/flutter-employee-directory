import 'package:flutter/material.dart';

import '../logger.dart';
import 'models/employee.dart';
import 'screens/directory/directory_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/registration/registration_screen.dart';
import 'screens/search/search_screen.dart';
import 'utils/routes.dart';

final log = getLogger('Router');

class Router {
  static Route generateRoute(RouteSettings settings) {
    log.i('generateRoute | ${settings.name}');
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case Routes.directory:
        return MaterialPageRoute(builder: (context) => DirectoryScreen());
      case Routes.home:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case Routes.search:
        return MaterialPageRoute(builder: (context) => SearchScreen());
      case Routes.register:
        return MaterialPageRoute(builder: (context) => RegistrationScreen());
      case Routes.profile:
        ProfileArguments profileArguments = settings.arguments;

        Employee employee = profileArguments.employee;
        bool enableEdit = profileArguments.enableEdit;

        return MaterialPageRoute(
            builder: (_) => ProfileScreen(
                  employee,
                  enableEdit: enableEdit,
                ));

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
