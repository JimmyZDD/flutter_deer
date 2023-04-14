/*
 * @Author: zdd
 * @Date: 2023-04-14 10:20:25
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-14 11:45:10
 * @FilePath: /grizzly_app/packages/xt_map/example/generate_models.dart
 * @Description: 
 */

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

List<Model> generateModels(Map<String, dynamic> swagger) {
  final models = <Model>[];
  final definitions = swagger['definitions'] as Map<String, dynamic>?;
  const indent = '  ';
  const baseType = ['int', 'double', 'String', 'DateTime', 'bool'];
  if (definitions != null) {
    definitions.forEach((name, definition) {
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
  return models;
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
