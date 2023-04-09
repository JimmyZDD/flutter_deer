/*
 * @Author: zdd
 * @Date: 2023-04-09 20:56:15
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-09 20:56:43
 * @FilePath: /flutter_deer/lib/home/bindings/app.dart
 * @Description: 
 */
import 'package:get/get.dart';
import 'package:utils/utils.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController(), permanent: true);
  }
}
