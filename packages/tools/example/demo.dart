/*
 * @Author: zdd
 * @Date: 2023-04-14 10:14:01
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-14 11:02:52
 * @FilePath: /grizzly_app/packages/xt_map/example/demo.dart
 * @Description: 
 */
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'generate_models.dart';

Future<void> main(List<String> args) async {
  final swaggerJson = await _fetchSwaggerJson();
  final swagger = json.decode(swaggerJson) as Map<String, dynamic>;
  final models = generateModels(swagger);
  print(swagger);
  print(models);
  writeModels(models, 'models');
  // final apis = _generateApis(swagger);
  // _writeToFile(models, apis);
  print('Code generated successfully!');
}

Future<String> _fetchSwaggerJson() async {
  final response =
      await http.get(Uri.parse('https://petstore.swagger.io/v2/swagger.json'));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to fetch Swagger JSON');
  }
}

void createDirectory(String path) {
  final dir = Directory(path);
  if (!dir.existsSync()) {
    dir.createSync(recursive: true);
  }
}

void writeModels(List<Model> models, String outputPath) {
  createDirectory(outputPath);
  final file = File('$outputPath/model.dart');
  final buffer = StringBuffer();
  for (final model in models) {
    // final name = _getClassName(model.name);
    buffer.write('$model\n');
  }
  file.createSync(recursive: true);
  file.writeAsStringSync(buffer.toString());
}

String _getClassName(String name) {
  final parts = name.split('.');
  final className = parts.last.replaceAllMapped(
    RegExp(r'(?<=[a-z])[A-Z]'),
    (match) => '_${match.group(0)}',
  );
  return '${className.substring(0, 1).toUpperCase()}${className.substring(1)}';
}
