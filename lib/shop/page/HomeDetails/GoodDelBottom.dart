import 'package:flutter/material.dart';
import 'package:flutter_app2/shop/constants/index.dart';
import 'package:flutter_app2/shop/model/order_bean_entity.dart';
import 'package:flutter_app2/shop/model/pay_bean_entity.dart';
import 'package:flutter_app2/shop/model/pay_bean_new_entity.dart';
import 'package:flutter_app2/shop/services/search.dart';
import 'package:flutter_app2/shop/utils/screen_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

class GoodDelBottom extends StatefulWidget {
  @override
  GoodDelBottomState createState() => new GoodDelBottomState();
}

class GoodDelBottomState extends State<GoodDelBottom> {
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
              getOderNumber();
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

  getOderNumber()async {
    Map<String, dynamic> responseData  = await  getOrder();
    OrderBeanEntity orderBeanEntity = OrderBeanEntity.fromJson(responseData);
    getPayWX(orderBeanEntity);
  }

  getPayWX(OrderBeanEntity orderBeanEntity)async {
    PayBeanNewEntity payBeanEntity = await  getPay(orderBeanEntity.result.orderNum.toString());
    fluwx
        .pay(
      appId: payBeanEntity.result.appid,
      partnerId: payBeanEntity.result.partnerid,
      prepayId:  payBeanEntity.result.prepayid,
      packageValue:  payBeanEntity.result.package,
      nonceStr:  payBeanEntity.result.noncestr,
      timeStamp:  int.parse(payBeanEntity.result.timestamp),
      sign:  payBeanEntity.result.sign,
    )
        .then((data) {
      print("---》$data");
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fluwx.responseFromPayment.listen((data) {
      print("---》${data.errCode}");
      if(data.errCode == 0){
        Fluttertoast.showToast(
          msg: " ${data.errCode} ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos:1,
        );
      }else{
        Fluttertoast.showToast(
          msg: " 支付取消 ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos:1,
        );
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(GoodDelBottom oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
