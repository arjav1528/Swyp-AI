import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:swyp_ai/core/models/api_response.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: const String.fromEnvironment('API_BASE_URL'),
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    // Add interceptors
    _dio.interceptors.addAll([
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: false,
      ),
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add common headers here
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          // Handle common errors here
          return handler.next(e);
        },
      ),
    ]);
  }

  Dio get dio => _dio;

  Future<ApiResponse<T>> post<T>({
    required String endpoint,
    required T Function(dynamic) fromJson,
    Object? body,
  }) async {
    try {
      final response = await _dio.post(endpoint, data: body);

      if (response.statusCode == 200) {
        return ApiResponse(
          success: true,
          data: fromJson(response.data['data']),
          message: response.data['message'],
          meta: response.data['meta'] as Map<String, dynamic>? ?? {},
        );
      } else {
        return ApiResponse(
          success: false,
          error: ErrorDetails(
            code: response.statusCode?.toString() ?? 'unknown_error',
            message: 'Request failed',
          ),
        );
      }
    } on DioException catch (e) {
      return ApiResponse(
        success: false,
        error: ErrorDetails(
          code: e.response?.statusCode?.toString() ?? 'unknown',
          message: e.message ?? 'Unknown error occurred',
        ),
      );
    }
  }

  void dispose() {
    _dio.close();
  }
}
