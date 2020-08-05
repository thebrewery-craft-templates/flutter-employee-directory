import 'package:flutter/widgets.dart';

class TileIcon extends StatelessWidget {
  final Widget child;
  final double size;
  final Color color;

  TileIcon({
    Key key,
    @required this.child,
    this.size,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      child: _buildChild(child),
    );
  }

  Widget _buildChild(Widget child) {
    if (size != null) {
      if (child is Icon) {
        var iconSize = size;

        if (child.size != null && child.size <= size) {
          iconSize = child.size;
        }

        return Icon(
          child.icon,
          size: iconSize,
          color: color,
        );
      }
    }

    return child;
  }
}
