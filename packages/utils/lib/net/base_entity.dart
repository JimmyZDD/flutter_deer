/*
 * @Author: zdd
 * @Date: 2023-04-09 15:17:17
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-09 15:20:35
 * @FilePath: /flutter_deer/packages/utils/lib/src/net/base_entity.dart
 * @Description: 
 */
import '../res/constant.dart';

class BaseEntity<T> {
  BaseEntity(this.code, this.message, this.data);

  BaseEntity.fromJson(Map<String, dynamic> json) {
    code = json[Constant.code] as int?;
    message = json[Constant.message] as String;
    if (json.containsKey(Constant.data)) {
      data = _generateOBJ<T>(json[Constant.data] as Object?);
    }
  }

  int? code;
  late String message;
  T? data;

  T? _generateOBJ<O>(Object? json) {
    if (json == null) {
      return null;
    }
    if (T.toString() == 'String') {
      return json.toString() as T;
    } else if (T.toString() == 'Map<dynamic, dynamic>') {
      return json as T;
    } else {
      /// List类型数据由fromJsonAsT判断处理
      // return JsonConvert.fromJsonAsT<T>(json);
    }
  }
}
