import 'package:flutter/material.dart';

import 'package:yx_flutter/Class/Common/image_utils.dart';
import 'package:yx_flutter/Class/Common/public_func.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yx_flutter/Class/Crowdfunding/widgets/cf_top.dart';

import '../../Common/yx_constant.dart';

class CrowdfundingPage extends StatefulWidget {
  const CrowdfundingPage({super.key});

  @override
  State<CrowdfundingPage> createState() => _CrowdfundingPageState();
}

class _CrowdfundingPageState extends State<CrowdfundingPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(750, 1624));
    return Scaffold(
      extendBodyBehindAppBar: true, // 背景透明
      backgroundColor: rgba(244, 244, 244, 1),
      appBar: AppBar(
        title: Text('严选众筹'),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: SDInkWell(
                child: LoadAssetImage(
                  'share_white',
                  width: CW(28),
                  height: CW(28),
                  fit: BoxFit.contain,
                ),
                onTap: () {}),
          )
        ],
        flexibleSpace: FlexibleSpaceBar(
          background: Image.asset(
            //或者Image.network
            'assets/images/top.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
      body: SafeArea(top: false, child: buildContent()),
    );
  }

  Widget buildContent() {
    return ListView(
      children: const [CFTopV()],
    );
  }
}
