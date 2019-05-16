import 'package:flutter/material.dart';
import 'package:flutter_app2/shop/model/kingkong.dart';
import 'package:flutter_app2/shop/page/HomeDetails/GoodDel.dart';
import 'package:flutter_app2/shop/utils/screen_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';

class HomeKingKongWidget extends StatelessWidget {
  final KingKongList data;
  final String bgurl;
  final String fontColor;
  HomeKingKongWidget({this.data, this.bgurl, this.fontColor});
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    double height = ScreenUtil().L(80);
    return Container(
      width: deviceWidth,
      height: height,
      child: _buildRow(context,deviceWidth),
      decoration: bgurl != ''
          ? BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(bgurl), fit: BoxFit.cover))
          : null,
    );
  }

  Row _buildRow(BuildContext context,double deviceWidth) {
    var colorInt = int.parse(fontColor.replaceAll('#', '0x'));
    Color color = new Color(colorInt).withOpacity(1.0);
    double iconWidth = ScreenUtil().L(58);
    double iconHeight = ScreenUtil().L(47);
    List<Widget> widgets = data.items.map((i) {
      return Expanded(
          child: GestureDetector(
               onTap: (){
                 // ignore: argument_type_not_assignable
                 String str = i.title;
                 Fluttertoast.showToast(
                   msg: " 点击$str ",
                   toastLength: Toast.LENGTH_SHORT,
                   gravity: ToastGravity.BOTTOM,
                   timeInSecForIos:1,
                 );
                 Navigator.push(context, new MaterialPageRoute(builder:  (context) => new GoodDetails()));
               },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.network(
                    i.picUrl,
                    width: iconWidth,
                    height: iconHeight,
                  ),
                  Text(
                    i.title,
                    style: TextStyle(
                        fontSize: 13.0,
                        height: 1.5,
                        decoration: TextDecoration.none,
                        color: color),
                  )
                ],
              )
          ),
      );
    }).toList();
    return Row(
      children: widgets,
    );
  }
}
