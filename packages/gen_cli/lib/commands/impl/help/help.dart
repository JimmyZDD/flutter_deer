/*
 * @Author: zdd
 * @Date: 2023-04-17 13:00:04
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-20 22:19:16
 * @FilePath: /flutter_deer/packages/gen_cli/lib/commands/impl/help/help.dart
 * @Description: 
 */
import '../../../common/utils/log_utils.dart';
import '../../commands_list.dart';
import '../../interface/command.dart';

class HelpCommand extends Command {
  @override
  String get commandName => 'help';

  @override
  List<String> get alias => ['-h'];

  @override
  String? get hint => '显示本帮助';

  @override
  Future<void> execute() async {
    final commandsHelp = _getCommandsHelp(commands, 0);
    LogService.info('''
List available commands:
$commandsHelp
''');
  }

  String _getCommandsHelp(List<Command> commands, int index) {
    commands.sort((a, b) {
      if (a.commandName.startsWith('-') || b.commandName.startsWith('-')) {
        return b.commandName.compareTo(a.commandName);
      }
      return a.commandName.compareTo(b.commandName);
    });
    var result = '';
    for (var command in commands) {
      result += '\n ${'  ' * index} ${command.commandName}:  ${command.hint}';
      result += _getCommandsHelp(command.childrens, index + 1);
    }
    return result;
  }

  @override
  String get codeSample => '';

  @override
  int get maxParameters => 0;
}
