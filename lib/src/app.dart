import 'package:flutter/material.dart';

import 'router.dart';

class MyApp extends StatefulWidget {
  final Widget defaultHome;

  MyApp(this.defaultHome);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Employee Directory',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: widget.defaultHome,

      onGenerateRoute: Router.generateRoute,
    );
  }
}


