/*
 * @Author: zdd
 * @Date: 2023-04-17 12:07:43
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-17 22:38:11
 * @FilePath: /flutter_deer/packages/gen_cli/lib/functions/version/check_dev_version.dart
 * @Description: 
 */
import 'dart:io';

import 'package:path/path.dart';

bool isDevVersion() {
  var scriptFile = Platform.script.toFilePath();
  return basename(scriptFile).startsWith('gen_cli.dart');
}
