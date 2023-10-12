import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:yx_flutter/Class/Common/public_func.dart';
import 'package:get/get.dart';
import 'package:yx_flutter/Class/res/gaps.dart';
import '../../Common/image_utils.dart';
import '../../Common/yx_constant.dart';
import '../../i18n/keys.dart';

class CFTopV extends StatelessWidget {
  const CFTopV({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [tips(), naviType(),naviTools()],
    );
  }

  Widget tips() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        topTips(),
        Container(
            height: CW(14),
            decoration: BoxDecoration(
                color: rgba(244, 244, 244, 1),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(CW(7)),
                    topRight: Radius.circular(CW(7))))),
      ],
    );
  }

  Widget topTips() {
    return Container(
      height: CW(50),
      width: double.infinity,
      padding: EdgeInsets.only(bottom: CW(5)),
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                'assets/images/botton.jpg',
              ))),
      child: tipsList(),
    );
  }

  Widget tipsList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        tipsItem('zp', LocaleKeys.zpdj.tr),
        tipsItem('zp', LocaleKeys.gfsx.tr),
        tipsItem('zp', LocaleKeys.jxhw.tr),
        tipsItem('zp', LocaleKeys.sh.tr)
      ],
    );
  }

  Widget tipsItem(String imagePath, String title) {
    return Row(
      children: [
        LoadAssetImage(imagePath, width: CW(20), height: CW(20)),
        StText(title, fs: 12, color: cswColor)
      ],
    );
  }

  Widget naviType() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          naviTypeItem('naviType', '拍卖', '假一赔三'),
          Gaps.hGap15,
          naviTypeItem('naviType', '拍卖', '假一赔三')
        ],
      ),
    );
  }

  Widget naviTypeItem(imge, title, tags) {
    return Expanded(
        child: Container(
      height: CW(102),
      padding: EdgeInsets.all(CW(15)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: const DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                'assets/images/naviType.jpg',
              ))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StText(title, color: cswColor, fs: 22, fw: FontWeight.bold),
          buildNTITag(tags)
        ],
      ),
    ));
  }

  Widget buildNTITag(tags) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: CW(70),
          height: CW(25),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(CW(5)),
              border: Border.all(color: cswColor, width: 1)),
          child: StText(tags, color: cswColor, fs: 11),
        ),
        LoadAssetImage('arrow_right', width: CW(25), height: CW(25))
      ],
    );
  }

  Widget naviTools() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [nTItem('', ''),nTItem('', ''),nTItem('', ''),nTItem('', '')],
      
    );
  }

  Widget nTItem(image, title) {
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: CW(80),
                height: CW(80),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(CW(45)), color: reds),
              )
            ],
          )
        ],
      ),
    );
  }
}
