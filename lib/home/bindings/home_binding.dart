/*
 * @Author: zdd
 * @Date: 2023-04-11 21:39:41
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-12 22:41:53
 * @FilePath: /flutter_deer/lib/home/bindings/home_binding.dart
 * @Description: 
 */
import 'package:flutter_deer/order/controllers/order_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(
      () => OrderController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
