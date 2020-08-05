import 'package:flutter/material.dart';

class SearchResultTile extends StatelessWidget {
  final String text;
  final Color textColor;
  final Function onTap;


  SearchResultTile({
    @required this.text,
    this.textColor = Colors.black,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(null),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 20.0,
          color: textColor,
        ),
      ),
      onTap: onTap,
    );
  }
}
