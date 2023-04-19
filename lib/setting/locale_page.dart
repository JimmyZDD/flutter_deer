/*
 * @Author: zdd
 * @Date: 2023-04-19 22:20:51
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-19 22:24:17
 * @FilePath: /flutter_deer/lib/setting/locale_page.dart
 * @Description: 
 */
import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';
import 'package:utils/res/constant.dart';
import 'package:widgets/widgets.dart';

class LocalePage extends StatefulWidget {
  const LocalePage({super.key});

  @override
  State<LocalePage> createState() => _LocalePageState();
}

class _LocalePageState extends State<LocalePage> {
  final List<String> _list = <String>['跟随系统', '中文', 'English'];

  @override
  Widget build(BuildContext context) {
    final String? locale = SpUtil.getString(Constant.locale);
    String localeMode;
    switch (locale) {
      case 'zh':
        localeMode = _list[1];
        break;
      case 'en':
        localeMode = _list[2];
        break;
      default:
        localeMode = _list[0];
        break;
    }
    return Scaffold(
      appBar: const MyAppBar(
        title: '多语言',
      ),
      body: ListView.separated(
        itemCount: _list.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (_, int index) {
          return InkWell(
            onTap: () {
              // final String locale =
              //     index == 0 ? '' : (index == 1 ? 'zh' : 'en');
              // context.read<LocaleProvider>().setLocale(locale);
              // Toast.show('当前功能仅登录模块有效');
              // setState(() {});
            },
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              height: 50.0,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_list[index]),
                  ),
                  Opacity(
                    opacity: localeMode == _list[index] ? 1 : 0,
                    child: const Icon(Icons.done, color: Colors.blue),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
