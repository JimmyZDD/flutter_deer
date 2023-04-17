/*
 * @Author: zdd
 * @Date: 2023-04-17 12:07:43
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-17 22:18:35
 * @FilePath: /flutter_deer/packages/gen_cli/lib/functions/version/version_update.dart
 * @Description: 
 */
import 'dart:io';

import 'package:gen_cli/extensions/string.dart';
import 'package:version/version.dart';

import '../../cli_config/cli_config.dart';
import '../../common/utils/log_utils.dart';
import '../../common/utils/pub_dev_api.dart';
import '../../common/utils/pubspec/pubspec_lock.dart';
import 'check_dev_version.dart';
import 'print_gen_cli.dart';

void checkForUpdate() async {
  if (!CliConfig.updateIsCheckingToday()) {
    if (!isDevVersion()) {
      await PubDevApi.getLatestVersionFromPackage('gen_cli')
          .then((versionInPubDev) async {
        await PubspecLock.getVersionCli(disableLog: true)
            .then((versionInstalled) async {
          if (versionInstalled == null) exit(2);

          final v1 = Version.parse(versionInPubDev!);
          final v2 = Version.parse(versionInstalled);
          final needsUpdate = v1.compareTo(v2);
          // needs update.
          if (needsUpdate == 1) {
            LogService.info('新版本可用！当前版本: %s'.trArgs([versionInstalled]));
            //await versionCommand();
            printGetCli();
            final String codeSample = LogService.code('get update');
            LogService.info(
                '${'新版本可用: %s 运行:'.trArgs([versionInPubDev])}${' $codeSample'}',
                false,
                true);
          }
        });
      });
      CliConfig.setUpdateCheckToday();
    }
  }
}
