import 'package:flutter/material.dart';

class BrewerySearchBar extends StatefulWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final Color cursorColor;
  final double elevation;
  final IconThemeData actionsIconTheme;
  final IconThemeData iconTheme;
  final TextStyle hintStyle;
  final String hintText;
  final TextTheme textTheme;
  final VoidCallback onClear;
  final VoidCallback onEditingComplete;
  final ValueChanged<String> onTextChanged;
  final ValueChanged<String> onSubmitted;

  @override
  final Size preferredSize;

  BrewerySearchBar({
    Key key,
    this.backgroundColor,
    this.cursorColor,
    this.elevation = 4.0,
    this.hintText,
    this.hintStyle,
    this.onClear,
    this.onEditingComplete,
    this.onTextChanged,
    this.onSubmitted,
    this.iconTheme,
    this.actionsIconTheme,
    this.textTheme,
  })  : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _BrewerySearchBarState();
}

class _BrewerySearchBarState extends State<BrewerySearchBar> {
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final AppBarTheme appBarTheme = AppBarTheme.of(context);

    Color cursorColor = widget.cursorColor ?? themeData.cursorColor;
    TextStyle textFieldStyle = widget.textTheme?.title ??
        appBarTheme.textTheme?.title ??
        themeData.primaryTextTheme.title;
    TextStyle hintStyle =
        textFieldStyle.copyWith(color: textFieldStyle.color.withOpacity(0.6));

    return AppBar(
      backgroundColor: widget.backgroundColor,
      elevation: widget.elevation,
      iconTheme: widget.iconTheme,
      actionsIconTheme: widget.actionsIconTheme,
      textTheme: widget.textTheme,
      title: TextField(
        controller: _controller,
        cursorColor: cursorColor,
        onChanged: widget.onTextChanged,
        onEditingComplete: widget.onEditingComplete,
        onSubmitted: widget.onSubmitted,
        style: textFieldStyle,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: hintStyle,
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
      actions: <Widget>[
        if (widget.onClear != null)
          IconButton(
            icon: Icon(Icons.clear),
            iconSize: 20.0,
            onPressed: _onClear,
          ),
      ],
    );
  }

  _onClear() {
    _controller.clear();
    widget.onClear();
  }
}
