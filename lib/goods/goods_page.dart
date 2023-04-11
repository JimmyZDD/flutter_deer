/*
 * @Author: zdd
 * @Date: 2023-04-11 21:47:46
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-11 21:49:28
 * @FilePath: /flutter_deer/lib/goods/goods_page.dart
 * @Description: 
 */
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/goods_controller.dart';

class GoodsPage extends GetView<GoodsController> {
  const GoodsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GoodsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'GoodsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
