import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:yx_flutter/Class/Common/yx_constant.dart';

import '../../Common/public_func.dart';
import 'package:card_swiper/card_swiper.dart';

import '../../Tools/option_gridview.dart';
import 'cmd_grid_item.dart';

class CDRecommend extends StatefulWidget {
  const CDRecommend({super.key});

  @override
  State<CDRecommend> createState() => _CDRecommendState();
}

class _CDRecommendState extends State<CDRecommend>
    with SingleTickerProviderStateMixin {
  List<String> tabTitles = ['你可能还喜欢', '24小时热销'];
  List<Widget> listCtr = [];
  late TabController tabController;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: cswColor,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        children: [
          Container(
            decoration:const BoxDecoration(
                border: Border(bottom: BorderSide(width: 1, color: lineColor))),
            child: buildTabbar(),
          ),
          buildConent(),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listCtr = [CDToolsV(), CDToolsV()];
    tabController = TabController(length: listCtr.length, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }

  Widget buildTabbar() {
    return ClearWave(
        child: TabBar(
            //设置tab是否可水平滑动
            // isScrollable: true,
            //控制器
            controller: tabController,
            //设置tab文字得类型
            labelStyle:
                TextStyle(fontSize: FSp(13), fontWeight: FontWeight.bold),
            //设置tab选中得颜色
            labelColor: Colors.black,

            //设置tab未选中得颜色
            unselectedLabelColor: Colors.black,
            unselectedLabelStyle: TextStyle(fontSize: FSp(13)),
            // indicatorColor: Colors.black,
            indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(width: 2, color: reds),
                insets: EdgeInsets.symmetric(horizontal: 30.0)),
            tabs: tabTitles.map((item) {
              return Tab(text: item);
            }).toList()));
  }

  Widget buildConent() {
    return Container(
      height: CW(440),
      child: TabBarView(controller: tabController, children: listCtr),
    );
  }
}

class CDToolsV extends StatefulWidget {
  const CDToolsV({super.key});

  @override
  State<CDToolsV> createState() => _CDToolsVState();
}

class _CDToolsVState extends State<CDToolsV> {
  @override
  Widget build(BuildContext context) {
    return buildSwiper();
  }

  Widget buildSwiper() {
    return Swiper(
        loop: false,
        itemBuilder: (BuildContext context, int index) {
          return buildItem();
        },
        itemCount: 3,
        pagination: SwiperPagination(
            builder: DotSwiperPaginationBuilder(
                color: singleRgba(129), activeColor: reds)));
  }

  Widget buildItem() {
    return Container(
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: OptionGridView(
          itemCount: 6,
          rowCount: 3,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          itemBuilder: (context, index) => CMDGridItem(),
        ));
  }
}
