import 'package:flutter/material.dart';

import '../login/login_provider.dart';
import '../../utils/routes.dart';
import '../../utils/validator.dart';
import '../../widgets/brewery/brewery_login.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with Validator implements LoginProviderListener {
  var _email;
  var _password;
  LoginProvider _provider;
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    _provider = LoginProvider(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
        child: Container(
      margin: EdgeInsets.only(top: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          login(),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.register);
            },
            child: Text(
              'Register',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Colors.black),
            ),
          )
        ],
      ),
    ));
  }

  Widget login() {
    return Stack(
      children: <Widget>[
        BreweryLoginWidget(
          usernameHint: 'Email',
          submitOnPressed: () {
            _provider.loginUser(_email, _password);
          },
          usernameOnChangeListener: (text) {
            _email = text;
            return validateEmail(_email);
          },
          passwordOnChangeListener: (text) {
            _password = text;
          },
        ),
        _buildLoader(_isLoading ?? false)
      ],
    );
  }

  Widget _buildLoader(bool show) {
    return Visibility(
        visible: show,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }

  _showAlertDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Error'),
            content: Text(message),
            actions: <Widget>[
              SimpleDialogOption(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  void onFailed(String error) {
    _showAlertDialog(context, error);
  }

  @override
  void onSuccess(data) {
    Navigator.popAndPushNamed(context, Routes.home);
  }

  @override
  void onLoading(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }
}
