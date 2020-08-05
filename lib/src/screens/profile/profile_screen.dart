import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';

import 'widgets/profile_detail_tile.dart';
import '../../models/employee.dart';

class ProfileScreen extends StatefulWidget {
  final bool enableEdit;
  final Employee employee;
  ProfileScreen(employee, {enableEdit})
      : employee = employee,
        enableEdit = enableEdit ?? true;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Employee _employee;
  var _image;
  bool _enableEdit;

  @override
  void initState() {
    super.initState();
    _employee = widget.employee;
    _image = _employee.imageUrl;
    _enableEdit = widget.enableEdit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: false,
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return ListView(
      children: <Widget>[
        _buildHeader(),
        SizedBox(height: 40.0),
        _buildDetail(),
      ],
    );
  }

  Widget _buildHeader() {
    final image = _image != null && _image is File
        ? Image.file(
            _image,
            fit: BoxFit.cover,
          )
        : Image.network(
            _image,
            fit: BoxFit.cover,
          );

    return Stack(
      children: <Widget>[
        Positioned(
          child: SizedBox(
            child: image,
            height: 320.0,
            width: double.infinity,
          ),
        ),
        Positioned(
          left: 50.0,
          bottom: 30.0,
          child: Text(
            '${_employee.firstName} ${_employee.lastName}',
            style: TextStyle(color: Colors.white, fontSize: 36.0),
          ),
        ),
        Positioned(
          right: 10.0,
          top: 50.0,
          child: Visibility(
            visible: _enableEdit,
            child: Container(
              height: 50.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.4),
              ),
              child: FlatButton(
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () {
                  _showImageSourceOption(context);
                },
              ),
            ),
          ),
        ),
        Positioned(
          left: 0.0,
          right: 0.0,
          top: MediaQuery.of(context).padding.top,
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetail() {
    return Column(
      children: <Widget>[
        _buildPositionTile(),
        if (_employee.primaryNumber != null) _buildPhoneTile(),
        _buildEmailTile(),
      ],
    );
  }

  Widget _buildPositionTile() {
    return ProfileDetailTile(
      icon: TileIcon(
        child: Icon(Icons.account_circle),
        color: Colors.black54,
      ),
      title: _employee.position.title,
      subtitle: "Position",
      withDivider: true,
    );
  }

  Widget _buildPhoneTile() {
    return ProfileDetailTile(
      icon: TileIcon(
        child: Icon(Icons.account_circle),
        color: Colors.black54,
      ),
      title: _employee.primaryNumber,
      subtitle: "Phone",
      withDivider: true,
      onTap: () async {
        try {
          await _launchURL('tel:${_employee.primaryNumber}');
        } catch (_) {
          _showAlert('Oops!', 'Your device does not support call feature.');
        }
      },
    );
  }

  Widget _buildEmailTile() {
    return ProfileDetailTile(
      icon: TileIcon(
        child: Icon(Icons.account_circle),
        color: Colors.black54,
      ),
      title: _employee.primaryEmail,
      subtitle: "Email",
      onTap: () async {
        try {
          await _launchURL('mailto:${_employee.primaryEmail}');
        } catch (_) {
          _showAlert('Oops!', 'Your device does not support mailing feature.');
        }
      },
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _showAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  _showImageSourceOption(BuildContext context) {
    if (Platform.isIOS) {
      final actionSheet = CupertinoActionSheet(
        title: Text('Select source'),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text('Camera'),
            onPressed: () {
              Navigator.of(context).pop();
              _launchCamera();
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Gallery'),
            onPressed: () {
              Navigator.of(context).pop();
              _launchGallery();
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );

      showCupertinoModalPopup(
        context: context,
        builder: (context) => actionSheet,
      );
    } else {
      final style = TextStyle(fontSize: 18.0);

      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 180.0,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Camera', style: style),
                  onTap: () {
                    Navigator.of(context).pop();
                    _launchCamera();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo),
                  title: Text('Gallery', style: style),
                  onTap: () {
                    Navigator.of(context).pop();
                    _launchGallery();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.cancel),
                  title: Text('Cancel', style: style),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
      );
    }
  }

  _launchCamera() async {
    // ignore: deprecated_member_use
    final image = await ImagePicker.pickImage(source: ImageSource.camera);
    _setImage(image);
  }

  _launchGallery() async {
    // ignore: deprecated_member_use
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _setImage(image);
  }

  _setImage(File image) {
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }
}

class ProfileArguments {
  final Employee employee;
  final bool enableEdit;

  ProfileArguments({this.employee, this.enableEdit});
}
