/*
 * @Author: zdd
 * @Date: 2023-04-17 11:55:18
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-17 12:03:12
 * @FilePath: /flutter_deer/packages/gen_cli/lib/exception_handler/exception_handler.dart
 * @Description: 
 */
import 'dart:io';

import '../extensions/string.dart';
import '../common/utils/log_utils.dart';
import 'exceptions/cli_exception.dart';

class ExceptionHandler {
  void handle(dynamic e) {
    if (e is CliException) {
      LogService.error(e.message!);
      if (e.codeSample!.isNotEmpty) {
        LogService.info('例:', false, false);
        // ignore: avoid_print
        print(LogService.codeBold(e.codeSample!));
      }
    } else if (e is FileSystemException) {
      if (e.osError!.errorCode == 2) {
        LogService.error('在 %s 中没有找到文件'.trArgs([e.path]));
        return;
      } else if (e.osError!.errorCode == 13) {
        LogService.error('对 %s 的访问被拒绝'.trArgs([e.path]));
        return;
      }
      _logException(e.message);
    } else {
      _logException(e.toString());
    }
    if (!Platform.isWindows) exit(0);
  }

  static void _logException(String msg) {
    LogService.error('发生意外错误: $msg');
  }
}
