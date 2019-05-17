import 'package:flutter/material.dart';
import 'package:flutter_app2/shop/constants/index.dart';
import 'package:flutter_app2/shop/utils/screen_util.dart';

class GoodDelBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
          flex: 1,
          child: InkWell(
            onTap: (){

            },
            child: Container(
                alignment: Alignment.center,
                color: KColorConstant.red3,
                height: ScreenUtil().L(49),
                child: Text(
                  '加入购物车',
                  style: TextStyle(color: KColorConstant.goPayBtTxtColor),
                )),
          )),
      Expanded(
          flex: 1,
          child: InkWell(
            onTap: (){

            },
            child: Container(
                alignment: Alignment.center,
                color: KColorConstant.red2,
                height: ScreenUtil().L(49),
                child: Text(
                  '立即购买',
                  style: TextStyle(color: KColorConstant.goPayBtTxtColor),
                )),
          )),
      Expanded(
        flex: 1,
          child: InkWell(
        onTap: (){

        },
        child: Container(
            alignment: Alignment.center,
            color: KColorConstant.red1,
            height: ScreenUtil().L(49),
            child: Text(
              '我要送礼',
              style: TextStyle(color: KColorConstant.goPayBtTxtColor),
            )),
      ))

    ],);
  }
}