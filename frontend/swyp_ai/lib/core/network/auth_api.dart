import 'package:dio/dio.dart';
import '../models/auth_response.dart';
import '../models/api_response.dart';
import 'api_client.dart';
import '../../utils/logger.dart';

class AuthApi {
  final ApiClient _apiClient;

  AuthApi(this._apiClient);

  Future<ApiResponse<AuthResponse>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        '/auth/login',  // Update endpoint to login
        data: {
          'email': email,
          'password': password,
        },
      );

      AppLogger.info('Sign in response: ${response.data}');

      return ApiResponse.fromJson(
        response.data,
        (json) => AuthResponse.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      AppLogger.error('Sign in error: $e');
      rethrow;
    }
  }

  // You can keep the register method if needed
  Future<ApiResponse<AuthResponse>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        '/auth/register',
        data: {
          'email': email,
          'password': password,
          'name': name,
        },
      );

      AppLogger.info('Registration response: ${response.data}');

      return ApiResponse.fromJson(
        response.data,
        (json) => AuthResponse.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      AppLogger.error('Registration error: $e');
      rethrow;
    }
  }
} 