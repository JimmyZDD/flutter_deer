/*
 * @Author: zdd
 * @Date: 2023-04-09 15:45:18
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-19 22:35:25
 * @FilePath: /flutter_deer/packages/widgets/lib/src/selected_image.dart
 * @Description: 
 */
import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class SelectedImage extends StatefulWidget {
  const SelectedImage({
    super.key,
    this.url,
    this.heroTag,
    this.size = 80.0,
  });

  final String? url;
  final String? heroTag;
  final double size;

  @override
  SelectedImageState createState() => SelectedImageState();
}

class SelectedImageState extends State<SelectedImage> {
  final ImagePicker _picker = ImagePicker();
  ImageProvider? _imageProvider;
  XFile? pickedFile;

  Future<void> _getImage() async {
    try {
      pickedFile =
          await _picker.pickImage(source: ImageSource.gallery, maxWidth: 800);
      if (pickedFile != null) {
        if (Device.isWeb) {
          _imageProvider = NetworkImage(pickedFile!.path);
        } else {
          _imageProvider = FileImage(File(pickedFile!.path));
        }
      } else {
        _imageProvider = null;
      }
      setState(() {});
    } catch (e) {
      if (e is MissingPluginException) {
        Get.defaultDialog(title: '当前平台暂不支持！');
      } else {
        Get.defaultDialog(title: '没有权限，无法打开相册！');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorFilter colorFilter = ColorFilter.mode(
        ThemeUtils.isDark(context)
            ? Colours.dark_unselected_item_color
            : Colours.text_gray,
        BlendMode.srcIn);

    Widget image = Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        // 图片圆角展示
        borderRadius: BorderRadius.circular(16.0),
        image: DecorationImage(
            image: _imageProvider ??
                ImageUtils.getImageProvider(widget.url,
                    holderImg: 'store/icon_zj'),
            fit: BoxFit.cover,
            colorFilter: _imageProvider == null && TextUtil.isEmpty(widget.url)
                ? colorFilter
                : null),
      ),
    );

    if (widget.heroTag != null && !Device.isWeb) {
      image = Hero(tag: widget.heroTag!, child: image);
    }

    return Semantics(
      label: '选择图片',
      hint: '跳转相册选择图片',
      child: InkWell(
        borderRadius: BorderRadius.circular(16.0),
        onTap: _getImage,
        child: image,
      ),
    );
  }
}
