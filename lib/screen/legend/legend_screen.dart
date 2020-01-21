import 'package:flutter/material.dart';
import 'package:meteo/common/meteo_localizations.dart';
import 'package:photo_view/photo_view.dart';

class LegendScreen extends StatelessWidget {
  static const _url = "http://www.meteo.pl/um/metco/leg_um_pl_cbase_256.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(MeteoLocalizations.of(context).legend)),
      body: Align(
        child: PhotoView(
          imageProvider: NetworkImage(_url),
          enableRotation: false,
          backgroundDecoration: const BoxDecoration(color: Colors.white),
          minScale: PhotoViewComputedScale.contained * 1.0,
        ),
      ),
    );
  }
}
