/*
 * @Author: zdd
 * @Date: 2023-04-09 15:45:18
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-09 16:02:59
 * @FilePath: /flutter_deer/packages/widgets/lib/src/progress_dialog.dart
 * @Description: 
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utils/res/resources.dart';

/// 加载中的弹框
class ProgressDialog extends Dialog {
  const ProgressDialog({
    super.key,
    this.hintText = '',
  });

  final String hintText;

  @override
  Widget build(BuildContext context) {
    final Widget progress = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Theme(
          data: ThemeData(
            cupertinoOverrideTheme: const CupertinoThemeData(
              brightness: Brightness.dark, // 局部指定夜间模式，加载圈颜色会设置为白色
            ),
          ),
          child: const CupertinoActivityIndicator(radius: 14.0),
        ),
        Gaps.vGap8,
        Text(
          hintText,
          style: const TextStyle(color: Colors.white),
        )
      ],
    );

    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          height: 88.0,
          width: 120.0,
          decoration: const ShapeDecoration(
            color: Color(0xFF3A3A3A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
          child: progress,
        ),
      ),
    );
  }
}
