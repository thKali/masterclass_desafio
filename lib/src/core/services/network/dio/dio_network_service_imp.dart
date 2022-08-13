import 'package:dio/dio.dart';
import 'package:masterclass_desafio/src/core/services/network/network_error.dart';

import '../network_service_interface.dart';

class DioNetworkServiceImp implements INetworkService {
  DioNetworkServiceImp({required Dio dio}) : _client = dio;
  final Dio _client;

  @override
  Future<Response> get(String url) async {
    try {
      final response = await _client.get(url);
      return response;
    } on DioError catch (e) {
      throw NetworkException(
        message: e.error.message,
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<Response> post(String url, data) async {
    final response = await _client.post(url, data: data);
    return response;
  }

  @override
  Future<Response> put(String url, data) async {
    final response = await _client.put(url, data: data);
    return response;
  }
}
