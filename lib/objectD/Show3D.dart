import 'package:flutter/material.dart';
import 'package:flutter_app2/objectD/Widght_3D.dart';

class Show3D extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('显示3D视图'),
      ),
      body: Widght_3D(
          size: const Size(400.0, 400.0),
          path: "assets/file.obj",
          asset:
          true),
    );
  }
}