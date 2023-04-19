import 'package:flutter/material.dart';
import 'package:flutter_deer/pages/demo_page.dart';
import 'package:flutter_deer/routes/app_pages.dart';
import 'package:flutter_deer/setting/widgets/exit_dialog.dart';
import 'package:flutter_deer/setting/widgets/update_dialog.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';
import 'package:utils/utils.dart';
import 'package:widgets/widgets.dart';

/// design/8设置/index.html
class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(
          centerTitle: '设置',
        ),
        body: Column(
          children: <Widget>[
            Gaps.vGap5,
            ClickItem(
              title: '账号管理',
              onTap: () {
                Get.toNamed(Routes.ACCOUNT_MANAGER);
              },
            ),
            if (Device.isMobile)
              ClickItem(
                title: '清除缓存',
                content: '23.5MB',
                onTap: () {},
              ),
            ClickItem(
              title: '夜间模式',
              content: _getCurrentTheme(),
              onTap: () {
                Get.toNamed(Routes.THEME_PAGE);
              },
            ),
            ClickItem(
              title: '多语言',
              content: _getCurrentLocale(),
              onTap: () {
                Get.toNamed(Routes.LOCALE_PAGE);
              },
            ),
            if (Device.isMobile)
              ClickItem(
                title: '检查更新',
                onTap: _showUpdateDialog,
              ),
            ClickItem(
              title: '关于我们',
              onTap: () {
                Get.toNamed(Routes.ABOUT_PAGE);
              },
            ),
            ClickItem(
              title: '退出当前账号',
              onTap: _showExitDialog,
            ),
            if (Device.isMobile)
              ClickItem(
                  title: 'Deer Web版',
                  onTap: () {
                    //     NavigatorUtils.goWebViewPage(
                    //       context,
                    //       'Flutter Deer',
                    //       'https://simplezhli.github.io/flutter_deer/'),
                    // )
                  }),
            ClickItem(
              title: '其他Demo',
              onTap: () {
                Get.to(const DemoPage());
              },
            ),
          ],
        ));
  }

  String _getCurrentTheme() {
    final String? theme = SpUtil.getString(Constant.theme);
    String themeMode;
    switch (theme) {
      case 'Dark':
        themeMode = '开启';
        break;
      case 'Light':
        themeMode = '关闭';
        break;
      default:
        themeMode = '跟随系统';
        break;
    }
    return themeMode;
  }

  String _getCurrentLocale() {
    final String? locale = SpUtil.getString(Constant.locale);
    String localeMode;
    switch (locale) {
      case 'zh':
        localeMode = '中文';
        break;
      case 'en':
        localeMode = 'English';
        break;
      default:
        localeMode = '跟随系统';
        break;
    }
    return localeMode;
  }

  void _showExitDialog() {
    showDialog<void>(context: context, builder: (_) => const ExitDialog());
  }

  void _showUpdateDialog() {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => const UpdateDialog());
  }
}
