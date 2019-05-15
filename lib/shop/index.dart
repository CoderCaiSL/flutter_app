import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app2/shop/constants/index.dart';
import 'package:flutter_app2/shop/page/classify/classify.dart';
import 'package:flutter_app2/shop/page/home/Home.dart';
import 'package:flutter_app2/shop/utils/screen_util.dart';

class Index extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //状态栏透明设置
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return new MaterialApp(
        debugShowCheckedModeBanner: false, home: new IndexMain());
  }
}


// -------------------- 第一中方式的bottom --------start
class IndexMain extends StatefulWidget {
  @override
  IndexMainState createState() => new IndexMainState();
}

class IndexMainState extends State<IndexMain>  with AutomaticKeepAliveClientMixin{

  int _tabIndex = 0;
  var tabImages;
  var appBarTitles = [' 首页 ', ' 分类 ', ' 发现 ',"购物车"," 我的 "];
  /*
   * 存放页面，跟fragmentList一样
   */
  var _pageList;
  /*
   * 根据选择获得对应的normal或是press的icon
   */
  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  /*
   * 获取bottomTab的颜色和文字
   */
  Text getTabTitle(int curIndex) {
    if (curIndex == _tabIndex) {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(fontSize: 14.0, color: const Color(0xff1296db)));
    } else {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(fontSize: 14.0, color: const Color(0xff515151)));
    }
  }

  /*
   * 根据image路径获取图片
   */
  Image getTabImage(path) {
    return new Image.asset("images/area.png", width: 24.0, height: 24.0);
  }

  void initData() {
    /*
     * 初始化选中和未选中的icon
     */
    tabImages = [
      [getTabImage(Icons.home), getTabImage(Icons.home)],
      [getTabImage(Icons.category), getTabImage(Icons.category)],
      [getTabImage(Icons.cake), getTabImage(Icons.cake)],
      [getTabImage(Icons.shopping_cart), getTabImage(Icons.shopping_cart)],
      [getTabImage(Icons.person), getTabImage(Icons.person)],
    ];
    /*
     * 三个子界面
     */
    _pageList = [
      new Home(),
      new Classify(),
      new Home(),
      new Home(),
      new Home(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: Klength.designWidth)..init(context);
    double extralHeight = Klength.topBarHeight + //顶部标题栏高度
        Klength.bottomBarHeight + //底部tab栏高度
        ScreenUtil.statusBarHeight + //状态栏高度
        ScreenUtil.bottomBarHeight; //IPhoneX底部状态栏
    //初始化数据
    initData();
    return Scaffold(
        bottomNavigationBar: new BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
                icon: getTabIcon(0), title: getTabTitle(0)),
            new BottomNavigationBarItem(
                icon: getTabIcon(1), title: getTabTitle(1)),
            new BottomNavigationBarItem(
                icon: getTabIcon(2), title: getTabTitle(2)),
            new BottomNavigationBarItem(
                icon: getTabIcon(3), title: getTabTitle(3)),
            new BottomNavigationBarItem(
                icon: getTabIcon(4), title: getTabTitle(4)),
          ],
          type: BottomNavigationBarType.fixed,
          //默认选中首页
          currentIndex: _tabIndex,
          iconSize: 24.0,
          //点击事件
          onTap: (index) {
            setState(() {
              _tabIndex = index;
            });
          },
        ),

      //body: _pageList[_tabIndex],//这个代码无法实现保活操作
      //保活操作处理
      body: IndexedStack(
        index: _tabIndex,
        children: _pageList,
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(IndexMain oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

// -------------------- 第一中方式的bottom --------end


class IndexMain2 extends StatefulWidget {
  @override
  IndexMain2State createState() => new IndexMain2State();
}

class IndexMain2State extends State<IndexMain2> with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin<IndexMain2> {

  //Tab页的控制器，可以用来定义Tab标签和内容页的坐标
  TabController tabcontroller;

  //生命周期方法构建Widget时调用
  @override
  Widget build(BuildContext context) {
    //屏幕适配的高度和宽度设置
    ScreenUtil.instance = ScreenUtil(width: Klength.designWidth)..init(context);

    return new Scaffold(
      body: new TabBarView(
        children: <Widget>[
          new Home(),
          new Classify(),
          new Home(),
          new Home(),
          new Home(),
      ],
        controller: tabcontroller,
      ),
      bottomNavigationBar: new Material(
        //底部栏整体的颜色
        color: Colors.white,
        child: new TabBar(
          controller: tabcontroller,
          tabs: <Tab>[
            new Tab(text: " 首页 ",icon: new Icon(Icons.home)),
            new Tab(text: " 分类 ",icon: new Icon(Icons.category)),
            new Tab(text: " 发现 ",icon: new Icon(Icons.cake)),
            new Tab(text: "购物车",icon: new Icon(Icons.shopping_cart)),
            new Tab(text: " 发现 ",icon: new Icon(Icons.cake)),
          ],
          //tab被选中时的颜色，设置之后选中的时候，icon和text都会变色
          labelColor: Colors.blue,
          //tab未被选中时的颜色，设置之后选中的时候，icon和text都会变色
          unselectedLabelColor: Colors.black,
          //指示器大小计算方式
          indicatorSize: TabBarIndicatorSize.tab,
        ),
      ),
    );
  }
  //生命周期方法插入渲染树时调用，只调用一次
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabcontroller = new TabController(
        length: 5,   //Tab页的个数
        vsync: this //动画效果的异步处理，默认格式
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //释放内存，节省开销
    tabcontroller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(IndexMain2 oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }


  @override
  // TODO: implement parent
  Animation get parent => null;
  //据说避免重绘，待测试
  @override
  bool get wantKeepAlive => true;

}



