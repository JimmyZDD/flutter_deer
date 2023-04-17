/*
 * @Author: zdd
 * @Date: 2023-04-17 13:00:04
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-17 22:38:50
 * @FilePath: /flutter_deer/packages/gen_cli/lib/commands/impl/version/version.dart
 * @Description: 
 */
import '../../../common/utils/log_utils.dart';
import '../../../common/utils/pubspec/pubspec_lock.dart';
import '../../../functions/version/print_gen_cli.dart';
import '../../interface/command.dart';

// ignore_for_file: avoid_print

class VersionCommand extends Command {
  @override
  String get commandName => '--version';

  @override
  Future<void> execute() async {
    var version = await PubspecLock.getVersionCli();
    if (version == null) return;
    printGetCli();
    print('Version: $version');
  }

  @override
  String? get hint => '显示当前 CLI 版本';

  @override
  List<String> get alias => ['-v'];

  @override
  bool validate() {
    super.validate();

    return true;
  }

  @override
  String get codeSample => 'gen_cli --version';

  @override
  int get maxParameters => 0;
}
