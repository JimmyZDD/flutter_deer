/*
 * @Author: zdd
 * @Date: 2023-04-11 21:39:14
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-19 22:43:12
 * @FilePath: /flutter_deer/lib/routes/app_pages.dart
 * @Description: 
 */
import 'package:flutter_deer/setting/about_page.dart';
import 'package:flutter_deer/setting/account_manager_page.dart';
import 'package:flutter_deer/setting/locale_page.dart';
import 'package:flutter_deer/setting/theme_page.dart';
import 'package:get/get.dart';

import '../goods/bindings/goods_binding.dart';
import '../goods/goods_page.dart';
import '../setting/setting_page.dart';
import '../shop/bindings/shop_binding.dart';
import '../shop/shop_page.dart';
import '../home/bindings/home_binding.dart';
import '../home/home_page.dart';
import '../home/splash_page.dart';
import '../login/page/login_page.dart';
import '../login/page/register_page.dart';
import '../order/bindings/order_binding.dart';
import '../order/order_page.dart';
import '../pages/not_found_page.dart';
import '../shop/shop_setting_page.dart';

/*
 * @Author: zdd
 * @Date: 2023-04-04 09:39:13
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-11 21:41:56
 * @FilePath: /flutter_deer/lib/routes/app_pages.dart
 * @Description: 
 */

part 'app_routes.dart';

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
    GetPage(
      name: _Paths.HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ORDER,
      page: () => const OrderPage(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: _Paths.GOODS,
      page: () => const GoodsPage(),
      binding: GoodsBinding(),
    ),
    GetPage(
      name: _Paths.SHOP,
      page: () => const ShopPage(),
      binding: ShopBinding(),
    ),
    GetPage(
      name: _Paths.SHOP_SETTING,
      page: () => const ShopSettingPage(),
    ),
    GetPage(
      name: _Paths.SETTING_PAGE,
      page: () => const SettingPage(),
    ),
    GetPage(
      name: _Paths.ACCOUNT_MANAGER,
      page: () => const AccountManagerPage(),
    ),
    GetPage(
      name: _Paths.THEME_PAGE,
      page: () => const ThemePage(),
    ),
    GetPage(
      name: _Paths.LOCALE_PAGE,
      page: () => const LocalePage(),
    ),
    GetPage(
      name: _Paths.ABOUT_PAGE,
      page: () => const AboutPage(),
    ),
  ];

  static final unknownRoute = GetPage(
    name: Routes.notFound,
    page: () => const NotFoundPage(),
  );
}
