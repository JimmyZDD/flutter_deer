/*
 * @Author: zdd
 * @Date: 2023-04-17 13:00:04
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-20 22:19:54
 * @FilePath: /flutter_deer/packages/gen_cli/lib/commands/impl/generate/swagger2api.dart
 * @Description: 
 */
import 'dart:io';

import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

import '../../../common/utils/log_utils.dart';
import '../../../exception_handler/exceptions/cli_exception.dart';
import '../../../gen_cli.dart';
import '../../interface/command.dart';
import 'swagger_parser.dart';

class SwaggerGenerateCommand extends Command {
  @override
  String? get hint => 'swagger.json 生成 models apis';

  @override
  String get commandName => 'swagger2api';

  @override
  List<String> get alias => ['-s2a'];

  @override
  int get maxParameters => 2;

  @override
  String get codeSample => 'gen_cli _g swagger2api [OPTINAL PARAMETERS] \n'
      '${'可选参数: %s'.trArgs(['[dir, jsonPath]'])} ';

  @override
  Future<void> execute() async {
    LogService.info('Model generate start …');
    final config = ModelGenConfig(dirArgument, jsonPathArgument);
    await config.getDirArgument();
    final generator =
        SwaggerParser(swaggerUrl: config.jsonPath, outputDir: config.dir);
    await generator.generate();
    LogService.success('Model generate done …');
  }
}

class ModelGenConfig {
  String _dirArgument = '';
  String _jsonPath = '';

  String get dir {
    var dir = _dirArgument.isEmpty ? 'output' : _dirArgument;
    return dir.startsWith('/')
        ? join(Directory.current.path, dir.replaceFirst('/', ''))
        : join(Directory.current.path, 'lib', dir);
  }

  String get jsonPath {
    if (_jsonPath.isEmpty) {
      var codeSample =
          'gen_cli generate model jsonPath assets/models/user.json';
      throw CliException('%s 不是个有效的json文件'.trArgs(['']),
          codeSample: codeSample);
    }
    return _jsonPath;
  }

  ModelGenConfig(String dirArgument, String jsonPath) {
    if (dirArgument.isNotEmpty) {
      _dirArgument = dirArgument;
    }
    if (jsonPath.isNotEmpty) {
      _jsonPath = jsonPath;
    }
  }

  Future<void> getDirArgument() async {
    if (_dirArgument.isNotEmpty && _jsonPath.isNotEmpty) return;
    var projectFile = Directory.current.path;
    try {
      var file = File(join(projectFile, '.gen_config.yaml'));
      if (file.existsSync()) {
        var text = loadYaml(await file.readAsString());
        if (_dirArgument.isEmpty && text['outputDir'] != null) {
          _dirArgument = text['outputDir'];
        }
        if (_jsonPath.isEmpty && text['jsonPath'] != null) {
          _jsonPath = text['jsonPath'];
        }
      }

      file = File(join(projectFile, 'pubspec.yaml'));
      var text = loadYaml(await file.readAsString());
      if (_dirArgument.isEmpty && text?['gen_cli']?['outputDir'] != null) {
        _dirArgument = text['gen_cli']['outputDir'];
      }
      if (_jsonPath.isEmpty && text?['gen_cli']?['jsonPath'] != null) {
        _jsonPath = text['gen_cli']['jsonPath'];
      }
    } on Exception catch (e) {
      LogService.error(e.toString());
    }
  }

  @override
  String toString() {
    return '{dirArgument: $dir, jsonPath: $jsonPath}';
  }
}
