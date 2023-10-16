// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:yx_flutter/Class/Common/test.dart';

// import '../Crowdfunding/widgets/cf_sticky_header.dart';
// import '../Crowdfunding/widgets/cm_title.dart';
// import '../Crowdfunding/widgets/commodity_item.dart';
// import 'public_func.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class Test2 extends StatefulWidget {
//   const Test2({super.key});

//   @override
//   State<Test2> createState() => _Test2State();
// }

// class _Test2State extends State<Test2> {

//   ScrollController _ctl = new ScrollController(); //NestedScrollView的主控制器
//   List<Offset> positions = []; //记录每个子模块的位置信息
//   int _tabC = 0;

//   List<Map> keys = [
//     {'title': 'row1', 'key': GlobalKey()},
//     {'title': 'row2', 'key': GlobalKey()},
//     {'title': 'row3', 'key': GlobalKey()},
//     {'title': 'row4', 'key': GlobalKey()},
//     {'title': 'row5', 'key': GlobalKey()},
//     {'title': 'row6', 'key': GlobalKey()},
//     {'title': 'row7', 'key': GlobalKey()},
//     {'title': 'row8', 'key': GlobalKey()}
//   ];

//   List<String> comType = [
//     '热卖爆款',
//     '每周上新',
//     '珠玉文玩',
//     '茶叶杯盏4',
//     '茶叶杯盏5',
//     '茶叶杯盏6',
//     '茶叶杯盏7',
//     '茶叶杯盏8',
//   ];
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     //  _tabC.addListener(() => _onTabChanged());

// //监听滚动位置
//     // _ctl.addListener(() => _onScroll(_ctl.position.pixels));
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       //监听Widget是否绘制完毕
//       _getPositions();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     ScreenUtil.init(context, designSize: const Size(750, 1624));
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('ss'),
//         ),
//         body: NotificationListener<ScrollNotification>(
//           onNotification: (ScrollNotification notification) {
//             if (notification is ScrollUpdateNotification) {
//                 //UserScrollNotification
//               print('--------触发');
//               //ScrollUpdateNotification判断是为了确保是由滚动触发的offset的改变
//               ScrollMetrics metrics = notification.metrics;
//               _onScroll(notification.metrics.pixels);
//             }
//             return false;
//           },
//           child: CustomScrollView(
//             controller: _ctl,
//             slivers: [
//               CFStickyHeader(
//                 tabs: comType,
//                 onTap: (index) {
//                   print(index);
//                   _actions(index);
//                 },
//               ),
//               buildList(),
//             ],
//             physics: const BouncingScrollPhysics(),
//           ),
//         ));
//   }

//   Widget buildList() {
//     return SliverToBoxAdapter(
//       child: Column(
//         children: keys
//             .map((e) => buildCommondityType(e['key'], title: e['title']))
//             .toList(),
//       ),
//     );
//   }

//   Widget buildCommondityType(key, {isShowTop = true, title = ''}) {
//     return Column(
//       key: key,
//       children: [
//         if (isShowTop) CMTitle(title: title),
//         CommodityItem(),
//         CommodityItem(),
//         CommodityItem(),
//         CommodityItem(),
//       ],
//     );
//   }

//   //我们需要获取Widget的大小或位置信息。但Widget对象本身没有大小及位置数据，
//   //那么想要拿到Widget的大小及位置信息，就需要通过与Widget对象相关联的RenderBox对象来获取
//   void _getPositions() {
//     //获取滚动视图每个子模块的位置信息
//     for (int i = 0; i < keys.length; i++) {
//       GlobalKey _key = GlobalKey();
//       _key = keys[i]['key']; ////页面渲染完成后遍历拿到每个子模块视图的key

//       final Offset position =
//           (_key.currentContext?.findRenderObject() as RenderBox)
//               .localToGlobal(Offset.zero);

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

//   //   //锚点动作
//   void _actions(int index) {
//     setState(() {
//       WidgetsBinding.instance.addPostFrameCallback((callback) {
//         for (int i = 0; i < positions.length; i++) {
//           if (index == 0) {
//             _ctl.jumpTo(0.0); //点击第一个tab直接跳转至顶部
//             break;
//           } else {
//             //点击tab跳转误差修正，positions记录的只是实际渲染的renderBox位置
//             //_innerC控制的只是可滚动的部分，不包含NestedScrollView以外的部分
//             double position = positions[i].dy - positions[0].dy;

//             if (index == i) {
//               //跳转到页面指定位置
//               _ctl.jumpTo(position);
//               break;
//             }
//           }
//         }
//       });
//     });
//   }

//   //   //滚动监听
//   void _onScroll(double pixels) {
//     double offset = pixels + positions[0].dy; //误差修正

//     setState(() {
//       for (int i = 0; i < positions.length; i++) {
//         if (i == positions.length - 1) {
//           if (offset >= positions[i].dy) {
//             //当偏离值溢出控件的滚动范围，TabBar下标始终指向last one
//             _tabC = i;
//             print("当前index:${i}");
//           }
//         } else if (positions[i].dy <= offset && offset < positions[i + 1].dy) {
//           //当滚动的偏离值一进入某个子模块Widget的高度范围内时，则修正TabBar对应的下标

//           _tabC = i;

//           print("---------当前index:${i}");
//         }
//       }
//     });
//   }
// }
