/*
 * @Author: zdd
 * @Date: 2023-04-11 21:48:07
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-13 22:36:20
 * @FilePath: /flutter_deer/lib/shop/bindings/shop_binding.dart
 * @Description: 
 */
import 'package:get/get.dart';

import '../controllers/shop_controller.dart';
import '../providers/shop_provider.dart';

class ShopBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopProvider>(
      () => ShopProvider(),
    );
    Get.lazyPut<ShopController>(
      () => ShopController(provider: Get.find()),
    );
  }
}
