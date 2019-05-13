import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission/permission.dart';

class PermisstionTest extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Permission.openSettings();
              },
            )
          ],
        ),
        body: Center(
          child: ListView(
              children: PermissionName.values
                  .where((PermissionName permission) {
                if (Platform.isIOS) {
                  return
                    permission != PermissionName.Phone &&
                        permission != PermissionName.SMS &&
                        permission != PermissionName.Storage &&
                        permission != PermissionName.Sensors;
                } else {
                  return
                    permission != PermissionName.Internet;
                }
              })
                  .map((PermissionName permission) =>
                  ItemCheck(permission))
                  .toList()
          ),
        ),
      ),
    );
  }
}

class ItemCheck extends StatefulWidget {

  const ItemCheck(this._permissionGroup);

  final PermissionName _permissionGroup;

  @override
  ItemCheckState createState() => ItemCheckState(_permissionGroup);

}

class ItemCheckState extends State<ItemCheck> {

  final PermissionName _permissionGroup;

  PermissionStatus _permissionStatus = PermissionStatus.whenInUse;
  ItemCheckState(this._permissionGroup);

  //数据修改
  Color getPermissionColor() {
    switch (_permissionStatus) {
      case PermissionStatus.deny:
        return Colors.red;
      case PermissionStatus.allow:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: Text(_permissionGroup.toString()),
      subtitle: Text(_permissionStatus.toString(),
      style: TextStyle(color: getPermissionColor()),
      ),
      trailing: IconButton(
          icon: const Icon(Icons.info),
          onPressed: () {

          }),
      onTap: (){
        requestPermission(_permissionGroup);
      },
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listenForPermissionStatus();
  }

  void _listenForPermissionStatus() {
    final Future<PermissionStatus> statusFuture =
    Permission.getSinglePermissionStatus(_permissionGroup);
    statusFuture.then((PermissionStatus status) {
      setState(() {
        _permissionStatus = status;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(ItemCheck oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  Future<void> requestPermission(PermissionName permission) async {
    final List<PermissionName> permissions = <PermissionName>[permission];
    List<Permissions> permissionsStats = await Permission.requestPermissions(permissions);
    setState(() {
      print(permissionsStats);
      _permissionStatus = permissionsStats[0].permissionStatus;
      print(_permissionStatus);
    });
  }
}




