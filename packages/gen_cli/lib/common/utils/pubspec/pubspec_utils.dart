/*
 * @Author: zdd
 * @Date: 2023-04-17 12:06:59
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-17 22:17:41
 * @FilePath: /flutter_deer/packages/gen_cli/lib/common/utils/pubspec/pubspec_utils.dart
 * @Description: 
 */
import 'dart:io';

import 'package:gen_cli/extensions.dart';
import 'package:pubspec/pubspec.dart';
import 'package:version/version.dart' as v;

import '../../../exception_handler/exceptions/cli_exception.dart';
import '../../menu/menu.dart';
import '../log_utils.dart';
import '../pub_dev_api.dart';
import '../shell/shel.utils.dart';
import 'yaml_to.string.dart';

// ignore: avoid_classes_with_only_static_members
class PubspecUtils {
  static final _pubspecFile = File('pubspec.yaml');

  static PubSpec get pubSpec =>
      PubSpec.fromYamlString(_pubspecFile.readAsStringSync());

  /// separtor
  static final _mapSep = _PubValue<String>(() {
    var yaml = pubSpec.unParsedYaml!;
    if (yaml.containsKey('gen_cli')) {
      if ((yaml['gen_cli'] as Map).containsKey('separator')) {
        return (yaml['gen_cli']['separator'] as String?) ?? '';
      }
    }

    return '';
  });

  static String? get separatorFileType => _mapSep.value;

  static final _mapName = _PubValue<String>(() => pubSpec.name?.trim() ?? '');

  static String? get projectName => _mapName.value;

  static final _extraFolder = _PubValue<bool?>(
    () {
      try {
        var yaml = pubSpec.unParsedYaml!;
        if (yaml.containsKey('gen_cli')) {
          if ((yaml['gen_cli'] as Map).containsKey('sub_folder')) {
            return (yaml['gen_cli']['sub_folder'] as bool?);
          }
        }
      } on Exception catch (_) {}
      // retorno nulo está sendo tratado
      // ignore: avoid_returning_null
      return null;
    },
  );

  static bool? get extraFolder => _extraFolder.value;

  static Future<bool> addDependencies(String package,
      {String? version, bool isDev = false, bool runPubGet = true}) async {
    var pubSpec = PubSpec.fromYamlString(_pubspecFile.readAsStringSync());

    if (containsPackage(package)) {
      LogService.info(
          'package: %s 已经安装, 你想更新它吗？'.trArgs([package]), false, false);
      final menu = Menu(
        [
          '是的!',
          '不',
        ],
      );
      final result = menu.choose();
      if (result.index != 0) {
        return false;
      }
    }

    version = version == null || version.isEmpty
        ? await PubDevApi.getLatestVersionFromPackage(package)
        : '^$version';
    if (version == null) return false;
    if (isDev) {
      pubSpec.devDependencies[package] = HostedReference.fromJson(version);
    } else {
      pubSpec.dependencies[package] = HostedReference.fromJson(version);
    }

    _savePub(pubSpec);
    if (runPubGet) await ShellUtils.pubGet();
    LogService.success('Package: %s 已安装！'.trArgs([package]));
    return true;
  }

  static void removeDependencies(String package, {bool logger = true}) {
    if (logger) LogService.info('Removing package: "$package"');

    if (containsPackage(package)) {
      var dependencies = pubSpec.dependencies;
      var devDependencies = pubSpec.devDependencies;

      dependencies.removeWhere((key, value) => key == package);
      devDependencies.removeWhere((key, value) => key == package);
      var newPub = pubSpec.copy(
        devDependencies: devDependencies,
        dependencies: dependencies,
      );
      _savePub(newPub);
      if (logger) {
        LogService.success('Package: %s 已移除！'.trArgs([package]));
      }
    } else if (logger) {
      LogService.info('Package: %s 在本应用中未安装'.trArgs([package]));
    }
  }

  static bool containsPackage(String package, [bool isDev = false]) {
    var dependencies = isDev ? pubSpec.devDependencies : pubSpec.dependencies;
    return dependencies.containsKey(package.trim());
  }

  static bool get nullSafeSupport => !pubSpec.environment!.sdkConstraint!
      .allowsAny(HostedReference.fromJson('<2.12.0').versionConstraint);

  /// make sure it is a get_server project
  static bool get isServerProject {
    return containsPackage('get_server');
  }

  static String get getPackageImport => !isServerProject
      ? "import 'package:get/get.dart';"
      : "import 'package:get_server/get_server.dart';";

  static v.Version? getPackageVersion(String package) {
    if (containsPackage(package)) {
      var version = pubSpec.allDependencies[package]!;
      try {
        final json = version.toJson();
        if (json is String) {
          return v.Version.parse(json);
        }
        return null;
      } on FormatException catch (_) {
        return null;
      } on Exception catch (_) {
        rethrow;
      }
    } else {
      throw CliException('Package: %s 在本应用中未安装'.trArgs([package]));
    }
  }

  static void _savePub(PubSpec pub) {
    var value = CliYamlToString().toYamlString(pub.toJson());
    _pubspecFile.writeAsStringSync(value);
  }
}

/// avoids multiple reads in one file
class _PubValue<T> {
  final T Function() _setValue;
  bool _isChecked = false;
  T? _value;

  /// takes the value of the file,
  /// if not already called it will call the first time
  T? get value {
    if (!_isChecked) {
      _isChecked = true;
      _value = _setValue.call();
    }
    return _value;
  }

  _PubValue(this._setValue);
}
