import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:swyp_ai/core/models/genre.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    @JsonKey(name: '_id') required String id,
    required String username,
    @JsonKey(name: 'generes') required List<Genre> genres,
    required List<String> savedQuotes,
    required String gender,
    required int age,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
