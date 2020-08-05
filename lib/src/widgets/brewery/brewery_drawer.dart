import 'package:flutter/material.dart';

class BreweryDrawer extends StatelessWidget {
  final double elevation;

  final Widget drawerHeader;
  final List<Widget> drawerItems;
  final Widget drawerFooter;

  final String semanticLabel;

  final Color dividerColor;

  /// Determines if the footer widget is trailing with the list items
  /// or sticky at the bottom of the drawer.
  ///
  final bool stickyFooter;

  const BreweryDrawer({
    Key key,
    this.elevation = 16.0,
    this.drawerHeader,
    this.drawerItems,
    this.drawerFooter,
    this.semanticLabel,
    this.stickyFooter = true,
    this.dividerColor = Colors.grey,
  })  : assert(elevation != null && elevation >= 0.0),
        super(key: key);

  List<Widget> createDrawerListItems() {
    var drawerWidgets = List<Widget>();
    drawerWidgets.add(drawerHeader);
    drawerWidgets.addAll(drawerItems);
    return drawerWidgets;
  }

  bool shouldShowFooter() {
    return drawerFooter != null;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: _createDrawerItems(),
        ),
      ),
    );
  }

  List<Widget> _createDrawerItems() {
    var tempDrawerItems = <Widget>[];

    if (shouldShowFooter()) {
      if (stickyFooter) {
        tempDrawerItems.add(Expanded(
          child: ListView(
            children: createDrawerListItems(),
          ),
        ));
        tempDrawerItems.add(new Column(
          children: <Widget>[
            Divider(
              height: 1,
              color: dividerColor,
            ),
            new Align(
              alignment: Alignment.bottomCenter,
              child: drawerFooter,
            ),
          ],
        ));
      } else {
        var drawerListItems = <Widget>[];

        drawerListItems.add(drawerHeader);
        drawerListItems.addAll(drawerItems);
        drawerListItems.add(Divider(
          height: 1,
        ));
        drawerListItems.add(drawerFooter);

        tempDrawerItems.add(Expanded(
            child: ListView(
          children: drawerListItems,
        )));
      }
    } else {
      tempDrawerItems.add(Expanded(
        child: ListView(
          children: createDrawerListItems(),
        ),
      ));
    }

    return tempDrawerItems;
  }
}
