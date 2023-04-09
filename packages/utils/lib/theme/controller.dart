/*
 * @Author: zdd
 * @Date: 2023-04-09 20:54:07
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-09 23:23:44
 * @FilePath: /flutter_deer/packages/utils/lib/theme/Controller.dart
 * @Description: 
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';
import 'package:utils/util/other_utils.dart';
import '../res/constant.dart';
import 'theme.dart';

extension ThemeModeExtension on ThemeMode {
  String get value => <String>['System', 'Light', 'Dark'][index];
}

class ThemeController extends GetxController {
  static ThemeController get i => Get.find();

  final theme = 'System'.obs;

  get themeVal => getThemeMode();

  void syncTheme() {
    final String theme = SpUtil.getString(Constant.theme).nullSafe;
    if (theme.isNotEmpty && theme != ThemeMode.system.value) {
      // notifyListeners();
    }
  }

  void setTheme(ThemeMode themeMode) {
    theme.value = themeMode.value;
    SpUtil.putString(Constant.theme, themeMode.value);
    // notifyListeners();
  }

  ThemeMode getThemeMode() {
    final String theme = SpUtil.getString(Constant.theme).nullSafe;
    switch (theme) {
      case 'Dark':
        return ThemeMode.dark;
      case 'Light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  ThemeModel get themeModel =>
      ThemeModel.themes.firstWhere((element) => element.name == theme.value,
          orElse: () => ThemeModel.themes.first);
}
