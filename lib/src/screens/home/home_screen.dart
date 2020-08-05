import 'dart:ui';

import '../../resources/storage/user_storage.dart';

import 'package:flutter/material.dart';

import 'home_provider.dart';
import '../directory/directory_screen.dart';
import '../../models/employee.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/login/login_screen.dart';
import '../../utils/routes.dart';
import '../../widgets/brewery/brewery_blurimage.dart';
import '../../widgets/brewery/brewery_card.dart';
import '../../widgets/brewery/brewery_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    implements HomeProviderListener {
  int _selectedIndex;
  final _events = <Map<String, String>>[
    {
      "title": "Stratpoint  Q3 General Assembly",
      "description":
          "Please be advised that we are having our 3nd 2019 General Assembly on September 11 (Wed), 4pm, at the 7F Pantry. Kindly confirm your availability by accepting my calendar invite.",
      "cover_url": "https://i.imgur.com/UP4UWeh.jpg",
    },
    {
      "title": "Stratpoint Basketball Tournament",
      "description":
          "Tournament is still in round-robin format. Each team will have five total matches.",
      "cover_url": "https://i.imgur.com/AVTOJkk.jpg",
    },
  ];

  HomeProvider _provider;
  String _email;
  String _imageUrl;
  Employee _employee;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _provider = HomeProvider(this);
    _provider.getMyInfo(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          _setTitle(),
          style: TextStyle(color: Colors.yellow, fontSize: 20.0),
        ),
        actions: <Widget>[
          Visibility(
              visible: _setSearchVisibility(),
              child: Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: GestureDetector(
                  child: Icon(
                    Icons.search,
                    color: Colors.yellow,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, Routes.search);
                  },
                ),
              ))
        ],
      ),
      body: _buildBody(),
      drawer: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: BreweryDrawer(
          drawerHeader: _buildHeader(),
          drawerItems: _buildDrawerItems(),
          drawerFooter: ListTile(
            leading: Icon(
              Icons.power_settings_new,
              color: Colors.white,
            ),
            title: Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
              ),
            ),
            onTap: () {
              if (_scaffoldKey.currentState.isDrawerOpen) {
                Navigator.of(context).pop();
              }
              _provider.logoutUser(context);
              var sessionToken = UserStorage.getToken();
              if (sessionToken != null) {
                return HomeScreen();
              }
              return LoginScreen();
              //LoginScreen();

              // ignore: todo
              // TODO: Logout
            },
          ),
        ),
      ),
    );
  }

  String _setTitle() {
    switch (_selectedIndex) {
      case 1:
        return 'Directory';
      default:
        return 'Home';
    }
  }

  bool _setSearchVisibility() {
    switch (_selectedIndex) {
      case 1:
        return true;
      default:
        return false;
    }
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 1:
        return DirectoryScreen();
      default:
        return ListView.builder(
          itemCount: _events.length,
          itemBuilder: (context, index) {
            final event = _events[index];

            return BreweryCard(
              titleText: event["title"],
              description: Text(
                event["description"],
                style: TextStyle(color: Colors.white),
              ),
              overlayColor: Colors.black.withOpacity(0.3),
              color: Colors.black,
              cover: Image.network(
                event["cover_url"],
                height: 175.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            );
          },
        );
    }
  }

  Widget _buildHeader() {
    return Container(
        color: Colors.grey,
        height: 180.0,
        child: Stack(
          children: <Widget>[
            BreweryBlurImage(
              url: 'https://i.imgur.com/DAWX0jU.jpg',
            ),
            Positioned(
              left: 16.0,
              top: 50.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.profile,
                      arguments: ProfileArguments(
                          employee: _employee, enableEdit: true));
                },
                child: Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                      image: NetworkImage(
                          _imageUrl ?? 'https://i.imgur.com/0oVzPLk.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 16.0,
              bottom: 20.0,
              child: Text(
                _email ?? '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ));
  }

  List<Widget> _buildDrawerItems() {
    List<Widget> items = [];

    final drawerItems = [
      DrawerItem(icon: Icons.home, title: 'Home'),
      DrawerItem(icon: Icons.people, title: 'Directory'),
      DrawerItem(icon: Icons.location_on, title: 'Location'),
      DrawerItem(icon: Icons.photo, title: 'Photo'),
    ];

    for (var i = 0; i < drawerItems.length; i++) {
      final item = drawerItems[i];

      final selected = _selectedIndex == i;
      final color = selected ? Colors.yellow : Colors.white;

      items.add(
        ListTile(
          leading: Icon(
            item.icon,
            color: color,
          ),
          title: Text(
            item.title,
            style: TextStyle(
              color: color,
              fontSize: 14.0,
            ),
          ),
          onTap: () {
            if (_scaffoldKey.currentState.isDrawerOpen) {
              Navigator.of(context).pop();
            }
            setState(() {
              _selectedIndex = i;
            });
          },
          selected: selected,
        ),
      );
    }

    return items;
  }

  @override
  void onLogoutFailed(String error) {
    showAlertDialog(context, error);
  }

  @override
  void onLogoutSuccess() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.login,
      (Route<dynamic> route) => false,
    );
  }

  @override
  void onLoading(bool loading) {}

  showAlertDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Logout Error'),
            content: Text(message),
            actions: <Widget>[
              SimpleDialogOption(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  void onGetMyInfoSuccess(Employee employee) {
    setState(() {
      _employee = employee;
      _email = employee.primaryEmail;
      _imageUrl = employee.imageUrl;
    });
  }
}

class DrawerItem {
  final IconData icon;
  final String title;

  DrawerItem({this.icon, @required this.title});
}
