import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app2/shop/model/crowdfund.dart';
import 'package:flutter_app2/shop/model/kingkong.dart';
import 'package:flutter_app2/shop/model/product.dart';
import 'package:flutter_app2/shop/page/home/banner.dart';
import 'package:flutter_app2/shop/page/home/crowdfunding.dart';
import 'package:flutter_app2/shop/page/home/menue.dart';
import 'package:flutter_app2/shop/page/home/recommed.dart';
import '../../data/home.dart';

class FirstTabWidget extends StatefulWidget {

  FirstTabWidget({Key key}) : super(key: key);

  @override
  FirstTabWidgetState createState() => new FirstTabWidgetState();
}

class FirstTabWidgetState extends State<FirstTabWidget> with SingleTickerProviderStateMixin {


  /*GlobalKey会在组件Mount阶段把自身放到一个Map里面缓存起来。
  思考一个场景，A页面是一个商品列表有许多商品图片（大概就单列这样），B页面是一个商品详情页（有商品大图），
  当用户在A页面点击一个其中详情，可能会出现一个过渡动画，A页面的商品图片慢慢放大然后下面的介绍文字也会跟着出现，
  然后就这样平滑的过渡到B页面。
  此时A页面和B页面都其实共用了一个商品图片的组件，B页面没必要重复创建这个组件可以直接把A页面的组件“借”过来。
  使用GlobalKey的组件生命周期是如何的尼，这里暂时挖一个坑先，哈哈。
  总之框架要求同一个父节点下子节点的Key都是唯一的就可以了，GlobalKey可以保证全局是唯一的，所以GlobalKey的组件能够依附在不同的节点上。
  而从GlobalKey对象上，你可以得到几个有用的属性currentElement，currentWidget，currentState。*/
  final GlobalKey<State> crowdFundingFloorKey = new GlobalKey();
  bool isIntoView = false;
  AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _onScroll,
      child: ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          SwipperBanner(banners: banners),
          HomeKingKongWidget(
            data: KingKongList.fromJson(menueDataJson['items']),
            fontColor: (menueDataJson['config'] as dynamic)['color'],
            bgurl: (menueDataJson['config'] as dynamic)['pic_url'],
          ),
          RecommendFloor(ProductListModel.fromJson(recommendJson)),
          CrowdFundingFloor(
              key: crowdFundingFloorKey,
              controller: controller,
              data: CrowdFundingListModel.fromJson(crowdFundingData)),
          RecommendFloor(ProductListModel.fromJson(recommendJson)),
          RecommendFloor(ProductListModel.fromJson(recommendJson)),
          RecommendFloor(ProductListModel.fromJson(recommendJson)),
        ],
      ),
    );
    /*new ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
    SwipperBanner(banners: banners),
    ],);*/
  }
  @override
  void initState() {
    //动画初始化
    controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: Duration(milliseconds: 2000),
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(FirstTabWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  bool _onScroll(ScrollNotification scroll) {
    if (scroll.depth == 0) {
      var currentContext = crowdFundingFloorKey.currentContext;
      if (currentContext == null) return false;
      RenderBox box = currentContext.findRenderObject();
      RenderBox listBox = scroll.context.findRenderObject();
      RenderAbstractViewport viewport = RenderAbstractViewport.of(box);
      //var offsetToRevealBottom = viewport.getOffsetToReveal(box, 1.0);
      var offset = viewport.getOffsetToReveal(box, 0.5); //到顶部的距离 固定值
      Size size = box.size;
      double scrollY = scroll.metrics.pixels;
      // double insideHeight = scroll.metrics.extentInside; //滚动的内容高度，如果滑动超过底部会
      double insideHeight = listBox.size.height; //listView的高度
      if ((scrollY + insideHeight > offset.offset + size.height) &&
          (offset.offset + size.height > scrollY)) {
        if (!isIntoView) {
          isIntoView = true;
          controller.forward(from: 0);
        }
      } else {
        if (isIntoView) {
          isIntoView = false;
          //  print('消失了');
        }
      }
    }
    return false;
  }

}