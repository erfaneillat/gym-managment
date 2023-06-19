import 'package:dio/dio.dart';
import 'package:manage_gym/common/extensions/response.dart';

import '../locator.dart';

class ApiService {
  static final dio = sl<Dio>();

  static Future<dynamic> getRequest(
      String path, Map<String, dynamic> parameters) async {
    return await dio.get(path, queryParameters: parameters).handleResponse();
  }

  static Future<dynamic> deleteRequest(
      String path, Map<String, dynamic> parameters) async {
    return await dio.delete(path, queryParameters: parameters).handleResponse();
  }

  static Future<dynamic> postRequest(String path, Map<String, dynamic> data,
      [FormData? formData]) async {
    return await dio.post(path, data: formData ?? data).handleResponse();
  }

  static Future<dynamic> putRequest(String path, Map<String, dynamic> data,
      [FormData? formData]) async {
    return await dio.put(path, data: formData ?? data).handleResponse();
  }
}
