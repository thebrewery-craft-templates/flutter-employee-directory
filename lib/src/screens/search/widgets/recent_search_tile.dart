import 'package:flutter/material.dart';

class RecentSearchTile extends StatelessWidget {
  final Color color;
  final String text;

  RecentSearchTile({
    @required this.text,
    this.color = const Color.fromRGBO(187, 187, 187, 1),
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.timer,
        size: 25.0,
        color: color,
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 20.0,
          color: color,
        ),
      ),
    );
  }
}
