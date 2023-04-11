/*
 * @Author: zdd
 * @Date: 2023-04-11 21:48:07
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-11 21:49:55
 * @FilePath: /flutter_deer/lib/shop/shop_page.dart
 * @Description: 
 */
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/shop_controller.dart';

class ShopPage extends GetView<ShopController> {
  const ShopPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShopView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ShopView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
