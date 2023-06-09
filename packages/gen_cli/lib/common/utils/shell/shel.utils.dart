/*
 * @Author: zdd
 * @Date: 2023-04-17 12:59:05
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-20 14:10:02
 * @FilePath: /flutter_deer/packages/gen_cli/lib/common/utils/shell/shel.utils.dart
 * @Description: 
 */
import 'dart:io';

import 'package:process_run/shell_run.dart';

import '../../../core/generator.dart';
import '../log_utils.dart';
import '../pub_dev_api.dart';
import '../pubspec/pubspec_lock.dart';

class ShellUtils {
  static Future<void> update(
      [bool isGit = false, bool forceUpdate = false]) async {
    isGit = GenCli.arguments.contains('--git');
    forceUpdate = GenCli.arguments.contains('-f');
    if (!isGit && !forceUpdate) {
      var versionInPubDev =
          await PubDevApi.getLatestVersionFromPackage('gen_cli');

      var versionInstalled = await PubspecLock.getVersionCli(disableLog: true);

      if (versionInstalled == versionInPubDev) {
        return LogService.info('您已安装 gen_cli 最新版本');
      }
    }

    LogService.info('Upgrading gen_cli …');

    try {
      if (Platform.script.path.contains('flutter')) {
        if (isGit) {
          await run(
              'flutter pub global activate -sgit https://github.com/jonataslaw/gen_cli/',
              verbose: true);
        } else {
          await run('flutter pub global activate gen_cli', verbose: true);
        }
      } else {
        if (isGit) {
          await run(
              'flutter pub global activate -sgit https://github.com/jonataslaw/gen_cli/',
              verbose: true);
        } else {
          await run('flutter pub global activate gen_cli', verbose: true);
        }
      }
      return LogService.success('升级完成');
    } on Exception catch (err) {
      LogService.info(err.toString());
      return LogService.error('升级 gen_cli 错误');
    }
  }
}
