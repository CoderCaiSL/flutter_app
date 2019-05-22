import 'dart:math';

import 'package:amap_base/amap_base.dart';
import 'package:flutter/material.dart';

const markerList = const [
  LatLng(30.308802, 120.071179),
  LatLng(30.2412, 120.00938),
  LatLng(30.296945, 120.35133),
  LatLng(30.328955, 120.365063),
  LatLng(30.181862, 120.369183),
];

class DrawPointScreen extends StatefulWidget {
  DrawPointScreen();

  factory DrawPointScreen.forDesignTime() => DrawPointScreen();

  @override
  DrawPointScreenState createState() => DrawPointScreenState();
}

class DrawPointScreenState extends State<DrawPointScreen> {
  AMapController _controller;
  MyLocationStyle _myLocationStyle = MyLocationStyle();

  @override
  Widget build(BuildContext context) {
    _updateMyLocationStyle(context,showMyLocation: true,radiusFillColor: Colors.red.withOpacity(0.6));
    return Scaffold(
      appBar: AppBar(
        title: const Text('绘制点标记'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) {
          return AMapView(
            onAMapViewCreated: (controller) {
              _controller = controller;
              _controller.markerClickedEvent.listen((marker) {
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text(marker.toString())));
              });
              controller.addMarkers(
                markerList
                    .map((latLng) => MarkerOptions(
                          icon: 'images/home_map_icon_positioning_nor.png',
                          position: latLng,
                          title: '哈哈',
                          snippet: '呵呵',
                        ))
                    .toList(),
              );
            },
            amapOptions: AMapOptions(),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          _updateMyLocationStyle(context,radiusFillColor: Colors.red.withOpacity(0.6));
          final nextLatLng = _nextLatLng();
          await _controller.addMarker(MarkerOptions(position: nextLatLng));
          await _controller.changeLatLng(nextLatLng);
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateMyLocationStyle(
      BuildContext context, {
        String myLocationIcon,
        double anchorU,
        double anchorV,
        Color radiusFillColor,
        Color strokeColor,
        double strokeWidth,
        int myLocationType,
        int interval,
        bool showMyLocation,
        bool showsAccuracyRing,
        bool showsHeadingIndicator,
        Color locationDotBgColor,
        Color locationDotFillColor,
        bool enablePulseAnnimation,
        String image,
      }) async {
    //await Permissions().requestPermission();
    _myLocationStyle = _myLocationStyle.copyWith(
      myLocationIcon: myLocationIcon,
      anchorU: anchorU,
      anchorV: anchorV,
      radiusFillColor: radiusFillColor,
      strokeColor: strokeColor,
      strokeWidth: strokeWidth,
      myLocationType: myLocationType,
      interval: interval,
      showMyLocation: showMyLocation,
      showsAccuracyRing: showsAccuracyRing,
      showsHeadingIndicator: showsHeadingIndicator,
      locationDotBgColor: locationDotBgColor,
      locationDotFillColor: locationDotFillColor,
      enablePulseAnnimation: enablePulseAnnimation,
      image: image,
    );
    _controller.setMyLocationStyle(_myLocationStyle);
    /*if (await Permissions().requestPermission()) {
      _myLocationStyle = _myLocationStyle.copyWith(
        myLocationIcon: myLocationIcon,
        anchorU: anchorU,
        anchorV: anchorV,
        radiusFillColor: radiusFillColor,
        strokeColor: strokeColor,
        strokeWidth: strokeWidth,
        myLocationType: myLocationType,
        interval: interval,
        showMyLocation: showMyLocation,
        showsAccuracyRing: showsAccuracyRing,
        showsHeadingIndicator: showsHeadingIndicator,
        locationDotBgColor: locationDotBgColor,
        locationDotFillColor: locationDotFillColor,
        enablePulseAnnimation: enablePulseAnnimation,
        image: image,
      );
      _controller.setMyLocationStyle(_myLocationStyle);
    } else {
      showError(context, '权限不足');
    }*/
  }


  LatLng _nextLatLng() {
    final _random = Random();
    double nextLat = (301818 + _random.nextInt(303289 - 301818)) / 10000;
    double nextLng = (1200093 + _random.nextInt(1203691 - 1200093)) / 10000;
    return LatLng(nextLat, nextLng);
  }
}
