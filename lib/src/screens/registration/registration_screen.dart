import 'package:flutter/material.dart';

import 'registration_provider.dart';
import '../../utils/validator.dart';
import '../../widgets/brewery/brewery_passwordfield.dart';
import '../../widgets/brewery/primary_button.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegistrationScreenState();
  }
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with Validator
    implements RegistrationProviderListener {
  var _email;
  var _password;
  var _firstname;
  var _lastname;
  var _confirmPassword;
  var _emailError;
  var _passwordError;
  var _confirmPasswordError;

  bool isLoading;
  RegistrationProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = RegistrationProvider(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Register',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Container(
          margin: EdgeInsets.all(20.0),
          child: Stack(
            children: <Widget>[_buildForm(), _buildLoader(isLoading ?? false)],
          )),
    );
  }

  Widget _buildForm() {
    return Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            labelText: 'Firstname',
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFCFD8DC))),
          ),
          cursorColor: Color(0xFF000000),
          onChanged: (text) {
            _firstname = text;
          },
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Lastname',
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFCFD8DC))),
          ),
          cursorColor: Color(0xFF000000),
          onChanged: (text) {
            _lastname = text;
          },
        ),
        SizedBox(
          height: 20.0,
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: _emailError,
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFCFD8DC))),
          ),
          cursorColor: Color(0xFF000000),
          onChanged: (text) {
            _email = text;
            setState(() {
              _emailError = validateEmail(_email);
            });
          },
        ),
        BreweryPasswordField(
          label: 'Password',
          onChanged: (text) {
            _password = text;
            setState(() {
              _passwordError = validatePasswords(_password, _confirmPassword);
              _confirmPasswordError =
                  validatePasswords(_password, _confirmPassword);
            });
          },
          errorText: _passwordError,
        ),
        BreweryPasswordField(
          label: 'Confirm Password',
          onChanged: (text) {
            _confirmPassword = text;
            setState(() {
              _passwordError = validatePasswords(_password, _confirmPassword);
              _confirmPasswordError =
                  validatePasswords(_password, _confirmPassword);
            });
          },
          errorText: _confirmPasswordError,
        ),
        SizedBox(
          height: 30.0,
        ),
        PrimaryButton(
            text: 'Register',
            minWidth: double.infinity,
            onPressed: _anyErrors
                ? null
                : () {
                    _provider.signup(
                        context, _email, _password, _firstname, _lastname);
                  }),
      ],
    );
  }

  bool get _anyErrors =>
      _emailError != null ||
      _passwordError != null ||
      _confirmPasswordError != null;

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

  _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registration Error'),
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

  _showAlertDialogSuccess() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registration Success'),
            content: Text('You can now login using your registered account!'),
            actions: <Widget>[
              SimpleDialogOption(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  void onFailed(String errors) {
    _showErrorDialog(errors);
  }

  @override
  void onLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  @override
  void onSignupSuccess() {
    _showAlertDialogSuccess();
  }
}
