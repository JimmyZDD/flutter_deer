/*
 * @Author: zdd
 * @Date: 2023-04-09 17:37:29
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-09 17:37:52
 * @FilePath: /flutter_deer/lib/pages/not_found_page.dart
 * @Description: 
 */
import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(
        centerTitle: '页面不存在',
      ),
      body: StateLayout(
        type: StateType.account,
        hintText: '页面不存在',
      ),
    );
  }
}
