import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:yx_flutter/Class/Common/image_utils.dart';
import 'package:yx_flutter/Class/Common/yx_constant.dart';
import 'package:yx_flutter/Class/res/gaps.dart';

import '../../Common/public_func.dart';
import '../../i18n/keys.dart';
import 'package:get/get.dart';

class CDLogistics extends StatelessWidget {
  const CDLogistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cswColor,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [buildOne(), buildTwo(), buildThree()],
      ),
    );
  }

  Widget buildOne() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: CW(10)),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.5, color: lineColor))),
      child: Row(
        children: [
          Expanded(
              child: RichText(
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
                        const TextSpan(
                          text: "¥",
                        ),
                        TextSpan(
                            text: "188111 ",
                            style: TextStyle(
                              color: rgba(157, 58, 60, 1),
                            )),
                        TextSpan(
                          text: '${LocaleKeys.priceStart.tr} ',
                        ),
                        TextSpan(
                            text: "¥11288",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.lineThrough,
                                color: singleRgba(153),
                                fontSize: FSp(12))),
                      ]))),
          Gaps.hGap4,
          StText(
            '共12档,立即获取',
            fs: 11,
          ),
          Gaps.hGap4,
          LoadAssetImage('arrow-right', width: CW(10), height: CW(12))
        ],
      ),
    );
  }

  Widget buildTwo() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: CW(10)),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.5, color: lineColor))),
      child: Row(
        children: [
          Expanded(
              child: StText(
            '${LocaleKeys.fhsj.tr}:',
            fs: 11,
          )),
          Gaps.hGap4,
          StText(
            '2023年1月11',
            fs: 11,
            color: singleRgba(153),
          ),
        ],
      ),
    );
  }

  Widget buildThree() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: CW(10)),
      child: Row(
        children: [
          Expanded(
              child: StText(
            '${LocaleKeys.fw.tr}:',
            fs: 11,
          )),
          Gaps.hGap4,
          StText(
            '',
            fs: 11,
          ),
        ],
      ),
    );
  }
}
