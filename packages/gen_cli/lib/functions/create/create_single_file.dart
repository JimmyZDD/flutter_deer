/*
 * @Author: zdd
 * @Date: 2023-04-20 14:38:25
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-20 22:20:50
 * @FilePath: /flutter_deer/packages/gen_cli/lib/functions/create/create_single_file.dart
 * @Description: 
 */

import 'dart:io';
import 'package:gen_cli/common/utils/log_utils.dart';

import '../../common/menu/menu.dart';

Future<void> generateFile(File file, String content) async {
  file.path;
  var outputDir = file.path.split('/')..removeLast();
  final dir = Directory(outputDir.join('/'));
  if (!dir.existsSync()) {
    dir.createSync(recursive: true);
  }
  if (file.existsSync()) {
    final overwriteMenu = Menu([
      'yes',
      'no',
    ], title: '文件已存在是否复写(${file.path.split('/').removeLast()})');

    final overwriteResult = overwriteMenu.choose();
    if (overwriteResult.index == 1) {
      LogService.error('文件生成取消');
      return;
    }
  }
  await file.create(recursive: true);
  await file.writeAsString(content);
}
