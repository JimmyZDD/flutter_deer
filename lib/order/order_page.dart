/*
 * @Author: zdd
 * @Date: 2023-04-11 21:45:43
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-11 21:47:12
 * @FilePath: /flutter_deer/lib/order/order_page.dart
 * @Description: 
 */
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/order_controller.dart';

class OrderPage extends GetView<OrderController> {
  const OrderPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OrderView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'OrderView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
