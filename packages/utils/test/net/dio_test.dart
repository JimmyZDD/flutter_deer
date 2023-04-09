/*
 * @Author: zdd
 * @Date: 2023-04-09 16:07:24
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-09 16:10:38
 * @FilePath: /flutter_deer/packages/utils/test/net/dio_test.dart
 * @Description: 
 */
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:utils/net/net.dart';
import 'package:test/test.dart';

void main() {
  group('dio_test', () {
    Dio dio;
    setUp(() {
      /// 测试配置
      dio = DioUtils.instance.dio;
      dio.options.baseUrl = 'https://api.github.com/';
    });

    test('getUsers', () async {
      await DioUtils.instance.requestNetwork(Method.get, HttpApi.users,
          onSuccess: (data) {
        // expect(data?.name, '唯鹿');
      }, onError: (_, __) {
        debugPrint('$_, $__');
      });
    });
  });
}
