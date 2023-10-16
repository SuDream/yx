import 'package:flutter/material.dart';
import 'package:yx_flutter/Class/Common/yx_constant.dart';
import 'package:yx_flutter/Class/res/gaps.dart';

import '../../Common/image_utils.dart';
import '../../Common/public_func.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/cd_company.dart';
import '../widgets/cd_detail.dart';
import '../widgets/cd_info.dart';
import '../widgets/cd_logistics.dart';
import '../widgets/cd_recommend.dart';
import '../widgets/cm_bottom_v.dart';

class CommodityDetails extends StatefulWidget {
  const CommodityDetails({super.key});

  @override
  State<CommodityDetails> createState() => _CommodityDetailsState();
}

class _CommodityDetailsState extends State<CommodityDetails> {
  final List<String> arrUrl = [
    "https://img1.baidu.com/it/u=567782244,1695500002&fm=253&fmt=auto&app=138&f=JPEG?w=753&h=500",
    "https://img2.baidu.com/it/u=3219906533,2982923681&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=500",
    "https://lmg.jj20.com/up/allimg/tp09/210Z614150050M-0-lp.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(244, 244, 244, 1),
      appBar: AppBar(
        backgroundColor: cswColor,
        foregroundColor: Colors.black,
        title: const Text('众筹详情页'),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: SDInkWell(
                child: LoadAssetImage(
                  'fx',
                  width: CW(28),
                  height: CW(28),
                  fit: BoxFit.contain,
                ),
                onTap: () {}),
          )
        ],
      ),
      body: SafeArea(top: false, child: buildContent()),
    );
  }

  Widget buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        scrollViewContent(),
        const CMBottomV(),
      ],
    );
  }

  Widget scrollViewContent() {
    return Expanded(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSwiper(),
          CDInfo(),
          Gaps.vGap10,
          CDLogistics(),
          Gaps.vGap10,
          CDCompany(),
          Gaps.vGap10,
          CDRecommend(),
          Gaps.vGap10,
          CDDetail()
        ],
      ),
    ));
  }

  Widget buildSwiper() {
    return Container(
      // clipBehavior: Clip.hardEdge,
      width: ScreenUtil().screenWidth,
      height: ScreenUtil().screenWidth,

      child: Swiper(
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return LoadImage(arrUrl[index],
              width: double.infinity, height: CW(224));
        },
        itemCount: arrUrl.length,

        pagination: const SwiperPagination(
            alignment: Alignment.bottomRight,
            builder: FractionPaginationBuilder(
                color: cswColor,
                activeColor: Color.fromRGBO(229, 212, 186, 1))),

        // control: new SwiperControl(),
      ),
    );
  }
}
