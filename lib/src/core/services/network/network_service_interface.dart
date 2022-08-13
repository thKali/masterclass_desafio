abstract class INetworkService {
  Future<dynamic> get(String url);
  Future<dynamic> post(String url, dynamic data);
  Future<dynamic> put(String url, dynamic data);
}
