/*
 * @Author: zdd
 * @Date: 2023-04-19 22:20:51
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-22 08:05:19
 * @FilePath: /flutter_deer/lib/setting/widgets/exit_dialog.dart
 * @Description: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_deer/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';
import 'package:utils/utils.dart';
import 'package:widgets/widgets.dart';

class ExitDialog extends StatefulWidget {
  const ExitDialog({
    super.key,
  });

  @override
  State<ExitDialog> createState() => _ExitDialog();
}

class _ExitDialog extends State<ExitDialog> {
  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: '提示',
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text('您确定要退出登录吗？', style: TextStyles.textSize16),
      ),
      onPressed: () {
        SpUtil.remove(Constant.accessToken);
        Get.offAllNamed(Routes.loginPage);
      },
    );
  }
}
