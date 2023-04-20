/*
 * @Author: zdd
 * @Date: 2023-04-17 12:06:59
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-20 11:32:04
 * @FilePath: /flutter_deer/packages/gen_cli/lib/common/utils/pubspec/pubspec_utils.dart
 * @Description: 
 */
import 'dart:io';

import 'package:gen_cli/extensions.dart';
import 'package:pubspec/pubspec.dart';
import 'package:version/version.dart' as v;

import '../../../exception_handler/exceptions/cli_exception.dart';

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
