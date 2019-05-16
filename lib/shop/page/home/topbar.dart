import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app2/shop/constants/index.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app2/shop/search/search.dart';
class HomeTopBar extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    if(Platform.isAndroid){
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark)
      );
    }
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      alignment: Alignment.center,
      color: Colors.transparent,
      padding: EdgeInsets.only(
          top: statusBarHeight, left: 10, right: 10, bottom: 10),
      child: Row(
        children: <Widget>[
          FlutterLogo(),
          Expanded(
            flex: 1,
            child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (BuildContext context) {
                        return SearchPage();
                      })
                  );
                },
                child: Container(
                  height: 34.0,
                  padding: EdgeInsets.all(5.0),
                  color: Color.fromRGBO(238, 238, 238, 0.5),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Icon(
                          Icons.search,
                          color: Color(0xFF979797),
                          size: 22,
                        ),
                      ),
                      Text(
                        //KKLocalizations.of(context).search,
                        KString.homeSearchBarHint,
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Color(0xFF979797),
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          Container(
            margin: EdgeInsets.only(left: 6.0),
            child: Icon(
              Icons.add_alert,
              size: 25.0,
              color: Color.fromRGBO(132, 95, 63, 1.0),
            ),
          )
        ],
      ),
    );
  }
}
