/*
 * @Author: zdd
 * @Date: 2023-04-09 16:20:00
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-19 22:37:35
 * @FilePath: /flutter_deer/lib/pages/demo_page.dart
 * @Description: 
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:utils/res/gaps.dart';
import 'package:widgets/widgets.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      /// 显示状态栏和导航栏(使用QuickActions进入demo页)
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: 'Demo',
      ),
      body: Column(
        children: const [
          Gaps.vGap5,
          ClickItem(
            title: 'Overlay',
          ),
          ClickItem(
            title: 'Focus',
          ),
          ClickItem(
            title: 'RipplesAnimation',
          ),
        ],
      ),
    );
  }
}
