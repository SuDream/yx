import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import  'package:get/get.dart';
import 'package:yx_flutter/Class/i18n/translation.dart';

import 'Class/Crowdfunding/pages/crowdfunding.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        // initialBinding: AllGlobalCtrBinding(),
        // theme: ThemeData(primaryColor: ColorsUtils.main_color),
        home:const CrowdfundingPage(),
        debugShowCheckedModeBanner: false,
        popGesture: true,
        transitionDuration: const Duration(milliseconds: 450),
        defaultTransition: Transition.cupertino,
        // onGenerateRoute: Application.router.generator,
        // navigatorKey: Application.navigatorKey,
        // navigatorObservers: [Application.routeObserver],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: Translation.getLocalLanguage(), //进来时配置
        translations: Translation(), //国际化表
        fallbackLocale: Translation.fallback, // 错误情况下
        supportedLocales: Translation.supported,
        builder: (context, child) {
          return Overlay(
            initialEntries: [
              if (child != null) ...[
                OverlayEntry(
                  builder: (context) => MediaQuery(
                    /// 保证文字大小不受手机系统设置影响 https://www.kikt.top/posts/flutter/layout/dynamic-text/
                    data: MediaQuery.of(context).copyWith(
                        textScaleFactor:
                            1.0), // 或者 MediaQueryData.fromWindow(WidgetsBinding.instance.window).copyWith(textScaleFactor: 1.0),
                    child: child,
                  ),
                ),
              ],
            ],
          );
        });
  }
}
