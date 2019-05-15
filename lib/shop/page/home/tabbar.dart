import 'package:flutter/material.dart';
import 'package:flutter_app2/shop/constants/color.dart';
import 'package:flutter_app2/shop/constants/index.dart';

//首页的tab
class KTabBarWidget extends StatelessWidget implements PreferredSizeWidget {
  get preferredSize {
    return Size.fromHeight(30);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: TabBar(
          indicatorColor: KColorConstant.themeColor,
          indicatorSize: TabBarIndicatorSize.label,
          isScrollable: true,
          labelColor: KColorConstant.themeColor,
          tabs: KString.tabs
              .map((i) => Container(
                    height: 30.0,
                    child: new Tab(text: i),
                  ))
              .toList()),
    );
  }
}
