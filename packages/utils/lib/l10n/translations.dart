/*
 * @Author: zdd
 * @Date: 2023-04-06 10:14:10
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-21 23:32:27
 * @FilePath: /flutter_deer/packages/utils/lib/l10n/translations.dart
 * @Description: 
 */
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sp_util/sp_util.dart';

import '../utils.dart';
import 'translations/en.dart';
import 'translations/zh_cn.dart';

const localMap = {'zh': Locale('zh', 'CN'), 'en': Locale('en', 'US')};

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'zh_CN': zhCN,
      };

  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('zh', 'CN'),
  ];

  static const fallbackLocale = Locale('en', 'US');

  static void syncLocale() {
    final String localeName = SpUtil.getString(Constant.locale) ?? '';
    var locale = localMap.keys.contains(localeName)
        ? localMap[localeName]
        : const Locale('en', 'US');
    Get.updateLocale(locale!);
  }

  static setLocale(String localeName) {
    if (localMap[localeName] != null) {
      Get.updateLocale(localMap[localeName]!);
      SpUtil.putString(Constant.locale, localeName);
    }
  }

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];
}
