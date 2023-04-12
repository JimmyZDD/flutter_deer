/*
 * @Author: zdd
 * @Date: 2023-04-12 22:35:32
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-12 22:37:53
 * @FilePath: /flutter_deer/lib/order/widgets/order_tag_item.dart
 * @Description: 
 */
import 'package:flutter/material.dart';
import 'package:utils/res/gaps.dart';
import 'package:utils/theme/theme_utils.dart';
import 'package:widgets/widgets.dart';

class OrderTagItem extends StatelessWidget {
  const OrderTagItem({
    super.key,
    required this.date,
    required this.orderTotal,
  });

  final String date;
  final int orderTotal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: MyCard(
          child: Container(
        height: 34.0,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: <Widget>[
            if (context.isDark)
              const LoadAssetImage('order/icon_calendar_dark',
                  width: 14.0, height: 14.0)
            else
              const LoadAssetImage('order/icon_calendar',
                  width: 14.0, height: 14.0),
            Gaps.hGap10,
            Text(date),
            const Expanded(child: Gaps.empty),
            Text('$orderTotal单')
          ],
        ),
      )),
    );
  }
}
