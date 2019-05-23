import 'package:flutter/material.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
class ShowJiGuan extends StatefulWidget {
  @override
  ShowJiGuanState createState() => new ShowJiGuanState();
}

class ShowJiGuanState extends State<ShowJiGuan> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('极光推送的demo'),
      ),
    );
  }

  void _startupJpush() async {
    JPush jpush = new JPush();

    jpush.addEventHandler(
      // 接收通知回调方法。
      onReceiveNotification: (Map<String, dynamic> message) async {
        print("flutter onReceiveNotification: $message");
      },
      // 点击通知回调方法。
      onOpenNotification: (Map<String, dynamic> message) async {
        print("flutter onOpenNotification: $message");
      },
      // 接收自定义消息回调方法。
      onReceiveMessage: (Map<String, dynamic> message) async {
        print("flutter onReceiveMessage: $message");
      },
    );

    jpush.setup(
      appKey: "1fffb2ea8b0f07a65d405538",
      channel: "theChannel",
      production: false,
      debug: false, // 设置是否打印 debug 日志
    );

  }
  @override
  void initState() {
    // TODO: implement initState
    _startupJpush();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(ShowJiGuan oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}