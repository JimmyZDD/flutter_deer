/*
 * @Author: zdd
 * @Date: 2023-04-09 15:45:18
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-09 21:07:51
 * @FilePath: /flutter_deer/packages/widgets/lib/src/my_card.dart
 * @Description: 
 */
import 'package:flutter/material.dart';
import 'package:utils/res/colors.dart';
import 'package:utils/utils.dart';

class MyCard extends StatelessWidget {
  const MyCard({super.key, required this.child, this.color, this.shadowColor});

  final Widget child;
  final Color? color;
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;

    final Color backgroundColor =
        color ?? (isDark ? Colours.dark_bg_gray_ : Colors.white);
    final Color sColor =
        isDark ? Colors.transparent : (shadowColor ?? const Color(0x80DCE7FA));

    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: sColor, offset: const Offset(0.0, 2.0), blurRadius: 8.0),
        ],
      ),
      child: child,
    );
  }
}
