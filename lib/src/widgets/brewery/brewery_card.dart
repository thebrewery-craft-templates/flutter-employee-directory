import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class BreweryCard extends StatelessWidget {
  final Color color;
  final Widget cover;
  final Text description;
  final String descriptionText;
  final double elevation;
  final Widget footer;
  final Text title;
  final String titleText;
  final Color overlayColor;

  BreweryCard({
    Key key,
    @required this.cover,
    this.color,
    this.description,
    this.descriptionText,
    this.footer,
    this.elevation = 1.0,
    this.title,
    this.titleText,
    this.overlayColor,
  })  : assert(cover != null),
        assert(elevation != null && elevation >= 0.0),
        super(key: key);

  bool get _hasDescription => description != null || descriptionText != null;
  bool get _hasTitle => title != null || titleText != null;
  bool get _hasFooter => footer != null;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          color: color,
          elevation: elevation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildCover(),
              if (_hasDescription) _buildDescription(),
              if (_hasFooter) Divider(),
              if (_hasFooter) footer,
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCover() {
    return Stack(
      children: <Widget>[
        if (cover != null) Center(child: cover),
        if (overlayColor != null) _buildOverlay(overlayColor),
        if (_hasTitle) _buildTitle(),
      ],
    );
  }

  Widget _buildTitle() {
    return Positioned(
      bottom: 16.0,
      left: 16.0,
      right: 16.0,
      child: title ??
          Text(
            titleText,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
            ),
          ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: description ??
          Text(
            descriptionText,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
    );
  }

  Widget _buildOverlay(Color color) {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: Container(color: color),
    );
  }
}
