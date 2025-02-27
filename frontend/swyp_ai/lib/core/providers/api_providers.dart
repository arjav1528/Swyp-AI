import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swyp_ai/core/network/api_client.dart';
import 'package:swyp_ai/core/network/registration_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_providers.g.dart';

@riverpod
ApiClient apiClient(ApiClientRef ref) {
  final client = ApiClient();
  ref.onDispose(() {
    client.dispose();
  });
  return client;
}

@riverpod
RegistrationApi registrationApi(RegistrationApiRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  return RegistrationApi(apiClient);
}
