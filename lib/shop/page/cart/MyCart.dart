import 'package:flutter/material.dart';
import 'package:flutter_app2/shop/constants/string.dart';
import 'package:flutter_app2/shop/data/cart.dart';
import 'package:flutter_app2/shop/model/cart.dart';
import 'package:flutter_app2/shop/page/cart/cart_list.dart';
import 'package:flutter_app2/shop/page/cart/cartbottom.dart';
import 'package:flutter_app2/shop/topbar.dart';
import 'package:scoped_model/scoped_model.dart';

class MyCart extends StatefulWidget {
  @override
  MyCartState createState() => new MyCartState();
}

class MyCartState extends State<MyCart> {
  CartListModel cartListModel;

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CartListModel>(
      model: cartListModel,
        child: Column(
          children: <Widget>[
            TopBarWidget(KString.cartTitle),
            CartListWidget(),
            CartBottomWidget(),
          ],
        ));
  }
  @override
  void initState() {
    // TODO: implement initState
    cartListModel = CartListModel.fromJson(cartInitData);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(MyCart oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}

