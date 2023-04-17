/*
 * @Author: zdd
 * @Date: 2023-04-17 13:00:04
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-17 13:01:56
 * @FilePath: /flutter_deer/packages/gen_cli/lib/commands/interface/command.dart
 * @Description: 
 */
import 'package:gen_cli/extensions.dart';

import '../../common/utils/log_utils.dart';
import '../../core/generator.dart';
import '../../exception_handler/exceptions/cli_exception.dart';
import '../impl/args_mixin.dart';

abstract class Command with ArgsMixin {
  Command() {
    while (
        ((args.contains(commandName) || args.contains('$commandName:$name'))) &&
            args.isNotEmpty) {
      args.removeAt(0);
    }
    if (args.isNotEmpty && args.first == name) {
      args.removeAt(0);
    }
  }
  int get maxParameters;

  //int get minParameters;

  String? get codeSample;
  String get commandName;

  List<String> get alias => [];

  List<String> get acceptedFlags => [];

  /// hint for command line
  String? get hint;

  /// validate command line arguments
  bool validate() {
    if (GenCli.arguments.contains(commandName) ||
        GenCli.arguments.contains('$commandName:$name')) {
      var flagsNotAceppts = flags;
      flagsNotAceppts.removeWhere((element) => acceptedFlags.contains(element));
      if (flagsNotAceppts.isNotEmpty) {
        LogService.info('%s 是多余的'.trArgsPlural(
          '%s 是多余的',
          flagsNotAceppts.length,
          [flagsNotAceppts.toString()],
        )!);
      }

      if (args.length > maxParameters) {
        List pars = args.skip(maxParameters).toList();
        throw CliException(
            '参数 %s 是多余的'.trArgsPlural(
              '参数 %s 是多余的',
              pars.length,
              [pars.toString()],
            ),
            codeSample: codeSample);
      }
    }
    return true;
  }

  /// execute command
  Future<void> execute();

  /// childrens command
  List<Command> get childrens => [];
}
