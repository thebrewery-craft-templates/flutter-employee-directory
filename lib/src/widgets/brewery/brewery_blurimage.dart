import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

class BreweryBlurImage extends StatelessWidget {
  final String url;
  final String path;
  final File file;
  final Image image;
  final BoxFit fit;
  final double height;
  final double width;
  final double blurSigmaX;
  final double blurSigmaY;

  BreweryBlurImage({
    Key key,
    this.file,
    this.path,
    this.image,
    this.url,
    this.height = double.infinity,
    this.width = double.infinity,
    this.blurSigmaX = 5,
    this.blurSigmaY = 5,
    this.fit = BoxFit.cover,
  })  : assert(file != null || image != null || url != null || path != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Image _networkImage = url != null
        ? Image.network(url, width: width, height: height, fit: fit)
        : null;

    Image _assetImage = path != null
        ? Image.asset(path, width: width, height: height, fit: fit)
        : null;

    Image _fileImage = file != null
        ? Image.file(file, width: width, height: height, fit: fit)
        : null;

    Image _image = image ?? _networkImage ?? _assetImage ?? _fileImage;

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Center(child: _image),
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blurSigmaX, sigmaY: blurSigmaY),
            child: Container(color: Colors.black.withOpacity(.15)),
          ),
        ),
      ],
    );
  }
}
