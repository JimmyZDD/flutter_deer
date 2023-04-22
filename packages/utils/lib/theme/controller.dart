/*
 * @Author: zdd
 * @Date: 2023-04-09 20:54:07
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-22 07:59:44
 * @FilePath: /flutter_deer/packages/utils/lib/theme/controller.dart
 * @Description: 
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';
import 'package:utils/util/other_utils.dart';
import '../l10n/translations.dart';
import '../res/constant.dart';
import 'theme.dart';

extension ThemeModeExtension on ThemeMode {
  String get value => <String>['System', 'Light', 'Dark'][index];
}

const themeMap = {
  'Dark': ThemeMode.dark,
  'Light': ThemeMode.light,
  'System': ThemeMode.system
};

class ThemeController extends GetxController {
  static ThemeController get i => Get.find();

  final theme = 'System'.obs;

  get themeVal => getThemeMode();

  @override
  void onReady() {
    super.onReady();
    syncTheme();
    AppTranslations.syncLocale();
  }

  void syncTheme() {
    final String theme = SpUtil.getString(Constant.theme).nullSafe;
    if (theme.isNotEmpty &&
        theme != ThemeMode.system.value &&
        themeMap.keys.contains(theme)) {
      Get.changeThemeMode(themeMap[theme]!);
    }
  }

  void setTheme(ThemeMode themeMode) {
    theme.value = themeMode.value;
    SpUtil.putString(Constant.theme, themeMode.value);
    Get.changeThemeMode(themeMode);
  }

  ThemeMode getThemeMode() {
    final String theme = SpUtil.getString(Constant.theme).nullSafe;
    if (!themeMap.keys.contains(theme)) {
      return ThemeMode.system;
    }
    return themeMap[theme]!;
  }

  ThemeModel get themeModel =>
      ThemeModel.themes.firstWhere((element) => element.name == theme.value,
          orElse: () => ThemeModel.themes.first);
}
