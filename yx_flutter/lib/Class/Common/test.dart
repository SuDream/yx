// /*
//  * @Author: yz.lilinjun 
//  * @Date: 2020-06-16 18:42:49 
//  * @Last Modified by: yz.lilinjun
//  * @Last Modified time: 2020-07-11 17:49:02
//  */


// import 'package:flutter/material.dart';
// // import 'package:yingzi_flutter_fmc_plugin/yz_fmc_uikit.dart';

// const APPBAR_SCROLL_OFFSET = 100;
// const TABBAR_HEIGHT = 44.0;

// class YZSliverAppBarPage extends StatefulWidget {
//   final List<Widget> listWidgets;
//   final List<Widget> tabs;
//   final List<Widget> sliverBuilder;

//   YZSliverAppBarPage({this.listWidgets, this.tabs, this.sliverBuilder});

//   @override
//   State createState() => new _YZSliverAppBarPageState();
// }

// class _YZSliverAppBarPageState extends State<YZSliverAppBarPage>
//     with TickerProviderStateMixin {
//   TabController _tabC; //TabBar的控制器
//   ScrollController _ctl = new ScrollController(); //NestedScrollView的主控制器
//   List<YZSliverWidgetEntity> listWidgets = []; //存储封装好的子模块视图的数组
//   List<Offset> positions = List(); //记录每个子模块的位置信息
//   int index; //TabBar控制锚点的子模块索引
//   double appBarAlpha = 0; //TabBar透明度的控制参数
//   bool isScroll = true; //滚动开关，开启时，点击监听失效
//   bool isClick = false; //点击开关，开启时，滚动监听失效

//   @override
//   void initState() {
//     super.initState();
//     listWidgets = widget.listWidgets.map((view) {
//       //对外部传入的每个Widget进行封装，并定义GlobalKey
//       GlobalKey<YZSliverWidgetEntityState> _key = GlobalKey();
//       return YZSliverWidgetEntity(key: _key, childView: view);
//     }).toList();
//     _tabC = new TabController(length: widget.tabs.length, vsync: this);
//     _tabC.addListener(() => _onTabChanged());
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       //监听Widget是否绘制完毕
//       _getPositions();
//     });

//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('内嵌页面build');
//     return Scaffold(
//       body: NestedScrollView(
//           controller: _ctl,
//           headerSliverBuilder: _sliverBuilder,
//           body: NotificationListener<ScrollNotification>(
//               onNotification: (ScrollNotification notification) {
//                 if (notification is ScrollUpdateNotification) {
//                   //ScrollUpdateNotification判断是为了确保是由滚动触发的offset的改变
//                   ScrollMetrics metrics = notification.metrics;
//                   print(metrics.pixels); // 当前位置
//                   _onScroll(notification.metrics.pixels);
//                 }
//                 return false;
//               },
//               child: Stack(
//                 children: <Widget>[
//                   YZBodyView(listWidgets, index, isScroll, positions),
//                   _tabBar()
//                 ],
//               ))),
//     );
//   }

//   List<Widget> _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
//     return widget.sliverBuilder ?? [];
//   }

//   Widget _tabBar() {
//     return Opacity(
//       opacity: appBarAlpha, //透明度随滚动渐变
//       child: Container(
//         color: Colors.white,
//         height: TABBAR_HEIGHT,
//         child: TabBar(
//             onTap: (i) {
//               //由于滚动和点击动作互斥，而TabController只能监听到tabBar下标的切换，
//               //无法监听到点击动作，所以需要实现TabBar的点击回调，否则会出现页面死锁
//               isClick = true;
//             },
//             controller: _tabC,
//             indicatorSize: TabBarIndicatorSize.label,
//             labelColor: Color(YZThemeFMC.colors.fontColor29C542),
//             indicatorColor: Color(YZThemeFMC.colors.color29C542),
//             unselectedLabelColor: Color(YZThemeFMC.colors.fontColor595959),
//             labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
//             unselectedLabelStyle:
//                 TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
//             tabs: widget.tabs),
//       ),
//     );
//   }

//   //监听TabBar的切换事件，通知ScrollView进行页面锚点
//   void _onTabChanged() {
//     if (isClick) {
//       setState(() {
//         isScroll = false;
//         index = _tabC.index;
//       });
//     }
//   }

//   //滚动监听
//   void _onScroll(double pixels) {
//     isClick = false;
//     double offset = pixels + positions[0].dy + TABBAR_HEIGHT; //误差修正
//     //根据滚动的偏移量计算出透明度，实现appBar滚动渐变
//     double alpha = pixels / APPBAR_SCROLL_OFFSET;
//     if (alpha < 0)
//       alpha = 0;
//     else if (alpha > 1) alpha = 1;

//     setState(() {
//       appBarAlpha = alpha;
//       for (int i = 0; i < positions.length; i++) {
//         if (i == positions.length - 1) {
//           if (offset >= positions[i].dy) {
//             //当偏离值溢出控件的滚动范围，TabBar下标始终指向last one
//             isScroll = true;
//             _tabC.index = i;
//           }
//         } else if (positions[i].dy <= offset && offset < positions[i + 1].dy) {
//           //当滚动的偏离值一进入某个子模块Widget的高度范围内时，则修正TabBar对应的下标
//           isScroll = true;
//           _tabC.index = i;
//         }
//       }
//     });
//   }

//   //我们需要获取Widget的大小或位置信息。但Widget对象本身没有大小及位置数据，
//   //那么想要拿到Widget的大小及位置信息，就需要通过与Widget对象相关联的RenderBox对象来获取
//   void _getPositions() { //获取滚动视图每个子模块的位置信息
//     for (int i = 0; i < listWidgets.length; i++) {
//       GlobalKey<YZSliverWidgetEntityState> _key = GlobalKey();
//       _key = listWidgets[i].key; ////页面渲染完成后遍历拿到每个子模块视图的key
//       final RenderBox renderBox =
//           _key.currentContext.findRenderObject(); //获取`RenderBox`对象
//       final Offset position =
//           renderBox.localToGlobal(Offset.zero); //获取renderBox的位置
//       print('widget$i position =  $position');
//       positions.add(position);
//       //最后一个视图不能占满全屏的时候自动补全高度
//       // if (i == listWidgets.length - 1) {
//       //   final double lastWidgetHeight = renderBox.size.height;
//       //   final double deviceHeight = MediaQuery.of(context).size.height;
//       //   if (lastWidgetHeight < deviceHeight) {
//       //     GlobalKey<YZSliverWidgetEntityState> _key = GlobalKey();
//       //     listWidgets.removeLast();
//       //     listWidgets.add(YZSliverWidgetEntity(
//       //         key: _key,
//       //         childView: widget.listWidgets.last,
//       //         height: deviceHeight));
//       //   }
//       // }
//     }
//   }
// }

// //滚动页面的body部分
// class YZBodyView extends StatefulWidget {
//   final List<YZSliverWidgetEntity> listWidgets;
//   final int index;
  
//   final bool isScroll;
//   final List<Offset> positions;

//   YZBodyView(this.listWidgets, this.index, this.isScroll, this.positions);

//   @override
//   _YZBodyViewState createState() => _YZBodyViewState();
// }

// class _YZBodyViewState extends State<YZBodyView> {
//   ScrollController _innerC;

//   @override
//   void initState() {
//     super.initState();
//     Widget? primaryScrollController =
//         context.findAncestorWidgetOfExactType(); //取得上下文的父类控制body的主控制器
//     _innerC = primaryScrollController?.controller; //让内控制器等于取到的这个控制器
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!widget.isScroll) _actions(widget.index);

//     return new SingleChildScrollView(
//       child: new Column(children: widget.listWidgets),
//     );
//   }

//   //锚点动作
//   void _actions(int index) {
//     setState(() {
//       WidgetsBinding.instance.addPostFrameCallback((callback) {
//         for (int i = 0; i < widget.positions.length; i++) {
//           if (index == 0) {
//             _innerC.jumpTo(0.0); //点击第一个tab直接跳转至顶部
//             break;
//           } else {
//             //点击tab跳转误差修正，positions记录的只是实际渲染的renderBox位置
//             //_innerC控制的只是可滚动的部分，不包含NestedScrollView以外的部分
//             double position =
//                 widget.positions[i].dy - widget.positions[0].dy - TABBAR_HEIGHT;
//             if (index == i) {
//               //跳转到页面指定位置
//               _innerC.jumpTo(position);
//               break;
//             }
//           }
//         }
//       });
//     });
//   }
// }

// //对传入的widgets进行封装处理以便取得每个widget的key
// class YZSliverWidgetEntity extends StatefulWidget {
//   final Widget childView;
//   final double height;
//   YZSliverWidgetEntity({Key key, this.childView, this.height})
//       : super(key: key);
//   @override
//   YZSliverWidgetEntityState createState() => YZSliverWidgetEntityState();
// }

// class YZSliverWidgetEntityState extends State<YZSliverWidgetEntity> {
//   Widget childView;

//   @override
//   void initState() {
//     super.initState();
//     childView = widget.childView;
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: widget.height,
//       child: childView,
//     );
//   }
// }