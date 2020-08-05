import 'package:flutter/material.dart';

class BreweryPasswordField extends StatefulWidget {

  final Icon _showPassIcon;
  final Icon _hidePassIcon;
  final ValueChanged<String> _onChanged;
  final String _errorText;
  final String _label;

  BreweryPasswordField(
      {String errorText,
      Icon showPassIcon,
      Icon hidePassIcon,
      String label,
      ValueChanged<String> onChanged})
      : _errorText = errorText,
        _showPassIcon = showPassIcon,
        _hidePassIcon = hidePassIcon,
        _label = label,
        _onChanged = onChanged;

  @override
  BreweryPasswordFieldState createState() => BreweryPasswordFieldState(
      errorText: _errorText,
      showPassIcon: _showPassIcon,
      hidePassIcon: _hidePassIcon,
      label: _label,
      onChanged: _onChanged);
}

class BreweryPasswordFieldState extends State<BreweryPasswordField> {
  // Initially password is obscure
  bool _obscureText = true;
  var _errorText;

  var _controller = TextEditingController();

  Icon _showPassIcon;
  Icon _hidePassIcon;
  String _label;
  ValueChanged<String> _onChanged;

  BreweryPasswordFieldState(
      {String errorText,
      Icon showPassIcon,
      Icon hidePassIcon,
      String label,
      ValueChanged<String> onChanged})
      : _errorText = errorText,
        _showPassIcon =
            showPassIcon == null ? Icon(Icons.lock_outline) : showPassIcon,
        _hidePassIcon =
            hidePassIcon == null ? Icon(Icons.lock_open) : hidePassIcon,
        _label = label ?? 'Password',
        _onChanged = onChanged;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void didUpdateWidget(BreweryPasswordField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget._errorText != widget._errorText) {
      _errorText = widget._errorText;
      _showPassIcon = widget._showPassIcon == null
          ? Icon(Icons.lock_outline)
          : widget._showPassIcon;
      _hidePassIcon = widget._hidePassIcon == null
          ? Icon(Icons.lock_open)
          : widget._hidePassIcon;
      _label = widget._label ?? 'Password';
      _onChanged = widget._onChanged;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Stack(
        children: <Widget>[
          new TextField(
            decoration: InputDecoration(
              labelText: _label,
              errorText: _errorText,
            ),
            onChanged: _onChanged,
            obscureText: _obscureText,
            controller: _controller,
          ),
          new Align(
            alignment: Alignment.centerRight,
            child: new IconButton(
              icon: _obscureText ? _showPassIcon : _hidePassIcon,
              tooltip: 'Show password',
              onPressed: _toggle,
            ),
          )
        ],
      ),
    );
  }
}
