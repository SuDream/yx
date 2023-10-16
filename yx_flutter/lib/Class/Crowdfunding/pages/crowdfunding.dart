import 'package:flutter/material.dart';

import 'package:yx_flutter/Class/Common/image_utils.dart';
import 'package:yx_flutter/Class/Common/public_func.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yx_flutter/Class/Crowdfunding/widgets/cf_top.dart';
import 'package:yx_flutter/Class/Crowdfunding/widgets/cm_title.dart';
import 'package:yx_flutter/Class/i18n/keys.dart';
import 'package:yx_flutter/Class/res/gaps.dart';

import '../../Common/yx_constant.dart';
import '../../Tools/StickyHeaderDelegate.dart';
import '../../Tools/option_gridview.dart';
import '../widgets/cf_sticky_header.dart';
import '../widgets/cmd_grid_item.dart';
import 'package:get/get.dart';
import '../widgets/commodity_item.dart';

class CrowdfundingPage extends StatefulWidget {
  const CrowdfundingPage({super.key});

  @override
  State<CrowdfundingPage> createState() => _CrowdfundingPageState();
}

class _CrowdfundingPageState extends State<CrowdfundingPage>
    with SingleTickerProviderStateMixin {
  ScrollController _ctl = new ScrollController(); //NestedScrollView的主控制器
  List<Offset> positions = []; //记录每个子模块的位置信息
  late TabController tabCtr;
  double correct = 0; //修正

  List<Map> keys = [
    {'title': '热卖爆款', 'key': GlobalKey()},
    {'title': '每周上新', 'key': GlobalKey()},
    {'title': '珠玉文玩', 'key': GlobalKey()},
    {'title': '茶叶杯盏4', 'key': GlobalKey()},
    {'title': '茶叶杯盏5', 'key': GlobalKey()},
    {'title': '茶叶杯盏6', 'key': GlobalKey()},
    {'title': '茶叶杯盏7', 'key': GlobalKey()},
    {'title': '茶叶杯盏8', 'key': GlobalKey()}
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabCtr = TabController(length: keys.length, vsync: this);
     _ctl.addListener(() => _onScroll(_ctl.position.pixels));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      correct = AppBar().preferredSize.height +
          MediaQuery.of(context).padding.top +
          CW(40);

      //监听Widget是否绘制完毕
      _getPositions();
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(750, 1624));
    return Scaffold(
      backgroundColor: rgba(244, 244, 244, 1),
      appBar: AppBar(
        title: const Text('严选众筹'),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: SDInkWell(
                child: LoadAssetImage(
                  'share_white',
                  width: CW(28),
                  height: CW(28),
                  fit: BoxFit.contain,
                ),
                onTap: () {}),
          )
        ],
        flexibleSpace: FlexibleSpaceBar(
          background: Image.asset(
            //或者Image.network
            'assets/images/top.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
      body: SafeArea(child: buildContent()),
    );
  }

  Widget buildContent() {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollUpdateNotification) {
          //UserScrollNotification
          // print('--------触发');
          //ScrollUpdateNotification判断是为了确保是由滚动触发的offset的改变
          ScrollMetrics metrics = notification.metrics;
          // _onScroll(notification.metrics.pixels);
        }
        return false;
      },
      child: CustomScrollView(
        controller: _ctl,
        slivers: [
          const SliverToBoxAdapter(
            child: CFTopV(),
          ),
          CFStickyHeader(
              tabs: keys,
              tabController: tabCtr,
              onTap: (index) {
                print(index);
                _actions(index);
              }),
          buildList(),
          buildGrid()
        ],
        physics: const BouncingScrollPhysics(),
      ),
    );
  }

  Widget buildList() {
    return SliverToBoxAdapter(
      child: Column(
        children: keys
            .map((e) => buildCommondityType(e['key'], title: e['title']))
            .toList(),
      ),
    );
  }

  Widget buildCommondityType(key, {isShowTop = true, title = ''}) {
    return Column(
      key: key,
      children: [
        if (isShowTop) CMTitle(title: title),
        CommodityItem(),
        CommodityItem(),
        CommodityItem(),
        CommodityItem(),
        SDInkWell(
            child: Container(
              alignment: Alignment.center,
              width: CW(80),
              height: CW(30),
              decoration: BoxDecoration(
                  color: cswColor, borderRadius: BorderRadius.circular(CW(15))),
              child: StText(LocaleKeys.more.tr),
            ),
            onTap: () {})
      ],
    );
  }

  Widget buildGrid() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: OptionGridView(
                itemCount: 9,
                rowCount: 3,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                itemBuilder: (context, index) => CMDGridItem(),
              )),
          Gaps.vGap10,
          SDInkWell(
              child: Container(
                alignment: Alignment.center,
                width: CW(90),
                height: CW(30),
                decoration: BoxDecoration(
                    color: cswColor,
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(CW(15))),
                child: StText(LocaleKeys.change.tr),
              ),
              onTap: () {})
        ],
      ),
    );
  }

  //我们需要获取Widget的大小或位置信息。但Widget对象本身没有大小及位置数据，
  //那么想要拿到Widget的大小及位置信息，就需要通过与Widget对象相关联的RenderBox对象来获取
  void _getPositions() {
    //获取滚动视图每个子模块的位置信息
    for (int i = 0; i < keys.length; i++) {
      GlobalKey _key = GlobalKey();
      _key = keys[i]['key']; ////页面渲染完成后遍历拿到每个子模块视图的key

      final Offset position =
          (_key.currentContext?.findRenderObject() as RenderBox)
              .localToGlobal(Offset.zero);

      print('widget$i position =  $position');
      positions.add(position);
      //最后一个视图不能占满全屏的时候自动补全高度
      // if (i == listWidgets.length - 1) {
      //   final double lastWidgetHeight = renderBox.size.height;
      //   final double deviceHeight = MediaQuery.of(context).size.height;
      //   if (lastWidgetHeight < deviceHeight) {
      //     GlobalKey<YZSliverWidgetEntityState> _key = GlobalKey();
      //     listWidgets.removeLast();
      //     listWidgets.add(YZSliverWidgetEntity(
      //         key: _key,
      //         childView: widget.listWidgets.last,
      //         height: deviceHeight));
      //   }
      // }
    }
  }

  //   //锚点动作
  void _actions(int index) {
    setState(() {
      WidgetsBinding.instance.addPostFrameCallback((callback) {
        for (int i = 0; i < positions.length; i++) {
          if (index == 0) {
            _ctl.jumpTo(0.0); //点击第一个tab直接跳转至顶部
            break;
          } else {
            //点击tab跳转误差修正，positions记录的只是实际渲染的renderBox位置
            //_innerC控制的只是可滚动的部分，不包含NestedScrollView以外的部分
            print(positions[i].dy);
            print(positions[0].dy);
            double position = positions[i].dy - correct;

            if (index == i) {
              //跳转到页面指定位置
              _ctl.jumpTo(position);
              break;
            }
          }
        }
      });
    });
  }

  //   //滚动监听
  void _onScroll(double pixels) {
    double offset = pixels + correct; //误差修正

    setState(() {
      for (int i = 0; i < positions.length; i++) {
        if (i == positions.length - 1) {
          if (offset >= positions[i].dy) {
            //当偏离值溢出控件的滚动范围，TabBar下标始终指向last one
            if (tabCtr.index != i) {
              tabCtr.index = i;
            }

            print("当前index:${i}");
          }
        } else if (positions[i].dy <= offset && offset < positions[i + 1].dy) {
          //当滚动的偏离值一进入某个子模块Widget的高度范围内时，则修正TabBar对应的下标

          if (tabCtr.index != i) {
            tabCtr.index = i;
          }

          print("---------当前index:${i}");
        }
      }
    });
  }
}
