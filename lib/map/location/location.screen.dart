import 'package:amap_base/amap_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/map/utils/misc.dart';
import 'package:flutter_app2/map/widgets/button.widget.dart';
import 'package:flutter_app2/map/widgets/dimens.dart';

class LocationDemo extends StatefulWidget {
  @override
  _LocationDemoState createState() => _LocationDemoState();
}

class _LocationDemoState extends State<LocationDemo>
    with AutomaticKeepAliveClientMixin {
  final _amapLocation = AMapLocation();

  List<Location> _result = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _amapLocation.init();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: ListView(
              children:
                  _result.map((location) => _ResultItem(location)).toList(),
            ),
          ),
          SPACE_NORMAL,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Button(
                label: '单次定位',
                onPressed: (context) async {
                  final options = LocationClientOptions(
                    isOnceLocation: true,
                    locatingWithReGeocode: true,
                  );
                  _amapLocation
                      .getLocation(options)
                      .then(_result.add)
                      .then((_) => setState(() {}));
                  /*if (await Permissions().requestPermission()) {

                  } else {
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text('权限不足')));
                  }*/
                },
              ),
              Button(
                label: '连续定位',
                onPressed: (context) async {
                  final options = LocationClientOptions(
                    isOnceLocation: false,
                    locatingWithReGeocode: true,
                  );

                  if (await Permissions().requestPermission()) {
                    _amapLocation
                        .startLocate(options)
                        .map(_result.add)
                        .listen((_) => setState(() {}));
                  } else {
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text('权限不足')));
                  }
                },
              ),
              Button(
                label: '停止定位',
                onPressed: (context) {
                  _amapLocation.stopLocate();
                },
              ),
            ],
          ),
          SPACE_NORMAL,
        ],
      ),
    );
  }

  @override
  void dispose() {
    _amapLocation.stopLocate();
    super.dispose();
  }
}

class _ResultItem extends StatelessWidget {
  final Location _data;

  const _ResultItem(this._data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kSpaceBig),

      child: Container(
        color: Colors.grey,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            DateTime.now().toIso8601String(),
            style: TextStyle(color: Colors.grey),
          ),
          SPACE_SMALL,
          Text(
            jsonFormat(_data.toJson()),
            style: TextStyle(color: Colors.white,fontSize: 14),
          ),
        ],
      ),),
    );
  }
}
