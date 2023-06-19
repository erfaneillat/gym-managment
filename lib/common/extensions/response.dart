import 'package:dio/dio.dart';
import 'package:manage_gym/common/extensions/error.dart';

extension ResponseExt on Future<Response> {
  Future<dynamic> handleResponse() async {
    try {
      final res = await this;
      print(res.data);
      return res.data;
    } on DioError catch (e) {
      print(e.response);
      return (e.response?.data['error'] as String).toFailure();
    }
  }
}
