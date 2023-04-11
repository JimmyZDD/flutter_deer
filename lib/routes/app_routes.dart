/*
 * @Author: zdd
 * @Date: 2023-04-11 21:39:41
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-11 21:41:47
 * @FilePath: /flutter_deer/lib/routes/app_routes.dart
 * @Description: 
 */
part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const notFound = '/notfound';
  static const demoPage = '/demo';
  static const splashPage = '/splashPage';

  static const loginPage = '/login';
  static const registerPage = '/login/register';
  static const resetPasswordPage = '/xlogin/resetPassword';
  static const ORDER = _Paths.ORDER;
  static const GOODS = _Paths.GOODS;
  static const SHOP = _Paths.SHOP;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const ORDER = '/order';
  static const GOODS = '/goods';
  static const SHOP = '/shop';
}
