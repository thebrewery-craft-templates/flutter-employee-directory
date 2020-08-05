import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  VoidCallback _onPressed;
  String _text;
  bool _disabled;
  Color _textColor;
  Color _disabledTextColor;
  Color _color;
  Color _borderColor;
  Color _disabledColor;
  Color _splashColor;
  double _elevation;
  double _highlightElevation;
  double _minWidth;
  double _minHeight;
  EdgeInsetsGeometry padding;

  PrimaryButton({
    Key key,
    @required VoidCallback onPressed,
    Color textColor,
    Color disabledTextColor,
    Color color,
    Color borderColor,
    Color disabledColor,
    Color highlightColor,
    Color splashColor,
    bool disabled = false,
    String text,
    double elevation = 0.0,
    double highlightElevation = 0.0,
    double minWidth = 88.0,
    double minHeight = 36.0,
    EdgeInsetsGeometry padding,
  })  : _onPressed = onPressed,
        _text = text,
        _disabled = disabled,
        _textColor = textColor == null ? Color(0xFFFFFFFF) : textColor,
        _disabledTextColor =
            disabledTextColor == null ? Color(0xFFB0BEC5) : disabledTextColor,
        _color = color == null ? Color(0xFF0097EB) : color,
        _borderColor = borderColor == null ? Color(0xFF0097EB) : borderColor,
        _disabledColor =
            disabledColor == null ? Color(0xFFCFD8DC) : disabledColor,
        _splashColor = splashColor == null ? Color(0xFF00669F) : splashColor,
        _elevation = elevation,
        _highlightElevation = highlightElevation,
        padding = padding,
        _minWidth = minWidth == null ? 88.0 : minWidth,
        _minHeight = minHeight == null ? 36.0 : minHeight,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ButtonTheme(
        minWidth: _minWidth,
        height: _minHeight,
        child: RaisedButton(
          color: _color == null ? Color(0xFF0097EB) : _color,
          splashColor: _splashColor == null ? Color(0xFF00669F) : _splashColor,
          disabledColor:
              _disabledColor == null ? Color(0xFFCFD8DC) : _disabledColor,
          textColor: _textColor == null ? Color(0xFFFFFFFF) : _textColor,
          onPressed: _disabled ? null : _onPressed,
          elevation: _elevation,
          padding: padding,
          child: Text(
            _text,
            style:
                TextStyle(color: _disabled ? _disabledTextColor : _textColor),
          ),
        ),
      ),
    );
  }
}
