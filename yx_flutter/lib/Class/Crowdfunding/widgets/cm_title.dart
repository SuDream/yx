import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:yx_flutter/Class/Common/image_utils.dart';
import 'package:yx_flutter/Class/Common/public_func.dart';
import 'package:yx_flutter/Class/res/gaps.dart';

class CMTitle extends StatelessWidget {
  String title;
  CMTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
   
      height: CW(50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadAssetImage(
            'titleRed',
            width: CW(20),
            height: CW(20),
            format: 'jpg',
          ),
            Gaps.hGap8,
          StText(
            title,
            fs: 20,
            fw: FontWeight.bold,
          ),
          Gaps.hGap8,
          LoadAssetImage(
            'titleRed',
            width: CW(20),
            height: CW(20),
            format: 'jpg',
          )
        ],
      ),
    );
  }
}
