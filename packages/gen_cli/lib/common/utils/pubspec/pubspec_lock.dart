/*
 * @Author: zdd
 * @Date: 2023-04-17 12:06:59
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-17 22:34:51
 * @FilePath: /flutter_deer/packages/gen_cli/lib/common/utils/pubspec/pubspec_lock.dart
 * @Description: 
 */
import 'dart:io';

import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

import '../../../functions/version/check_dev_version.dart';
import '../log_utils.dart';

class PubspecLock {
  static Future<String?> getVersionCli({bool disableLog = false}) async {
    try {
      var scriptFile = Platform.script.toFilePath();
      var paths = scriptFile.split('/');
      paths.removeRange(paths.length - 5, paths.length - 1);
      scriptFile = paths.join('/');
      var pathToPubLock = join(dirname(scriptFile), 'pubspec.lock');

      final file = File(pathToPubLock);
      var text = loadYaml(await file.readAsString());

      if (text['packages']['gen_cli'] == null) {
        if (isDevVersion()) {
          if (!disableLog) {
            LogService.info('Development version');
          }
        }
        return null;
      }
      var version = text['packages']['gen_cli']['version'].toString();
      return version;
    } on Exception catch (_) {
      if (!disableLog) {
        LogService.error('没有找到已安装版本。');
      }
      return null;
    }
  }
}
