/*
 * @Author: zdd
 * @Date: 2023-04-11 21:39:41
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-13 22:33:38
 * @FilePath: /flutter_deer/lib/home/bindings/home_binding.dart
 * @Description: 
 */
import 'package:flutter_deer/shop/providers/shop_provider.dart';
import 'package:get/get.dart';

import '../../order/controllers/order_controller.dart';
import '../../shop/controllers/shop_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(
      () => OrderController(),
    );
    Get.lazyPut<ShopProvider>(
      () => ShopProvider(),
    );
    Get.lazyPut<ShopController>(
      () => ShopController(provider: Get.find()),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
