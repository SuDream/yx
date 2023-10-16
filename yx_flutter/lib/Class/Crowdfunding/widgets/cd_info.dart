import 'package:flutter/material.dart';
import 'package:yx_flutter/Class/Common/image_utils.dart';
import 'package:yx_flutter/Class/Common/public_func.dart';
import 'package:yx_flutter/Class/Common/yx_constant.dart';
import 'package:yx_flutter/Class/i18n/keys.dart';
import 'package:yx_flutter/Class/res/gaps.dart';
import 'package:get/get.dart';

class CDInfo extends StatelessWidget {
  const CDInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      color: cswColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StText('心无旁骛地 相拥,心无旁骛地 相拥心无旁骛地 相拥',
              fs: 18, fw: FontWeight.bold, maxLines: 1),
          StText(
              color: singleRgba(153),
              '心无旁骛地 相拥,心无旁骛地 相拥心无旁骛地 相拥心无旁骛地 相拥,心无旁骛地',
              fs: 13,
              maxLines: 2),
          Gaps.vGap10,
          Row(
            children: [
              ClipOval(
                child: LoadImage(
                    'https://img2.baidu.com/it/u=3219906533,2982923681&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=500',
                    width: CW(25),
                    height: CW(25)),
              ),
              Gaps.hGap8,
              StText(color: singleRgba(153), 'SuDream', fs: 13, maxLines: 2),
            ],
          ),
          Gaps.vGap10,
          buildPrice(),
          Gaps.vGap10,
          buildProgres(0.9),
          Gaps.vGap10,
          buildPriceInfo()
        ],
      ),
    );
  }

  Widget buildPrice() {
    return RichText(
        textAlign: TextAlign.start,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
            style: TextStyle(
              color: rgba(157, 58, 60, 1),
              fontSize: FSp(15),
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: LocaleKeys.dz.tr,
              ),
              const TextSpan(
                text: "¥",
              ),
              TextSpan(
                  text: "188111 ",
                  style: TextStyle(
                    color: rgba(157, 58, 60, 1),
                  )),
              TextSpan(
                  text: "¥11288",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.lineThrough,
                      color: singleRgba(153),
                      fontSize: FSp(12))),
            ]));
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
          child: SizedBox(height: CW(10)),
        )),
        Gaps.hGap10,
        StText('100%', fs: 15, color: reds, fw: FontWeight.bold)
      ],
    );
  }

  Widget buildPriceInfo() {
    return Row(
      children: [
        buildPIItem('550元', LocaleKeys.ycje.tr),
        buildPIItem('5500元', LocaleKeys.mbje.tr),
        buildPIItem('1人', LocaleKeys.zcrs.tr),
        buildPIItem('20天22时', LocaleKeys.sysj.tr, showLine: false),
      ],
    );
  }

  Widget buildPIItem(nub, explain, {bool showLine = true}) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
          border: Border(
              right: showLine
                  ? const BorderSide(color: lineColor, width: 1)
                  : BorderSide.none)),
      child: Column(
        children: [
          StText(nub, fs: 14, fw: FontWeight.bold),
          Gaps.vGap4,
          StText(explain, fs: 11, color: singleRgba(153))
        ],
      ),
    ));
  }
}
