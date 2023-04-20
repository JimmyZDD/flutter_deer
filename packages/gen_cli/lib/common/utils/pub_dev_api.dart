/*
 * @Author: zdd
 * @Date: 2023-04-17 12:02:02
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-20 10:33:17
 * @FilePath: /flutter_deer/packages/gen_cli/lib/common/utils/pub_dev_api.dart
 * @Description: 
 */
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

import '../../extensions/string.dart';
import 'log_utils.dart';

class PubDevApi {
  static Future<String?> getLatestVersionFromPackage(String package) async {
    final languageCode = Platform.localeName.split('_')[0];
    final pubSite = languageCode.startsWith('zh')
        ? 'https://pub.flutter-io.cn/api/packages/$package'
        : 'https://pub.dev/api/packages/$package';
    var uri = Uri.parse(pubSite);
    try {
      var value = await get(uri);
      if (value.statusCode == 200) {
        final version = json.decode(value.body)['latest']['version'] as String?;
        return version;
      } else if (value.statusCode == 404) {
        LogService.info(
          '依赖: %s 在 pub.dev 中没有找到'.trArgs([package]),
          false,
          false,
        );
      }
      return null;
    } on Exception catch (err) {
      LogService.error(err.toString());
      return null;
    }
  }
}
