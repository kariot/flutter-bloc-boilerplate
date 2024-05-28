import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_data.dart';

part 'users_list_response.freezed.dart';
part 'users_list_response.g.dart';

@freezed
class UsersListResponse with _$UsersListResponse {
  factory UsersListResponse({
    int? page,
    @JsonKey(name: 'per_page') int? perPage,
    int? total,
    @JsonKey(name: 'total_pages') int? totalPages,
    List<UserData>? data,
  }) = _UsersListResponse;

  factory UsersListResponse.fromJson(Map<String, dynamic> json) =>
      _$UsersListResponseFromJson(json);
}
