/*
 * @Author: zdd
 * @Date: 2023-04-17 12:02:51
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-17 13:01:44
 * @FilePath: /flutter_deer/packages/gen_cli/lib/extensions/string.dart
 * @Description: 
 */
import '../exception_handler/exceptions/cli_exception.dart';

extension StringExt on String {
  String? trArgsPlural(
      [String? plural, int i = 0, List<String> args = const []]) {
    return i > 1 ? plural?.trArgs(args) : trArgs(args);
  }

  String trArgs([List<String?> args = const []]) {
    var str = this;
    if (args.isNotEmpty) {
      for (final arg in args) {
        str = replaceFirst(RegExp(r'%s'), arg.toString());
      }
    }

    return str;
  }

  /// Removes all characters.
  /// ```
  /// var bestPackage = 'GetX'.removeAll('X');
  /// print(bestPackage) // Get;
  /// ```
  String removeAll(String value) {
    var newValue = replaceAll(value, '');
    //this =  newValue;
    return newValue;
  }

  /// Append the content of dart class
  /// ``` dart
  /// var newClassContent = '''abstract class Routes {
  ///  Routes._();
  ///
  ///}
  /// abstract class _Paths {
  ///  _Paths._();
  /// }'''.appendClassContent('Routes', 'static const HOME = _Paths.HOME;' );
  /// print(newClassContent);
  /// ```
  /// abstract class Routes {
  /// Routes._();
  /// static const HOME = _Paths.HOME;
  /// }
  /// abstract class _Paths {
  ///  _Paths._();
  /// }
  ///
  String appendClassContent(String className, String value) {
    var matches =
        RegExp('class $className {.*?(^})', multiLine: true, dotAll: true)
            .allMatches(this);
    //TODO: Add exception in the translations
    if (matches.isEmpty) {
      throw CliException('The class $className is not found in the file $this');
    } else if (matches.length > 1) {
      throw CliException(
          'The class $className is found more than once in the file $this');
    }
    var match = matches.first;
    return insert(match.end - 1, value);
  }

  String insert(int index, String value) {
    var newValue = substring(0, index) + value + substring(index);
    return newValue;
  }
}
