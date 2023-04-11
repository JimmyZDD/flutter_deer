/*
 * @Author: zdd
 * @Date: 2023-04-11 21:39:41
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-11 21:56:35
 * @FilePath: /flutter_deer/lib/home/controllers/home_controller.dart
 * @Description: 
 */
import 'package:get/get.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  final selectIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
    selectIndex.value = 0;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
