// ignore_for_file: constant_identifier_names

/*
 * @Author: zdd
 * @Date: 2023-04-11 21:39:41
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-19 22:43:01
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
  static const SETTING_PAGE = _Paths.SETTING_PAGE;
  static const SHOP_SETTING = _Paths.SHOP_SETTING;
  static const ACCOUNT_MANAGER = _Paths.ACCOUNT_MANAGER;
  static const THEME_PAGE = _Paths.THEME_PAGE;
  static const LOCALE_PAGE = _Paths.LOCALE_PAGE;
  static const ABOUT_PAGE = _Paths.ABOUT_PAGE;

  static const SHOP_INPUT_TEXT_PAGE = _Paths.SHOP_INPUT_TEXT_PAGE;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const ORDER = '/order';
  static const GOODS = '/goods';
  static const SHOP = '/shop';
  static const SHOP_SETTING = '/shop_setting';
  static const SETTING_PAGE = '/setting';
  static const ACCOUNT_MANAGER = '/account_manager';
  static const THEME_PAGE = '/theme_page';
  static const LOCALE_PAGE = '/locale_page';
  static const ABOUT_PAGE = '/about_page';

  static const SHOP_INPUT_TEXT_PAGE = '/shop_input_text_page';
}
