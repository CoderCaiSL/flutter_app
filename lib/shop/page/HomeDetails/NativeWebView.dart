

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';

class NativeWenView extends StatefulWidget {
  final data ;

  const NativeWenView({Key key, this.data}) : super(key: key);

  @override
  NativeWenViewState createState() => new NativeWenViewState(data);
}

class Foo {
  String bar;
  String baz;

  Foo({this.bar, this.baz});

  Map<String, dynamic> toJson() {
    return {
      'bar': this.bar,
      'baz': this.baz
    };
  }
}

class NativeWenViewState extends State<NativeWenView> {

  final data ;
  InAppWebViewController webView;
  String url = "";
  double progress = 0;

  NativeWenViewState(this.data);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    String date2 = data;
    date2 = date2.replaceAll('<p>', '');
    date2 = date2.replaceAll('</p>', '');
    date2 = date2.replaceAll('<img', '<img style="display:block; width: 100%; max-width:100%;height:auto" ');
    print(date2);
    InAppWebViewInitialData inAppWebViewInitialData =  InAppWebViewInitialData(date2);
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration:
              BoxDecoration(border: Border.all(color: Colors.transparent)),
              child: InAppWebView(
                initialData: inAppWebViewInitialData,
                //initialUrl: "https://flutter.dev/",
                //initialFile: "assets/index.html",
                initialHeaders: {},
                initialOptions: {
                  //"useShouldOverrideUrlLoading": true,
                  //"useOnLoadResource": true
                },
                onWebViewCreated: (InAppWebViewController controller) {
                  webView = controller;
                  webView.addJavaScriptHandler('handlerFoo', (args) {
                    // ignore: return_of_invalid_type_from_closure
                    /*return new Foo(bar: 'bar_value', baz: 'baz_value');*/
                  });
                  webView.addJavaScriptHandler('handlerFooWithArgs', (args) {
                    print(args);
                    // ignore: return_of_invalid_type_from_closure
                    /*return [args[0] + 5, !args[1], args[2][0], args[3]['foo']];*/
                  });
                },
                onLoadStart: (InAppWebViewController controller, String url) {
                  print("started $url");
                  setState(() {
                    this.url = url;
                  });
                },
                onLoadStop: (InAppWebViewController controller, String url) async {
                  print("stopped $url");
                },
                onProgressChanged:
                    (InAppWebViewController controller, int progress) {
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
                shouldOverrideUrlLoading: (InAppWebViewController controller, String url) {
                  print("override $url");
                  controller.loadUrl(url);
                },
                onLoadResource: (InAppWebViewController controller, WebResourceResponse response, WebResourceRequest request) {
                  print("Started at: " +
                      response.startTime.toString() +
                      "ms ---> duration: " +
                      response.duration.toString() +
                      "ms " +
                      response.url);
                },
                onConsoleMessage: (InAppWebViewController controller, ConsoleMessage consoleMessage) {
                  print("""
              console output:
                sourceURL: ${consoleMessage.sourceURL}
                lineNumber: ${consoleMessage.lineNumber}
                message: ${consoleMessage.message}
                messageLevel: ${consoleMessage.messageLevel}
              """);
                },
              ),
            ),
          ),
          /*ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Icon(Icons.arrow_back),
                onPressed: () {
                  if (webView != null) {
                    webView.goBack();
                  }
                },
              ),
              RaisedButton(
                child: Icon(Icons.arrow_forward),
                onPressed: () {
                  if (webView != null) {
                    webView.goForward();
                  }
                },
              ),
              RaisedButton(
                child: Icon(Icons.refresh),
                onPressed: () {
                  if (webView != null) {
                    webView.reload();
                  }
                },
              ),
            ],
          ),*/
        ]));
  }

}