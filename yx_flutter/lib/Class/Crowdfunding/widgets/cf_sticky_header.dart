import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yx_flutter/Class/Common/image_utils.dart';
import '../../Common/public_func.dart';
import '../../Common/yx_constant.dart';
import '../../Tools/StickyHeaderDelegate.dart';

class CFStickyHeader extends StatefulWidget {
  List<Map> tabs = [];
  TabController tabController;
  final ValueChanged<int>? onTap;
  CFStickyHeader(
      {super.key, required this.tabs, this.onTap, required this.tabController});

  @override
  State<CFStickyHeader> createState() => _CFStickyHeaderState();
}

class _CFStickyHeaderState extends State<CFStickyHeader>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    // widget.tabController.addListener(() {
    //   onChangeIndex();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: StickyHeaderDelegate(
        minHeight: CW(50),
        maxHeight: CW(50),
        child: Container(
          height: CW(50),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          decoration: BoxDecoration(
              color: cswColor, borderRadius: BorderRadius.circular(CW(5))),
          alignment: Alignment.centerLeft,
          child: TabBar(
              controller: widget.tabController,
              // 多个标签时滚动加载
              isScrollable: true,
              indicator: const BoxDecoration(),
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                  widget.onTap?.call(index);
                });
              },
              tabs: widget.tabs
                  .asMap()
                  .entries
                  .map((e) => buildItem(e.value['title'], e.key))
                  .toList()),
          // 标签页所对应的页面
        ),
      ),
    );
  }

  Widget buildItem(item, index) {
    return Tab(
      child: Row(
        children: [
          if (widget.tabController.index == index)
            LoadAssetImage('location', width: CW(14), height: CW(14)),
          StText(item,
              fs: 14,
              color: widget.tabController.index == index ? reds : Colors.black,
              fw: widget.tabController.index == index ? FontWeight.bold : FontWeight.normal)
        ],
      ),
    );
  }

  // void onChangeIndex() {
  //   setState(() {
     
  //     index = _tabC.index;
  //   });
  // }
}
