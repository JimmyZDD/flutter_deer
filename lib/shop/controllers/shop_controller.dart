/*
 * @Author: zdd
 * @Date: 2023-04-11 21:48:07
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-13 22:51:41
 * @FilePath: /flutter_deer/lib/shop/controllers/shop_controller.dart
 * @Description: 
 */
import 'package:flutter_deer/shop/providers/shop_provider.dart';
import 'package:get/get.dart';
import 'package:utils/util/log_utils.dart';

import '../models/user_entity.dart';

class ShopController extends GetxController {
  ShopProvider provider;
  ShopController({required this.provider});

  final count = 0.obs;

  Rx<UserEntity> user = UserEntity().obs;
  @override
  void onInit() {
    super.onInit();
    feachUserData();
  }

  feachUserData() async {
    user.value = await provider.getUser();
    update(['user']);
  }

  void increment() => count.value++;
}
