import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:yx_flutter/Class/res/gaps.dart';

import '../../Common/image_utils.dart';
import '../../Common/public_func.dart';
import '../../Common/yx_constant.dart';

class CDCompany extends StatelessWidget {
  const CDCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cswColor,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: LoadImage(
                'https://img2.baidu.com/it/u=3219906533,2982923681&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=500',
                width: CW(50),
                height: CW(50)),
          ),
          Gaps.hGap10,
          buildCenter(),
          Gaps.hGap10,
          LoadAssetImage('arrow-right', width: CW(12), height: CW(14))
        ],
      ),
    );
  }

  Widget buildCenter() {
    return Expanded(
        child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StText('SuDream', fw: FontWeight.bold, fs: 18),
          Gaps.vGap8,
          StText('去年藏的柳絮己珍贵',  fs: 12),
               Gaps.vGap8,
          Row(
            children: [
              StText('去年藏的柳絮己珍贵',  color: singleRgba(153),fs:12),
              LoadAssetImage('xq', width: CW(15), height: CW(15))
            ],
          )
        ],
      ),
    ));
  }
}
