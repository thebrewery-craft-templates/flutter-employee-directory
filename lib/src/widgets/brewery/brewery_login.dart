import 'package:flutter/material.dart';

import 'utils/alias.dart';
import '../../widgets/brewery/brewery_passwordfield.dart';
import '../../widgets/brewery/primary_button.dart';

class BreweryLoginWidget extends StatefulWidget {
  final Image logo;
  final usernameHint;

//  final ValueChanged<String> usernameOnChangeListener;
  final PasswordChanged passwordOnChangeListener;
  final EmailChanged usernameOnChangeListener;
  final VoidCallback submitOnPressed;
  var usernameController = TextEditingController();
  var passwordController;

  get username => usernameController.text;

  BreweryLoginWidget({
    Key key,
    this.logo,
    this.usernameHint,
    this.usernameOnChangeListener,
    this.passwordOnChangeListener,
    this.submitOnPressed,
  });

  @override
  State<StatefulWidget> createState() {
    return _BreweryLoginWidgetState();
  }
}

class _BreweryLoginWidgetState extends State<BreweryLoginWidget> {
  Image _logo;
  var _usernameHint;

//  final ValueChanged<String> usernameOnChangeListener;
  PasswordChanged _passwordOnChangeListener;
  EmailChanged _usernameOnChangeListener;
  VoidCallback _submitOnPressed;
  TextEditingController _usernameController;
  var _passwordController;

  var _emailError;
  var _passwordError;

  @override
  void initState() {
    super.initState();
    _logo = widget.logo;
    _usernameHint = widget.usernameHint;
    _passwordOnChangeListener = widget.passwordOnChangeListener;
    _usernameOnChangeListener = widget.usernameOnChangeListener;
    _submitOnPressed = widget.submitOnPressed;
    _usernameController = widget.usernameController;
    _passwordController = widget.passwordController;
  }

  bool shouldShowImage() {
    return _logo != null;
  }

  @override
  Widget build(BuildContext context) {
    var logoImage;
    if (shouldShowImage()) {
      logoImage = new Container(
        width: 80.0,
        height: 80.0,
      );
    } else {
      logoImage = new Container(
        width: 80.0,
        height: 80.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
      );
    }

    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            logoImage,
            Container(
                width: 300,
                margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
                child: TextField(
                  onChanged: (text) {
                    setState(() {
                      _emailError = _usernameOnChangeListener(text);
                    });
                  },
                  controller: _usernameController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFCFD8DC))),
                    hintText: _usernameHint,
                    labelText: _usernameHint,
                    errorText: _emailError,
                  ),
                  cursorColor: Color(0xFF000000),
                )),
            Container(
              width: 300,
              margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: BreweryPasswordField(
                  onChanged: (text) {
                    setState(() {
                      _passwordError = _passwordOnChangeListener(text);
                    });
                  },
                  errorText: _passwordError),
            ),
            PrimaryButton(
                minWidth: double.infinity,
                onPressed: _anyErrors
                    ? null
                    : _submitOnPressed,
                text: 'Login'),
          ]),
    );
  }

  bool get _anyErrors => _emailError != null || _passwordError != null;
}
