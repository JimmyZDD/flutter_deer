/*
 * @Author: zdd
 * @Date: 2023-04-13 22:27:10
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-19 22:38:15
 * @FilePath: /flutter_deer/lib/shop/providers/shop_provider.dart
 * @Description: 
 */

import 'package:flutter_deer/shop/models/user_entity.dart';
import 'package:get/get.dart';

class ShopProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://api.github.com';
  }

  Future<UserEntity> getUser() async {
    final response = await get('/users/JimmyZDD');
    return UserEntity.fromJson(response.body);
  }
}
