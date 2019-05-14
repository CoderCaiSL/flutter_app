import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';


class CustomImagePicker  extends StatefulWidget{
@override
State<StatefulWidget> createState() {
// TODO: implement createState
return MySelectImage();
}
}

class   MySelectImage extends State{
  List imgList=new List<File>();
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
    imgList.add(image);
    });
  }

  Future getCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if(image != null){
        imgList.add(image);
      }
    });
  }

  dynamic  getBody() {
    if (showLoadingDialog()) {
      return getProgressDialog();
    } else {
      return getListView();
    }
  }

  bool showLoadingDialog() {
    if (imgList.length == 0) {
      return true;
    }

    return false;
  }

  Center getProgressDialog() {
    return new Center(child: new CircularProgressIndicator());
  }

  ListView getListView()=>new ListView.builder(
      itemCount: imgList.length,
      itemBuilder: (BuildContext context, int position) {
        return Image.file(imgList[position],height: 300);
      }
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body:getBody(),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          List<String> mStrings = new List();
          mStrings.add("相册");
          mStrings.add("相机");
          showMyDialogWithListView(context,mStrings);
    },
        tooltip: 'Pick Image',
        child: Icon(Icons.add_box),
      ),
    );
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
              height: 100,
              child: new ListView.builder(
                itemBuilder: (context, index) {
                  return new SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: new RaisedButton(
                      child: new Text(strs[index]),
                      onPressed: (){
                        if(index == 0){
                          getImage();
                        }else{
                          getCamera();
                        }
                      },
                    )
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

}