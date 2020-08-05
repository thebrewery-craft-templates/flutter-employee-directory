import 'package:flutter/material.dart';

import 'tile_icon.dart';

export 'tile_icon.dart';

class ProfileDetailTile extends StatelessWidget {
  final TileIcon icon;
  final String title;
  final String subtitle;
  final double height;
  final bool withDivider;
  final Function() onTap;
  final Color color;

  ProfileDetailTile({
    @required this.title,
    this.subtitle,
    this.icon,
    this.height,
    this.onTap,
    this.color,
    this.withDivider = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _buildIcon(),
      title: Container(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTitle(),
            if (subtitle != null) _buildSubtitle(),
            SizedBox(
              height: 16.0,
            ),
            Divider(height: 1.0),
          ],
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildIcon() {
    final iconSize = _iconSize();

    if (iconSize != null) {
      return TileIcon(
        child: icon.child,
        size: iconSize,
        color: icon.color,
      );
    }

    return icon;
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15.0,
          color: Color.fromRGBO(79, 79, 79, 1),
        ),
      ),
    );
  }

  Widget _buildSubtitle() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        subtitle,
        style: TextStyle(
          fontSize: 15.0,
          color: Color.fromRGBO(79, 79, 79, 1),
        ),
      ),
    );
  }

  double _iconSize() {
    double iconSize = icon.size;

    if (height != null && iconSize != null) {
      if (iconSize > height) {
        iconSize = height;
      }
    }

    return iconSize;
  }
}
