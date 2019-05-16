import 'package:flutter/material.dart';
import 'package:flutter_app2/shop/constants/index.dart';
import 'package:flutter_app2/shop/page/home/firstTab.dart';
import 'package:flutter_app2/shop/page/home/tabbar.dart';
import 'package:flutter_app2/shop/page/home/topbar.dart';
import 'package:flutter_app2/shop/search/topbar.dart';

//首页
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return DefaultTabController(
        length: 9,
        initialIndex: 0,
        child: Column(
          children: <Widget>[
            AppBar(
              brightness: Brightness.light,
              backgroundColor: KColorConstant.searchAppBarBgColor,
              elevation: 0,
              titleSpacing: 0,//让自己的title控件填充整个屏幕
              automaticallyImplyLeading: false,//去左按钮
              centerTitle: false,
              title: HomeTopBar(),
            ),
        KTabBarWidget(),
            Expanded(
                child: TabBarView(
                  children: <Widget>[
                    FirstTabWidget(),
                    FirstTabWidget(),
                    FirstTabWidget(),
                    FirstTabWidget(),
                    FirstTabWidget(),
                    FirstTabWidget(),
                    FirstTabWidget(),
                    FirstTabWidget(),
                    FirstTabWidget(),


                    //=['首页','性感美女','制服','清新美女','校园','古装','动漫','壁纸','苍老师'];
                    /*BeautyGirlWidget(
                      key: PageStorageKey<String>('sexy'), keyword: '性感美女'),
                    BeautyGirlWidget(
                       key: PageStorageKey<String>('zhifu') , keyword: '制服美女'),
                    BeautyGirlWidget(
                       key: PageStorageKey<String>('fresh') , keyword: '清新美女'),
                    BeautyGirlWidget(keyword: '校园美女'),
                    BeautyGirlWidget(keyword: '古装美女'),
                    BeautyGirlWidget(keyword: '动漫美女'),
                    BeautyGirlWidget(keyword: '美女壁纸'),
                    BeautyGirlWidget(keyword: '苍老师'),*/
                  ],
                ))
          ],
        ));
  }
}