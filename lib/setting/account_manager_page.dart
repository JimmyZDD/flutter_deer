/*
 * @Author: zdd
 * @Date: 2023-04-19 22:20:51
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-19 22:23:26
 * @FilePath: /flutter_deer/lib/setting/account_manager_page.dart
 * @Description: 
 */
import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

/// design/8设置/index.html#artboard1
class AccountManagerPage extends StatefulWidget {
  const AccountManagerPage({super.key});

  @override
  State<AccountManagerPage> createState() => _AccountManagerPageState();
}

class _AccountManagerPageState extends State<AccountManagerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: '账号管理',
      ),
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClickItem(title: '店铺logo', onTap: () {}),
              const Positioned(
                top: 8.0,
                bottom: 8.0,
                right: 40.0,
                child: LoadAssetImage('shop/tx', width: 34.0),
              )
            ],
          ),
          ClickItem(
              title: '修改密码',
              content: '用于密码登录',
              onTap: () {
                // NavigatorUtils.push(context, LoginRouter.updatePasswordPage);
              }),
          const ClickItem(
            title: '绑定账号',
            content: '15000000000',
          ),
        ],
      ),
    );
  }
}
