/*
 * @Author: zdd
 * @Date: 2023-04-17 12:59:40
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-20 10:07:37
 * @FilePath: /flutter_deer/packages/gen_cli/lib/core/generator.dart
 * @Description: 
 */
import '../commands/commands_list.dart';
import '../commands/impl/help/help.dart';
import '../commands/interface/command.dart';
import '../common/utils/log_utils.dart';

class GenCli {
  final List<String> _arguments;

  GenCli(this._arguments) {
    _instance = this;
  }

  static GenCli? _instance;
  static GenCli? get to => _instance;

  static List<String> get arguments => to!._arguments;

  Command findCommand() => _findCommand(0, commands);

  Command _findCommand(int currentIndex, List<Command> commands) {
    try {
      final currentArgument = arguments[currentIndex].split(':').first;

      var command = commands.firstWhere(
          (command) =>
              command.commandName == currentArgument ||
              command.alias.contains(currentArgument),
          orElse: () => ErrorCommand('command not found'));
      if (command.childrens.isNotEmpty) {
        if (command is CommandParent) {
          command = _findCommand(++currentIndex, command.childrens);
        } else {
          var childrenCommand = _findCommand(++currentIndex, command.childrens);
          if (childrenCommand is! ErrorCommand) {
            command = childrenCommand;
          }
        }
      }
      return command;
      // ignore: avoid_catching_errors
    } on RangeError catch (_) {
      return HelpCommand();
    } on Exception catch (_) {
      rethrow;
    }
  }
}

class ErrorCommand extends Command {
  @override
  String get commandName => 'onerror';
  String error;
  ErrorCommand(this.error);
  @override
  Future<void> execute() async {
    LogService.error(error);
    LogService.info('run `gen_cli help` to help', false, false);
  }

  @override
  String get hint => 'Print on erro';

  @override
  String get codeSample => '';

  @override
  int get maxParameters => 0;

  @override
  bool validate() => true;
}

class NotFoundComannd extends Command {
  @override
  String get commandName => 'Not Found Comannd';

  @override
  Future<void> execute() async {
    //Command findCommand() => _findCommand(0, commands);
  }

  @override
  String get hint => 'Not Found Comannd';

  @override
  String get codeSample => '';

  @override
  int get maxParameters => 0;

  @override
  bool validate() => true;
}
