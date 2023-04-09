/*
 * @Author: zdd
 * @Date: 2023-04-09 15:45:18
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-09 16:05:16
 * @FilePath: /flutter_deer/packages/widgets/lib/src/selected_item.dart
 * @Description: 
 */
import 'package:flutter/material.dart';
import 'package:utils/res/resources.dart';

import 'click_item.dart';

class SelectedItem extends StatelessWidget {
  const SelectedItem(
      {super.key,
      this.onTap,
      required this.title,
      this.content = '',
      this.textAlign = TextAlign.start,
      this.style});

  final GestureTapCallback? onTap;
  final String title;
  final String content;
  final TextAlign textAlign;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50.0,
        margin: const EdgeInsets.only(right: 8.0, left: 16.0),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            bottom: Divider.createBorderSide(context, width: 0.6),
          ),
        ),
        child: Row(
          children: <Widget>[
            Text(title),
            Gaps.hGap16,
            Expanded(
              child: Text(content,
                  maxLines: 2,
                  textAlign: textAlign,
                  overflow: TextOverflow.ellipsis,
                  style: style),
            ),
            Gaps.hGap8,
            arrowRight
          ],
        ),
      ),
    );
  }
}
