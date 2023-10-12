import 'package:flutter/cupertino.dart';
import 'package:get/route_manager.dart';
import 'package:sp_util/sp_util.dart';

import 'en_us.dart';
import 'zh_cn.dart';

class Translation extends Translations {
  static const Iterable<Locale> supported = [
    Locale('en', 'US'),
    Locale('zh', 'CN'),
  ];
  static const Locale fallback = Locale('zh', 'CN');

  static setLocallanguage(Locale lan) {
    Get.updateLocale(lan);
    SpUtil.putString('LocalLanguage', lan.languageCode);
  }

  static Locale? getLocalLanguage() {
    var LocalLanguage = SpUtil.getString('LocalLanguage');
    if (LocalLanguage?.isEmpty ?? true) {
      // return     Get.deviceLocale;
      return  Locale('zh', 'CN');
    } else {
      Locale endLocale = supported
          .where((element) => element.languageCode == LocalLanguage)
          .first;
      return endLocale;
    }
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en': enUS,
        'zh': zhCN,
      };
}
