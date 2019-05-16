
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
  Map<String, dynamic> param = {
    'goodsId': cId,
    'userId': -1,
  };
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