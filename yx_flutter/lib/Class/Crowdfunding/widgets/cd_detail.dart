import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../Common/public_func.dart';
import '../../Common/yx_constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CDDetail extends StatefulWidget {
  const CDDetail({super.key});

  @override
  State<CDDetail> createState() => _CDDetailState();
}

class _CDDetailState extends State<CDDetail>
    with SingleTickerProviderStateMixin {
  List<String> tabTitles = ['详情', '常见问题'];
  double webViewHeight = 0;
  int currentIndex = 0;
  WebViewController controller = WebViewController();
  String html = """
   <!DOCTYPE html>
        <html>
        <head><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
          <body>
            <p> Hello WebView 掘金</p>
            <img src="https://img95.699pic.com/desgin_photo/40165/3898_detail.jpg%21detail860/fw/820/crop/0x1309a0a0/quality/90"/ model="fit">
          </body>
        </html>
        <script>
          const resizeObserver = new ResizeObserver(entries =>
          Resize.postMessage(document.documentElement.scrollHeight.toString()) )
          resizeObserver.observe(document.body)
        </script>
  """;
  late TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabController = TabController(length: tabTitles.length, vsync: this);
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel('Resize',
          onMessageReceived: (JavaScriptMessage message) {
        double height = double.parse(message.message);
        setState(() {
          webViewHeight = height;
        });
      })
      ..loadHtmlString(html);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cswColor,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(width: 1, color: lineColor))),
            child: buildTabbar(),
          ),
          currentIndex == 0 ? buildConent() : buildProblem()
        ],
      ),
    );
  }

  Widget buildTabbar() {
    return ClearWave(
        child: TabBar(
            //设置tab是否可水平滑动
            // isScrollable: true,
            //控制器
            controller: tabController,
            //设置tab文字得类型
            labelStyle:
                TextStyle(fontSize: FSp(13), fontWeight: FontWeight.bold),
            //设置tab选中得颜色
            labelColor: Colors.black,

            //设置tab未选中得颜色
            unselectedLabelColor: Colors.black,
            unselectedLabelStyle: TextStyle(fontSize: FSp(13)),
            // indicatorColor: Colors.black,
            indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(width: 2, color: reds),
                insets: EdgeInsets.symmetric(horizontal: 30.0)),
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            tabs: tabTitles.map((item) {
              return Tab(text: item);
            }).toList()));
  }

  Widget buildConent() {
    return SizedBox(
        height: webViewHeight,
        child: WebViewWidget(
          controller: controller,
        ));
  }

  Widget buildProblem() {
    return SizedBox(
        height: CW(200),
        child: Center(
          child: StText('常见问题'),
        ));
  }
}
