import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/util/DialogUtils.dart';
import 'package:fluttertoast/fluttertoast.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var pageRow = new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        new Icon(Icons.star, color: Colors.green[500]),
        new Icon(Icons.star, color: Colors.green[500]),
        new Icon(Icons.star, color: Colors.green[500]),
        new Icon(Icons.star, color: Colors.black),
        new Icon(Icons.star, color: Colors.black),
      ],
    );


    /**
     * 水平布局的图片例子
     */
    var iconRow = new Row(
        children: <Widget>[
          Container(
            color: Colors.orange,
            child: FlutterLogo(
              size: 60.0,
            ),
          ),
          Container(
            color: Colors.blue,
            child: FlutterLogo(
              size: 60.0,
            ),
          ),
          Container(
            color: Colors.purple,
            child: FlutterLogo(
              size: 60.0,
            ),
          )
        ],

    );

    var rowAndColum = new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.blue,
            height: 50.0,
            width: 50.0,
          ),
          Icon(Icons.adjust, size: 50.0, color: Colors.pink),
          Icon(Icons.adjust, size: 50.0, color: Colors.purple),
          Icon(Icons.adjust, size: 50.0, color: Colors.greenAccent),
          Container(
            color: Colors.orange,
            height: 50.0,
            width: 50.0,
          ),
          Icon(Icons.adjust, size: 50.0, color: Colors.cyan),
        ],
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('ces'),
      ),
      body: Column(
        // ignore: duplicate_named_argument
        children: <Widget>[
          new Center(
            child: Column(
              children: <Widget>[
                new RaisedButton(
                    child: new Text("测试弹框"
                    ),
                    onPressed: () {
                      //弹框
                      Fluttertoast.showToast(
                          msg: "This is Center Short Toast",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIos: 1,
                      );
                      DialogUtil.showMyDialog(context,
                          title: new Text("title"),
                          content: new Text("内容内容内容内容内容内容内容内容内容内容内容"),
                          onConfim: () {
                            Navigator.of(context).pop("确定");
                          }, onCancle: () {
                            Navigator.of(context).pop("取消");
                          });
                      /*列表显示*/
//                      List<String> mStrings = new List();
//                      for(int i =0 ;i < 20;i++){
//                        mStrings.add("测试");
//                      }
//                      showMyDialogWithListView(context,mStrings);
                      //showMyDialogWithStateBuilder(context);
                    }
                ),
                new RaisedButton(
                    child: new Text("注销"),
                    onPressed: () {
                      //回到上一个页面 该pop将Route从导航器管理的路由栈中移除当前路径
                      Navigator.pop(context);
                    }
                ),
              ],
            ),
          ),
          pageRow,
          iconRow,
          rowAndColum
        ],
      ),
    );
  }
  /*
  1.因为Dialog也是属于Navigator管理的，所以关闭对话框，直接用 Navigator.of(context).pop就行了
  2.ShowDialog()方法返回的是Future值,如果调用Navigator.of(context).pop()方法的时候，可以传递一些数值由Future返回。
    那么就可以用then()监听这个future所返回的数据了
   */
  void showMyDialogWithValue(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: new Text("title"),
            content: new Text("内容内容内容内容内容内容内容内容内容内容内容"),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop("点击了确定");
                },
                child: new Text("确认"),
              ),
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop("点击了取消");
                },
                child: new Text("取消"),
              ),
            ],
          );
        }).then((value) {
      debugPrint("对话框消失:$value");
    });
  }

  void showMyDialogWithColumn(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: new Text("title"),
            content: new SingleChildScrollView(
              child: new Column(
                children: <Widget>[
                  new SizedBox(
                    height: 100,
                    child: new Text("1"),
                  ),
                  new SizedBox(
                    height: 100,
                    child: new Text("1"),
                  ),
                  new SizedBox(
                    height: 100,
                    child: new Text("1"),
                  ),
                  new SizedBox(
                    height: 100,
                    child: new Text("1"),
                  ),
                  new SizedBox(
                    height: 100,
                    child: new Text("1"),
                  ),
                  new SizedBox(
                    height: 100,
                    child: new Text("1"),
                  ),
                  new SizedBox(
                    height: 100,
                    child: new Text("1"),
                  ),
                  new SizedBox(
                    height: 100,
                    child: new Text("1"),
                  ),
                  new SizedBox(
                    height: 100,
                    child: new Text("1"),
                  ),
                  new SizedBox(
                    height: 100,
                    child: new Text("1"),
                  ),
                  new SizedBox(
                    height: 100,
                    child: new Text("1"),
                  ),
                  new SizedBox(
                    height: 100,
                    child: new Text("1"),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {},
                child: new Text("确认"),
              ),
              new FlatButton(
                onPressed: () {},
                child: new Text("取消"),
              ),
            ],
          );
        });
  }

  void showMyDialogWithListView(BuildContext context,List<String> strs) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
            content: new Container(
              /*
              暂时的解决方法：要将ListView包装在具有特定宽度和高度的Container中
              如果Container没有定义这两个属性的话，会报错，无法显示ListView
               */
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.9,
              child: new ListView.builder(
                itemBuilder: (context, index) {
                  return new SizedBox(
                    height: 100,
                    child: new Text(strs[index]),
                  );
                },
                itemCount: strs.length,
                shrinkWrap: true,
              ),
            ));
      },
    );

//如果直接将ListView放在dialog中，会报错，比如
//下面这种写法会报错：I/flutter (10721): ══╡ EXCEPTION CAUGHT BY RENDERING LIBRARY ╞═════════════════════════════════════════════════════════
//    I/flutter (10721): The following assertion was thrown during performLayout():
//    I/flutter (10721): RenderShrinkWrappingViewport does not support returning intrinsic dimensions.
//    I/flutter (10721): Calculating the intrinsic dimensions would require instantiating every child of the viewport, which
//    I/flutter (10721): defeats the point of viewports being lazy.
//    I/flutter (10721): If you are merely trying to shrink-wrap the viewport in the main axis direction, you should be able
//    I/flutter (10721): to achieve that effect by just giving the viewport loose constraints, without needing to measure its
//    I/flutter (10721): intrinsic dimensions.
//    I/flutter (10721):
//    I/flutter (10721): When the exception was thrown, this was the stack:
//    I/flutter (10721): #0      RenderShrinkWrappingViewport.debugThrowIfNotCheckingIntrinsics.<anonymous closure> (package:flutter/src/rendering/viewport.dart:1544:9)
//    I/flutter (10721): #1      RenderShrinkWrappingViewport.debugThrowIfNotCheckingIntrinsics (package:flutter/src/rendering/viewport.dart:1554:6)
//    I/flutter (10721): #2      RenderViewportBase.computeMaxIntrinsicWidth (package:flutter/src/rendering/viewport.dart:321:12)
//    I/flutter (10721): #3      RenderBox._computeIntrinsicDimension.<anonymous closure> (package:flutter/src/rendering/box.dart:1109:23)
//    I/flutter (10721): #4      __InternalLinkedHashMap&_HashVMBase&MapMixin&_LinkedHashMapMixin.putIfAbsent (dart:collection/runtime/libcompact_hash.dart:277:23)
//    I/flutter (10721): #5      RenderBox._computeIntrinsicDimension (package:flutter/src/rendering/box.dart:1107:41)
//    I/flutter (10721): #6      RenderBox.getMaxIntrinsicWidth (package:flutter/src/rendering/box.dart:1291:12)
//    I/flutter (10721): #7      _RenderProxyBox&RenderBox&RenderObjectWithChildMixin&RenderProxyBoxMixin.computeMaxIntrinsicWidth (package:flutter/src/rendering/proxy_box.dart:81:20)

//        showDialog(context: context, builder: (context) {
//      return new AlertDialog(title: new Text("title"),
//        content: new SingleChildScrollView(
//          child: new Container(
//            height: 200,
//            child: new ListView.builder(
//              itemBuilder: (context, index) {
//                return new SizedBox(height: 100, child: new Text("1"),);
//              }, itemCount: 10, shrinkWrap: true,),
//          ),
//        ),
//        actions: <Widget>[
//          new FlatButton(onPressed: () {}, child: new Text("确认"),),
//          new FlatButton(onPressed: () {}, child: new Text("取消"),),
//        ],);
//    });
  }

  void showMyDialogWithStateBuilder(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          bool selected = false;
          return new AlertDialog(
            title: new Text("StatefulBuilder"),
            content:
            new StatefulBuilder(builder: (context, StateSetter setState) {
              var text = "";
              return Container(
                child: new CheckboxListTile(
                    title: new Text("选项"),
                    value: selected,
                    onChanged: (bool) {
                      setState(() {
                        selected = !selected;
                      });
                    }),
                
              );
            }),
            actions: <Widget>[
              new FlatButton(onPressed: () {
                Navigator.of(context).pop();
                Fluttertoast.showToast(
                  msg: "This is Center Short Toast",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIos: 1,
                );
              }, child: new Text("确定")),
              new FlatButton(onPressed: () {}, child: new Text("取消"))
            ],
          );
        }).then((value){

    });
  }

  void showMySimpleDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return new SimpleDialog(
            title: new Text("SimpleDialog"),
            children: <Widget>[
              new SimpleDialogOption(
                child: new Text("SimpleDialogOption One"),
                onPressed: () {
                  Navigator.of(context).pop("SimpleDialogOption One");
                },
              ),
              new SimpleDialogOption(
                child: new Text("SimpleDialogOption Two"),
                onPressed: () {
                  Navigator.of(context).pop("SimpleDialogOption Two");
                },
              ),
              new SimpleDialogOption(
                child: new Text("SimpleDialogOption Three"),
                onPressed: () {
                  Navigator.of(context).pop("SimpleDialogOption Three");
                },
              ),
            ],
          );
        });
  }

  void showMyCustomLoadingDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return new MyCustomLoadingDialog();
        });
  }
}

class MyCustomLoadingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Duration insetAnimationDuration = const Duration(milliseconds: 100);
    Curve insetAnimationCurve = Curves.decelerate;

    RoundedRectangleBorder _defaultDialogShape = RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)));

    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: SizedBox(
            width: 120,
            height: 120,
            child: Material(
              elevation: 24.0,
              color: Theme.of(context).dialogBackgroundColor,
              type: MaterialType.card,
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: new Text("加载中"),
                  ),
                ],
              ),
              shape: _defaultDialogShape,
            ),
          ),
        ),
      ),
    );
  }
}
