import 'package:flutter/material.dart';
import 'package:yx_flutter/Class/Common/image_utils.dart';
import 'package:yx_flutter/Class/Common/public_func.dart';
import 'package:yx_flutter/Class/res/gaps.dart';

import '../../Common/yx_constant.dart';

class CMDGridItem extends StatelessWidget {
  const CMDGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: cswColor, borderRadius: BorderRadius.circular(3)),
        width: CW(120),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: LoadImage(
                'com',
                width: CW(120),
                height: CW(120),
                format: 'jpg',
              ),
            ),
            Gaps.vGap4,
            buildTitle(),
            Gaps.vGap8,
            buildButtom()
          ],
        ));
  }

  Widget buildTitle() {
    return StText('你总不小心把倩影靠在月亮上面万道光芒蓬松着你长发的波澜', fs: 12, maxLines: 2);
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
                          text: "191",
                          style: TextStyle(
                              color: rgba(237, 43, 11, 1), fontSize: FSp(12))),
                      TextSpan(
                          text: "¥188",
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: singleRgba(153),
                              fontSize: FSp(9))),
                    ]))),
        SDInkWell(
            child: LoadAssetImage('gwc', width: CW(20), height: CW(20)),
            onTap: () {})
      ],
    );
  }
}
