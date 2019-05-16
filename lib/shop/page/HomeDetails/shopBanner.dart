import 'package:flutter/material.dart';
import 'package:flutter_app2/shop/utils/screen_util.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class RectSwiperPaginationBuilder extends SwiperPlugin {
  ///color when current index,if set null , will be Theme.of(context).primaryColor
  final Color activeColor;

  ///,if set null , will be Theme.of(context).scaffoldBackgroundColor
  final Color color;

  ///Size of the rect when activate
  final Size activeSize;

  ///Size of the rect
  final Size size;

  /// Space between rects
  final double space;

  final Key key;

  const RectSwiperPaginationBuilder(
      {this.activeColor,
        this.color,
        this.key,
        this.size: const Size(10.0, 2.0),
        this.activeSize: const Size(10.0, 2.0),
        this.space: 3.0});

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    List<Widget> list = [];

    int itemCount = config.itemCount;
    int activeIndex = config.activeIndex;

    for (int i = 0; i < itemCount; ++i) {
      bool active = i == activeIndex;
      Size size = active ? this.activeSize : this.size;
      list.add(Container(
        width: size.width,
        height: size.height,
        color: active ? activeColor : color,
        key: Key("pagination_$i"),
        margin: EdgeInsets.all(space),
      ));
    }

    return new Row(
      key: key,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: list,
    );
  }
}

class GoodBanner extends StatelessWidget {

  final List<String> banners;
  GoodBanner({this.banners});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = ScreenUtil().L(375);
    return Container(
      width: width,
      height: height,
      child: banners.length > 0 ?
      Swiper(
        itemBuilder: (BuildContext context, index) {
          return Image.network(
            banners[index],
            width: width,
            height: height,
          );
        },
        itemCount: banners.length,
        //viewportFraction: 0.9,
        pagination: new SwiperPagination(
            alignment: Alignment.bottomRight,
            builder: RectSwiperPaginationBuilder(
                color: Color(0xFF999999),
                activeColor: Colors.white,
                size: Size(5.0, 2),
                activeSize: Size(5, 5))),
        scrollDirection: Axis.horizontal,
        autoplay: false,
        onTap: (index) => print('点击了第$index个'),
      )
          :
          //缓存界面
          null
      ,
    );
  }
}
