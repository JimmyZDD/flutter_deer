/*
 * @Author: zdd
 * @Date: 2023-04-11 21:39:14
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-15 22:56:25
 * @FilePath: /flutter_deer/lib/routes/app_pages.dart
 * @Description: 
 */
import 'package:get/get.dart';

import '../goods/bindings/goods_binding.dart';
import '../goods/goods_page.dart';
import '../shop/bindings/shop_binding.dart';
import '../shop/input_text_page.dart';
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
    // GetPage(
    //   name: _Paths.SHOP_INPUT_TEXT_PAGE,
    //   page: (title) => InputTextPage(
    //     title: title,
    //   ),
    // ),
  ];

  static final unknownRoute = GetPage(
    name: Routes.notFound,
    page: () => const NotFoundPage(),
  );
}
