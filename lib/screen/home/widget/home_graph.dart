import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class HomeGraph extends StatelessWidget {
  final String weatherUrl;

  const HomeGraph({Key key, this.weatherUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: PhotoView(
        imageProvider: NetworkImage(weatherUrl),
        enableRotation: false,
        backgroundDecoration: BoxDecoration(color: Colors.white),
        minScale: PhotoViewComputedScale.contained * 1.0,
      ),
    );
  }
}
