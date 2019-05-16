import 'package:flutter/material.dart';
import 'package:flutter_app2/shop/constants/index.dart';
import 'package:flutter_app2/shop/data/home.dart';
import 'package:flutter_app2/shop/model/search_del_entity.dart';
import 'package:flutter_app2/shop/page/HomeDetails/shopBanner.dart';
import 'package:flutter_app2/shop/search/topbar.dart';
import 'package:flutter_app2/shop/services/search.dart';
import 'package:flutter_app2/shop/utils/screen_util.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GoodDetails extends StatefulWidget {
  @override
  GoodDetailsState createState() => new GoodDetailsState();
}

class GoodDetailsState extends State<GoodDetails> {

  List<String> bannerList = new List();
  SearchDelEntity searchDelEntity = null;

  @override
  Widget build(BuildContext context) {
    SearchDelResult searchDelResult = searchDelEntity.result;
    SearchDelResultGoods goods = searchDelEntity.result.goods;
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0,
        brightness: Brightness.light,
        leading: SearchTopBarLeadingWidget(),
        backgroundColor: KColorConstant.searchAppBarBgColor,
        centerTitle: true,
        title: new Text('商品详情',style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
          GoodBanner(banners: bannerList),
          Container(
            padding: EdgeInsets.only(
                top: ScreenUtil().L(8),
                bottom: ScreenUtil().L(4),
                right: ScreenUtil().L(10),
                left: ScreenUtil().L(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,//列表居中
              children: <Widget>[
                Row(children: <Widget>[
                  Text(" ￥ ",style: TextStyle(
                      fontSize: 14, color: Colors.redAccent)),
                  Text(
                    '${goods.price}',
                    style: TextStyle(
                        fontSize: 20, color: Colors.redAccent),
                  ),
                ],),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        if(searchDelResult.collect == 0){
                          searchDelResult.collect = 1;
                          setState(() {
                          });
                        }else{
                          searchDelResult.collect = 0;
                          setState(() {
                          });
                        }
                      },
                      child: Row(
                      children: <Widget>[
                        InkWell(
                            child: Icon(
                              searchDelResult.collect == 1
                                  ? Icons.star
                                  : Icons.star_border,
                              color: KColorConstant.themeColor,
                              size:16,
                            )),

                        SizedBox(
                            width: 46,
                            child:Text(
                              searchDelResult.collect == 1?"已收藏":"收藏",
                              textAlign: TextAlign.center, //文本对齐方式  居中
                              style: TextStyle(
                                fontSize: 12,),)),
                      ],
                    ),
                    ),
                    new GestureDetector(
                      onTap: (){
                        Fluttertoast.showToast(
                          msg: " 分享 ",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIos:1,
                        );
                      },
                      child: Row(children: <Widget>[
                      InkWell(
                          onTap: (){
                            Fluttertoast.showToast(
                              msg: " 分享 ",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIos:1,
                            );
                          },
                          child: Icon(
                            Icons.share,
                            color: KColorConstant.themeColor,
                            size:16,
                          )),
                      SizedBox(
                          width: 42,
                          child:Text(
                            "分享",
                            textAlign: TextAlign.center, //文本对齐方式  居中
                            style: TextStyle(
                              fontSize: 12,),))

                    ],),)
                  ],),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                top: ScreenUtil().L(8),
                bottom: ScreenUtil().L(4),
                right: ScreenUtil().L(10),
                left: ScreenUtil().L(10)),
            child: Text(goods.name,
              style: TextStyle(fontSize: 16, color: Colors.black),),),
          Container(
            width: ScreenUtil.screenWidth,
            padding: EdgeInsets.only(
                top: ScreenUtil().L(0),
                bottom: ScreenUtil().L(4),
                right: ScreenUtil().L(10),
                left: ScreenUtil().L(12)),
            child: Text(goods.subhead, style: TextStyle(fontSize: 12),),),
          Container(
            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment:  MainAxisAlignment.spaceBetween,
              children: <Widget>[
              Text("快递费：${goods.franking}", style: TextStyle(fontSize: 12),),
              Text("快递费：${goods.franking}", style: TextStyle(fontSize: 12),),
              Text("快递费：${goods.franking}", style: TextStyle(fontSize: 12),),
            ],),),
            Container(
              height: ScreenUtil().L(50),
              color: KColorConstant.goodsItem,
              padding: EdgeInsets.fromLTRB(15, 5, 10, 5),
              child: Row(children: <Widget>[
                Expanded(child: Row(children: <Widget>[
                  Text("优惠券",style: TextStyle(color: Colors.black,fontSize: 16)),
                  Container(padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: SizedBox(
                    height: ScreenUtil().L(20),
                    child: OutlineButton(
                      onPressed: () {},
                      padding: new EdgeInsets.all(3.0),
                      borderSide: new BorderSide(
                          width: 1.0, color: KColorConstant.red),
                      child: Text(
                        "满100减30",
                        style: TextStyle(fontSize: 10.0
                            ,color: KColorConstant.red),
                      ),
                    ),
                  ),),
                ],)),
                new Icon(
                  Icons.navigate_next,
                  size: 18,
                ),
              ],),
            ),
        ],),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    getSearchDel();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(GoodDetails oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }


  getSearchDel()async{
    searchDelEntity = await  getSearchDe("239");
    String  str = searchDelEntity.result.goods.name;
    bannerList.clear();
    bannerList.add(searchDelEntity.result.goods.minImage);
    Fluttertoast.showToast(
      msg: " 点击$str ",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos:1,
    );
    setState(() {
    });
  }
}