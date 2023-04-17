/*
 * @Author: zdd
 * @Date: 2023-04-17 10:06:40
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-17 22:05:36
 * @FilePath: /flutter_deer/packages/gen_cli/bin/gen_cli.dart
 * @Description: 
 */
import 'package:gen_cli/common/utils/log_utils.dart';
import 'package:gen_cli/core/generator.dart';
import 'package:gen_cli/exception_handler/exception_handler.dart';
import 'package:gen_cli/functions/version/version_update.dart';

Future<void> main(List<String> arguments) async {
  var time = Stopwatch();
  time.start();
  final command = GenCli(arguments).findCommand();

  if (arguments.contains('--debug')) {
    if (command.validate()) {
      await command.execute().then((value) => checkForUpdate());
    }
  } else {
    try {
      if (command.validate()) {
        await command.execute().then((value) => checkForUpdate());
      }
    } on Exception catch (e) {
      ExceptionHandler().handle(e);
    }
  }
  time.stop();
  LogService.info('Time: ${time.elapsed.inMilliseconds} Milliseconds');
}

/* void main(List<String> arguments) {
 Core core = Core();
  core
      .generate(arguments: List.from(arguments))
      .then((value) => checkForUpdate()); 
} */
