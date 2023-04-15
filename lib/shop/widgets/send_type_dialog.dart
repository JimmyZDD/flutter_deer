/*
 * @Author: zdd
 * @Date: 2023-04-15 23:08:12
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-15 23:08:28
 * @FilePath: /flutter_deer/lib/shop/widgets/send_type_dialog.dart
 * @Description: 
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utils/utils.dart';
import 'package:widgets/widgets.dart';

/// design/7店铺-店铺配置/index.html#artboard9
class SendTypeDialog extends StatefulWidget {
  const SendTypeDialog({
    super.key,
    required this.onPressed,
  });

  final Function(int, String) onPressed;

  @override
  State<SendTypeDialog> createState() => _SendTypeDialog();
}

class _SendTypeDialog extends State<SendTypeDialog> {
  int _value = 0;
  final _list = ['运费满免配置', '运费比例配置'];

  Widget _buildItem(int index) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        child: SizedBox(
          height: 42.0,
          child: Row(
            children: <Widget>[
              Gaps.hGap16,
              Expanded(
                child: Text(
                  _list[index],
                  style: _value == index
                      ? TextStyle(
                          fontSize: Dimens.font_sp14,
                          color: Theme.of(context).primaryColor,
                        )
                      : null,
                ),
              ),
              Visibility(
                  visible: _value == index,
                  child: const LoadAssetImage('order/ic_check',
                      width: 16.0, height: 16.0)),
              Gaps.hGap16,
            ],
          ),
        ),
        onTap: () {
          if (mounted) {
            setState(() {
              _value = index;
            });
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: '运费配置',
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: List.generate(_list.length, (i) => _buildItem(i))),
      onPressed: () {
        Get.back();
        widget.onPressed(_value, _list[_value]);
      },
    );
  }
}
