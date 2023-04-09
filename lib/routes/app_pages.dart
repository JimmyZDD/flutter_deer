/*
 * @Author: zdd
 * @Date: 2023-04-04 09:39:13
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-09 22:13:29
 * @FilePath: /flutter_deer/lib/routes/app_pages.dart
 * @Description: 
 */
import 'package:get/get.dart';

import '../login/page/login_page.dart';
import '../login/page/register_page.dart';
import '../pages/not_found_page.dart';
import '../home/splash_page.dart';

abstract class Routes {
  static const notFound = '/notfound';
  static const demoPage = '/demo';
  static const splashPage = '/splashPage';

  static const loginPage = '/login';
  static const registerPage = '/login/register';
  static const resetPasswordPage = '/xlogin/resetPassword';
  Routes._();
}

class AppPages {
  AppPages._();

  static const initial = Routes.splashPage;

  static final List<GetPage> routes = [
    // 嵌套导航
    GetPage(name: Routes.loginPage, page: () => const LoginPage()),
    GetPage(name: Routes.registerPage, page: () => const RegisterPage()),
    GetPage(name: Routes.splashPage, page: () => const SplashPage()),
    // GetPage(
    //   name: "${Routes.EQUIPMENTS}/${Routes.PRODUCT_DETAILS}",
    //   page: () => EquipmentDetailsView(),
    //   binding: EquipmentDetailsBinding(),
    // ),
  ];

  static final unknownRoute = GetPage(
    name: Routes.notFound,
    page: () => const NotFoundPage(),
  );
}
