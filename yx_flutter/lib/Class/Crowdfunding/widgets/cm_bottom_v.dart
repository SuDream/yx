import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:yx_flutter/Class/Common/image_utils.dart';
import 'package:yx_flutter/Class/Common/public_func.dart';
import 'package:yx_flutter/Class/Common/yx_constant.dart';
import 'package:yx_flutter/Class/i18n/keys.dart';
import 'package:get/get.dart';
import 'package:yx_flutter/Class/res/gaps.dart';

class CMBottomV extends StatelessWidget {
  const CMBottomV({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      height: CW(60),
      decoration: BoxDecoration(
          color: cswColor,
          border: Border(top: BorderSide(width: 1, color: singleRgba(221)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildLeft(),
          Gaps.hGap10,
          buildBotton()
        ],
      ),
    );
  }

  Widget buildLeft() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildItem('gz', LocaleKeys.zc.tr),
        Gaps.hGap15,
        buildItem('gz', LocaleKeys.kf.tr),
        Gaps.hGap15,
        buildItem('gz', LocaleKeys.gz.tr)
      ],
    );
  }

  Widget buildItem(image, title) {
    return SDInkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadAssetImage(image, width: CW(25), height: CW(25)),
            StText(
              title,
            )
          ],
        ),
        onTap: () {});
  }

  Widget buildBotton() {
    return Expanded(child: SDInkWell(
        child: Container(
          alignment: Alignment.center,
          // padding: EdgeInsets.symmetric(horizontal: CW(15)),
          height: CW(36),
          decoration: BoxDecoration(
              color: rgba(217, 45, 42, 1),
              borderRadius: BorderRadius.circular(CW(18))),
          child: StText(LocaleKeys.purchase.tr, fs: 16, color: cswColor),
        ),
        onTap: () {}));
  }
}
