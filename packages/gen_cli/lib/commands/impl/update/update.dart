/*
 * @Author: zdd
 * @Date: 2023-04-17 13:00:04
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-17 22:16:06
 * @FilePath: /flutter_deer/packages/gen_cli/lib/commands/impl/update/update.dart
 * @Description: 
 */
import '../../../common/utils/shell/shel.utils.dart';
import '../../interface/command.dart';

class UpdateCommand extends Command {
  @override
  String get commandName => 'update';
  @override
  List<String> get acceptedFlags => ['-f', '--git'];

  @override
  Future<void> execute() async {
    await ShellUtils.update();
  }

  @override
  String? get hint => '更新 GEN_CLI';

  @override
  List<String> get alias => ['upgrade'];

  @override
  bool validate() {
    super.validate();
    return true;
  }

  @override
  String get codeSample => 'gen_cli update';

  @override
  int get maxParameters => 0;
}
