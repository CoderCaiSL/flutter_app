
import 'package:flutter_app2/shop/model/order_bean_entity.dart';
import 'package:flutter_app2/shop/model/pay_bean_entity.dart';
import 'package:flutter_app2/shop/model/pay_bean_new_entity.dart';
import 'package:flutter_app2/shop/model/search_del_entity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future getHotSugs() async {
  var url = 'https://suggest.taobao.com/sug?area=sug_hot&wireless=2';
  var res = await http.get(url);
  if (res.statusCode == 200) {
    List querys = jsonDecode(res.body)['querys'] as List;
    return querys;
  }else{
    return [];
  }
}



Future getSuggest(String q) async {
  String url = 'https://suggest.taobao.com/sug?q=$q&code=utf-8&area=c2c';
  var res = await http.get(url);
  if(res.statusCode==200){
    List data = jsonDecode(res.body)['result'] as List;
    return data;
  }else{
    return [];
  }
}

getSearchResult(String keyworld,[int page=0]) async{
  String  url = 'https://so.m.jd.com/ware/search._m2wq_list?keyword=$keyworld&datatype=1&callback=C&page=$page&pagesize=10&ext_attr=no&brand_col=no&price_col=no&color_col=no&size_col=no&ext_attr_sort=no&merge_sku=yes&multi_suppliers=yes&area_ids=1,72,2818&qp_disable=no&fdesc=%E5%8C%97%E4%BA%AC';

  print("请求接口+$url");
   var res = await http.get(url);
   String body = res.body;
   String jsonString = body.substring(2,body.length-2);
  
  //  debugPrint(jsonString.replaceAll('\\x2F', '/')); 
      var json =  jsonDecode(jsonString.replaceAll( RegExp(r'\\x..') ,'/'));
      print(json['data']['searchm']['Paragraph']);
      return  json['data']['searchm']['Paragraph'] as List;
}

/**
 * 获取商品详情
 */
getSearchDe(String cId) async{
  cId = "239" ;
  String url = 'https://testapi.uxiangg.com/xt-webapi/goods/selectGoodsDetails';
  final http.Response response = await http.post(
      url,
      body: {
        'goodsId': cId,
        'userId': '-1'
      });
  final String res = response.body;
  final int statusCode = response.statusCode;
  if (statusCode < 200 || statusCode > 400 || json == null) {
    throw new Exception("Error while fetching data");
  }
  final Map<String, dynamic> responseData = json.decode(response.body);
  SearchDelEntity searchDelEntity =  SearchDelEntity.fromJson(responseData);
  String str = searchDelEntity.message;
  print(' $str数据$responseData');
  ///有值
  return SearchDelEntity.fromJson(responseData);
}

//获取订单号
getOrder() async{
  String url = 'https://testapi.uxiangg.com/xt-webapi/goods/immediatelyBuy';
  final http.Response response = await http.post(
      url,
      body: {
        'userId': '949',
        'goodsId': '272',
        'num': '2',
        'norms': '测试链接，拍下不发货',
        'state': '0',
        'consignee': '123',
        'phone': '13511111111',
        'couponId': '0',
        'remarks': '',
        'integralNum': '0',
        'esudaa': '0',
        'address': '北京市北京市东城区111111111111111'
      });
  final String res = response.body;
  final int statusCode = response.statusCode;
  if (statusCode < 200 || statusCode > 400 || json == null) {
    print(' 失败数据$statusCode');
    throw new Exception("Error while fetching data");
  }
  final Map<String, dynamic> responseData = json.decode(response.body);
  print('r数据$responseData');
  ///有值
  return responseData;
}

//获取支付信息
getPay(String out_trade_no) async{
  String url = 'https://testapi.uxiangg.com/xt-webapi/pay/weixinPayRequest';
  final http.Response response = await http.post(
      url,
      body: {
        'out_trade_no': out_trade_no,
        'trade_type': 'APP',
        'pay_way': 'tenpay'
      });
  final String res = response.body;
  final int statusCode = response.statusCode;
  if (statusCode < 200 || statusCode > 400 || json == null) {
    throw new Exception("Error while fetching data");
  }
  final Map<String, dynamic> responseData = json.decode(response.body);
  print(' 数据$responseData');
  ///有值
  return PayBeanNewEntity.fromJson(responseData);
}
