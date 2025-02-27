import 'package:swyp_ai/core/models/api_response.dart';
import 'package:swyp_ai/core/models/auth_response.dart';
import 'package:swyp_ai/core/network/api_client.dart';

class RegistrationApi {
  final ApiClient _apiClient;

  RegistrationApi(this._apiClient);

  Future<ApiResponse<AuthResponse>> login({
    required String username,
    required String password,
  }) async {
    return _apiClient.post(
      endpoint: '/login',
      body: {'username': username, 'password': password},
      fromJson: (json) => AuthResponse.fromJson(json),
    );
  }

  Future<ApiResponse<AuthResponse>> register({
    required String username,
    required String password,
  }) async {
    return _apiClient.post(
      endpoint: '/register',
      body: {'username': username, 'password': password},
      fromJson: (json) => AuthResponse.fromJson(json),
    );
  }
}
