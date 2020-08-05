import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'src/app.dart';
import 'src/resources/storage/user_storage.dart';
import 'src/screens/home/home_screen.dart';
import 'src/screens/login/login_screen.dart';

Future main() async {
  Logger.level = Level.verbose;

  final envFile = kReleaseMode ? '.env.prod' : '.env';
  await DotEnv().load(envFile);
  final widget = await getWidget();
  runApp(MyApp(widget));
}

Future<Widget> getWidget() async {
  String sessionToken = await UserStorage.getToken();
  if (sessionToken != null) {
    return HomeScreen();
  }
  return LoginScreen();
}
