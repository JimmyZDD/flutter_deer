import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../res/colors.dart';
import '../res/styles.dart';
import '../util/web_page_transitions.dart';

class ThemeModel {
  final String name;
  final Color? color;
  final ThemeMode? mode;
  final IconData? icon;

  const ThemeModel({
    required this.name,
    this.color,
    this.mode,
    this.icon,
  });

  static final light = generateTheme();

  static final dark = generateTheme(isDarkMode: true);

  static ThemeData generateTheme({bool isDarkMode = false}) {
    return ThemeData(
      primaryColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        secondary: isDarkMode ? Colours.dark_app_main : Colours.app_main,
        error: isDarkMode ? Colours.dark_red : Colours.red,
      ),
      // Tab指示器颜色
      indicatorColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
      // 页面背景色
      scaffoldBackgroundColor:
          isDarkMode ? Colours.dark_bg_color : Colors.white,
      // 主要用于Material背景色
      canvasColor: isDarkMode ? Colours.dark_material_bg : Colors.white,
      // 文字选择色（输入框选择文字等）
      // textSelectionColor: Colours.app_main.withAlpha(70),
      // textSelectionHandleColor: Colours.app_main,
      // 稳定版：1.23 变更(https://flutter.dev/docs/release/breaking-changes/text-selection-theme)
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: Colours.app_main.withAlpha(70),
        selectionHandleColor: Colours.app_main,
        cursorColor: Colours.app_main,
      ),
      textTheme: TextTheme(
        // TextField输入文字颜色
        titleMedium: isDarkMode ? TextStyles.textDark : TextStyles.text,
        // Text文字样式
        bodyMedium: isDarkMode ? TextStyles.textDark : TextStyles.text,
        titleSmall:
            isDarkMode ? TextStyles.textDarkGray12 : TextStyles.textGray12,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle:
            isDarkMode ? TextStyles.textHint14 : TextStyles.textDarkGray14,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        color: isDarkMode ? Colours.dark_bg_color : Colors.white,
        systemOverlayStyle:
            isDarkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      ),
      dividerTheme: DividerThemeData(
          color: isDarkMode ? Colours.dark_line : Colours.line,
          space: 0.6,
          thickness: 0.6),
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      pageTransitionsTheme: NoTransitionsOnWeb(),
      visualDensity: VisualDensity
          .standard, // https://github.com/flutter/flutter/issues/77142
    );
  }

  static final themes = [
    ThemeModel(
      name: 'System',
      mode: ThemeMode.system,
      icon: GetPlatform.isMobile ? Icons.phone_android : Icons.computer,
    ),
    const ThemeModel(
      name: 'Light',
      mode: ThemeMode.light,
      icon: Icons.light_mode,
    ),
    const ThemeModel(
      name: 'Dark',
      mode: ThemeMode.dark,
      icon: Icons.dark_mode,
    ),
    const ThemeModel(
      name: 'Blue',
      color: Colors.blue,
    ),
    const ThemeModel(
      name: 'Red',
      color: Colors.red,
    ),
    const ThemeModel(
      name: 'Pink',
      color: Colors.pink,
    ),
    const ThemeModel(
      name: 'Purple',
      color: Colors.purple,
    ),
    const ThemeModel(
      name: 'DeepPurple',
      color: Colors.deepPurple,
    ),
    const ThemeModel(
      name: 'Indigo',
      color: Colors.indigo,
    ),
    const ThemeModel(
      name: 'LightBlue',
      color: Colors.lightBlue,
    ),
    const ThemeModel(
      name: 'Cyan',
      color: Colors.cyan,
    ),
    const ThemeModel(
      name: 'Teal',
      color: Colors.teal,
    ),
    const ThemeModel(
      name: 'LightGreen',
      color: Colors.lightGreen,
    ),
    const ThemeModel(
      name: 'Lime',
      color: Colors.lime,
    ),
    const ThemeModel(
      name: 'Yellow',
      color: Colors.yellow,
    ),
    const ThemeModel(
      name: 'Amber',
      color: Colors.amber,
    ),
    const ThemeModel(
      name: 'Orange',
      color: Colors.orange,
    ),
    const ThemeModel(
      name: 'DeepOrange',
      color: Colors.deepOrange,
    ),
    const ThemeModel(
      name: 'Brown',
      color: Colors.brown,
    ),
    const ThemeModel(
      name: 'Grey',
      color: Colors.grey,
    ),
    const ThemeModel(
      name: 'BlueGrey',
      color: Colors.blueGrey,
    ),
  ];
}
