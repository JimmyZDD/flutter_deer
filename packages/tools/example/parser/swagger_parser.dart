import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

final baseType = ['int', 'double', 'String', 'DateTime', 'bool'];

class Model {
  final String name;
  final String properties;

  Model(this.name, this.properties);

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln('class $name {');
    buffer.writeln(properties);
    buffer.writeln('}');
    return buffer.toString();
  }
}

class SwaggerParser {
  final String swaggerUrl;
  final String outputDir;

  SwaggerParser({required this.swaggerUrl, required this.outputDir});

  Future<Map<String, dynamic>> _fetchSwaggerJson() async {
    final response = await http
        .get(Uri.parse('https://petstore.swagger.io/v2/swagger.json'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch Swagger JSON');
    }
  }

  String _mapType(Map<String, dynamic> property) {
    final type = property['type'] as String?;
    final format = property['format'] as String?;
    switch (type) {
      case 'integer':
        if (format == 'int32') {
          return 'int';
        } else if (format == 'int64') {
          return 'int';
        }
        break;
      case 'number':
        if (format == 'float') {
          return 'double';
        } else if (format == 'double') {
          return 'double';
        }
        break;
      case 'string':
        if (format == 'date-time') {
          return 'DateTime';
        } else {
          return 'String';
        }
      case 'boolean':
        return 'bool';
      case 'file':
        return 'File';
      case 'object':
        return _mapType(property['additionalProperties']);
      case 'array':
        final items = property['items'] as Map<String, dynamic>?;
        if (items != null) {
          final itemType = _mapType(items);
          return 'List<$itemType>';
        }
        break;
      default:
        final ref = property[r'$ref'] as String?;
        if (ref != null) {
          final parts = ref.split('/');
          final typeName = parts[parts.length - 1];
          return typeName;
        }
    }
    throw Exception('Unsupported type: $type');
  }

  String? _getClassName(Map<String, dynamic> successResponse) {
    if (successResponse['schema'] == null) {
      return null;
    }
    return _mapType(successResponse['schema']);
  }

  Future<void> _writeFile(String filePath, String contents) async {
    final file = File(filePath);
    await file.create(recursive: true);
    await file.writeAsString(contents);
  }

  Future<void> generateModels(Map<String, dynamic> json) async {
    final definitions = json['definitions'] as Map<String, dynamic>?;
    final models = <Model>[];

    const indent = '  ';

    if (definitions != null) {
      definitions.forEach((name, definition) async {
        final buffer = StringBuffer();
        buffer.write('$indent$name({\n');
        final properties = definition['properties'] as Map<String, dynamic>?;
        if (properties != null) {
          properties.forEach((propertyName, property) {
            final require =
                (definition['required'] as List?)?.contains(propertyName) ??
                    false;
            buffer.write(
                '$indent$indent${require ? 'required ' : ''}this.$propertyName');
            buffer.write(',\n');
          });
        }
        buffer.write('$indent});\n\n');
        if (properties != null) {
          properties.forEach((propertyName, property) {
            if (property['description'] != null) {
              buffer.write('$indent/// ${property['description']} \n');
            }
            final dartType = _mapType(property);
            final require =
                (definition['required'] as List?)?.contains(propertyName) ??
                    false;
            buffer.write(
                '$indent$dartType${require ? '' : '?'} $propertyName; \n\n');
          });
        }

        buffer.write(
            '${indent}factory $name.fromJson(Map<String, dynamic> json) => $name(\n');

        if (properties != null) {
          properties.forEach((propertyName, property) {
            final dartType = _mapType(property);
            buffer.write('$indent$indent$propertyName: ');
            if (property['type'] == 'array') {
              var subType = dartType.substring(5, dartType.length - 1);
              buffer.write(
                  'List<$subType>.from(json["$propertyName"].map((x) => ${baseType.contains(subType) ? 'x' : '$subType.fromJson(x)'})),\n');
            } else if (!baseType.contains(dartType)) {
              buffer.write('$dartType.fromJson(json["$propertyName"]),\n');
            } else {
              buffer.write('json["$propertyName"],\n');
            }
          });
        }
        buffer.write('$indent);\n\n');
        buffer.write('${indent}Map<String, dynamic> toJson() => {\n');
        if (properties != null) {
          properties.forEach((propertyName, property) {
            buffer.write('$indent$indent"$propertyName": ');
            final dartType = _mapType(property);
            if (property['type'] == 'array') {
              final require =
                  (definition['required'] as List?)?.contains(propertyName) ??
                      false;
              var subType = dartType.substring(5, dartType.length - 1);

              if (require) {
                buffer.write(
                    '$propertyName.map((e) => ${baseType.contains(subType) ? 'e' : 'e.toJson()'}).toList(),\n');
              } else {
                buffer.write(
                    '$propertyName != null ? $propertyName!.map((e) => ${baseType.contains(subType) ? 'e' : 'e.toJson()'}).toList() : null,\n');
              }
            } else if (!baseType.contains(dartType)) {
              final require =
                  (definition['required'] as List?)?.contains(propertyName) ??
                      false;
              if (require) {
                buffer.write('$propertyName.toJson(),\n');
              } else {
                buffer.write(
                    '$propertyName != null ? $propertyName!.toJson() : null,\n');
              }
            } else {
              buffer.write('$propertyName,\n');
            }
          });
        }
        buffer.write('$indent};\n');
        models.add(Model(name, buffer.toString()));
      });
    }
    final buffer = StringBuffer();
    for (final model in models) {
      buffer.write('$model\n');
    }
    final filePath = '$outputDir/models.dart';
    await _writeFile(filePath, buffer.toString());
  }

  Future<void> generateApi(Map<String, dynamic> json) async {
    final paths = json['paths'] as Map<String, dynamic>;
    const indent = '  ';
    final api = StringBuffer('import \'package:get/get.dart\';\n');
    api.writeln('import \'models.dart\';\n');
    api.writeln('''
class ApiProvider extends GetConnect {
  @override
  void onInit() {
    // httpClient.baseUrl = 'https://api.github.com';
  }
''');
    for (final entry in paths.entries) {
      final path = entry.key;
      final methods = entry.value as Map<String, dynamic>;

      for (final methodEntry in methods.entries) {
        final method = methodEntry.key.toUpperCase();
        final operation = methodEntry.value as Map<String, dynamic>;
        final summary = operation['summary'] as String?;
        final description = operation['description'] as String?;
        final operationId = operation['operationId'] as String?;
        final parameters = operation['parameters'] as List<dynamic>?;

        final pathParams =
            parameters?.where((p) => p['in'] == 'path').toList() ?? [];
        final queryParams =
            parameters?.where((p) => p['in'] == 'query').toList() ?? [];
        final formDataParams =
            parameters?.where((p) => p['in'] == 'formData').toList() ?? [];
        final bodyParams =
            parameters?.where((p) => p['in'] == 'body').toList() ?? [];
        final bodyParam = (bodyParams.isNotEmpty ? bodyParams.first : null)
            as Map<String, dynamic>?;

        final responses = operation['responses'] as Map<String, dynamic>?;
        final successResponse = responses?.remove('200') ??
            responses?.values.first as Map<String, dynamic>?;
        if (summary != null) {
          api.writeln('$indent/// $summary');
        }
        if (description != null) {
          api.writeln('$indent/// $description');
        }
        if (operationId != null) {
          api.writeln('$indent/// Operation ID: $operationId');
        }
        if (formDataParams.isNotEmpty) {
          api.write('$indent/// body type: ');
          for (final param in formDataParams) {
            final name = param['name'] as String;
            final type = _mapType(param);
            final require = param['required'] as bool?;

            api.write(
                '      ${require != null && require ? 'required ' : ''}$type $name,');
          }
          api.writeln('}');
        }
        var hasResponse = !(successResponse == null ||
            ['post', 'put'].contains(method) ||
            _getClassName(successResponse) == null);
        if (!hasResponse) {
          api.write('  Future $operationId(');
        } else {
          api.write(
              '${indent}Future<${_getClassName(successResponse)}> $operationId(');
        }
        var hasPathParam = false;
        for (final param in pathParams) {
          final name = param['name'] as String;
          final type = _mapType(param);

          api.write('$type $name');
          hasPathParam = true;
        }
        var hasBrace = false;
        if (queryParams.isNotEmpty) {
          api.writeln('${hasPathParam ? ', ' : ''}{');
          for (final param in queryParams) {
            final name = param['name'] as String;
            final type = _mapType(param);
            final require = param['required'] as bool?;

            api.write(
                '$indent$indent$indent${require != null && require ? 'required ' : ''}$type $name,');
          }
          hasBrace = true;
        }
        if (formDataParams.isNotEmpty) {
          api.writeln('${hasPathParam ? ', ' : ''}{');
          api.writeln(
              '$indent$indent${indent}required Map<String, dynamic> body');
          hasBrace = true;
        }
        if (bodyParam != null) {
          if (!hasBrace) api.writeln('${hasPathParam ? ', ' : ''}{');
          final type = _mapType(bodyParam['schema']);
          final require = bodyParam['required'] as bool?;
          api.writeln(
              '$indent$indent$indent${require != null && require ? 'required ' : ''}$type body,');
          hasBrace = true;
        }
        if (hasBrace) api.write('$indent}');

        api.writeln(') async {');

        var reqPath = path;

        for (final param in pathParams) {
          final name = param['name'] as String;
          if (reqPath.contains('{$name}')) {
            reqPath = reqPath.replaceAll('{$name}', '\$$name');
          } else {
            reqPath += reqPath.endsWith('/') ? '\${$name}' : '/\${$name}';
          }
        }
        var queryStr = '';
        if (queryParams.isNotEmpty) {
          StringBuffer strBuffer = StringBuffer('{');
          for (final param in queryParams) {
            final name = param['name'] as String;
            strBuffer.write('\'$name\': $name,');
          }
          strBuffer.write('}');
          queryStr = strBuffer.toString();
        }

        api.write(
            '    ${hasResponse ? 'final res =' : ''} await ${method.toLowerCase()}(\'$reqPath\'');
        if (bodyParam != null || formDataParams.isNotEmpty) {
          api.write(', body');
        }
        if (queryStr.isNotEmpty) api.write(', query: $queryStr');

        api.writeln(');');

        // if (hasRequestBody) {
        //   final requestBodyType =
        //       _getClassName(operationId ?? '${path.toCapitalCase()}Request');
        //   api.writeln('    request.body = json.encode(requestBody.toJson());');
        // }

        if (hasResponse && _getClassName(successResponse) != null) {
          var resName = _getClassName(successResponse)!;
          if (resName.startsWith('List')) {
            var type = resName.substring(5, resName.length - 1);
            api.writeln(
                '    return res.body[\'data\'].map((e) => $type.fromJson(e)).toList() as $resName;');
          } else if (baseType.contains(resName)) {
            api.writeln('    return res.body[\'data\'];');
          } else {
            api.writeln('    return $resName.fromJson(res.body[\'data\']);');
          }
        }
        api.writeln('  }\n');
      }
    }

    api.writeln('}');

    final filePath = '$outputDir/api.dart';
    final file = File(filePath);
    await file.writeAsString(api.toString());
  }

  Future<void> generate() async {
    final dir = Directory(outputDir);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
    final json = await _fetchSwaggerJson();

    await generateModels(json);
    await generateApi(json);
  }
}

void main() async {
  final generator = SwaggerParser(
      swaggerUrl: 'https://petstore.swagger.io/v2/swagger.json',
      outputDir: './output');

  await generator.generate();
}
