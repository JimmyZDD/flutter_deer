/*
 * @Author: zdd
 * @Date: 2023-04-06 10:14:10
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-09 20:50:46
 * @FilePath: /flutter_deer/packages/utils/lib/l10n/translations.dart
 * @Description: 
 */
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'translations/en.dart';
import 'translations/zh_cn.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'zh_CN': zhCN,
      };

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('zh', 'CN'),
  ];

  static const fallbackLocale = Locale('en');

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];
}
