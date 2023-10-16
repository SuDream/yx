import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:yx_flutter/Class/Common/image_utils.dart';
import 'package:yx_flutter/Class/Common/public_func.dart';
import 'package:yx_flutter/Class/Common/yx_constant.dart';
import 'package:yx_flutter/Class/Crowdfunding/pages/commodity_details.dart';
import 'package:yx_flutter/Class/i18n/keys.dart';
import 'package:yx_flutter/Class/res/gaps.dart';
import 'package:get/get.dart';

class CommodityItem extends StatelessWidget {
  const CommodityItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SDInkWell(
        child: Container(
          margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: cswColor, borderRadius: BorderRadius.circular(8)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [buildLeft(), Gaps.hGap10, buildRight()],
          ),
        ),
        onTap: () {
          Get.to(() => const CommodityDetails());
        });
  }

  Widget buildLeft() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LoadImage(
            'com',
            width: CW(100),
            height: CW(100),
            format: 'jpg',
          ),
        ),
        Positioned(
            left: CW(8),
            top: CW(8),
            child: Container(
              // alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
              decoration: BoxDecoration(
                  color: cswColor, borderRadius: BorderRadius.circular(3)),
              child: StText('古树普洱', fs: 12),
            ))
      ],
    );
  }

  Widget buildRight() {
    return Expanded(
        child: SizedBox(
      height: CW(100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StText('仿佛昔日又重来仿佛昔日又重来重来重来重来重来重来',
              fs: 13, fw: FontWeight.bold, maxLines: 2),
          buildProgres(0.8),
          buildTime(),
          buildButtom(),
        ],
      ),
    ));
  }

//progress 0-1
  Widget buildProgres(double progress) {
    return Row(
      children: [
        Expanded(
            child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(colors: [
                rgba(239, 167, 90, 1),
                rgba(231, 108, 96, 1),
                singleRgba(244),
              ], stops: [
                progress / 2,
                progress,
                progress,
              ])),
          child: SizedBox(height: CW(5)),
        )),
        Gaps.hGap10,
        StText(
          '100%',
          fs: 11,
          color: reds,
        )
      ],
    );
  }

  Widget buildTime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildTSubItem('timeicon', '剩余17天23时'),
        buildTSubItem('people', '21人已支持')
      ],
    );
  }

  Widget buildTSubItem(image, cont) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LoadAssetImage(image, width: CW(15), height: CW(15)),
        StText(cont, color: singleRgba(153), fs: 11)
      ],
    );
  }

  Widget buildButtom() {
    return Row(
      children: [
        Expanded(
            child: RichText(
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                    style: TextStyle(
                      color: reds,
                      fontSize: FSp(9),
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      const TextSpan(
                        text: "¥",
                      ),
                      TextSpan(
                          text: "188111",
                          style: TextStyle(
                              color: rgba(237, 43, 11, 1), fontSize: FSp(12))),
                      TextSpan(
                        text: '${LocaleKeys.priceStart.tr} ',
                      ),
                      TextSpan(
                          text: "¥11288",
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: singleRgba(153),
                              fontSize: FSp(9))),
                    ]))),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: CW(9)),
          height: CW(22),
          decoration: BoxDecoration(
              color: rgba(217, 45, 42, 1),
              borderRadius: BorderRadius.circular(CW(11))),
          child: StText('立即支持', fs: 12, color: cswColor),
        )
      ],
    );
  }
}
