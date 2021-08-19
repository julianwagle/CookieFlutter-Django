import 'package:json_annotation/json_annotation.dart';

part 'api_models.g.dart';

// one time build：flutter pub run build_runner build
// watch for changes and build real-time：flutter pub run build_runner watch
// snippets: api-req・api-res・api-item

@JsonSerializable(explicitToJson: true)
class ArticlesGetRequest {
  String limit;
  String offset;

  ArticlesGetRequest({
    required this.limit,
    required this.offset,
  });
  factory ArticlesGetRequest.fromJson(Map<String, dynamic> json) =>
      _$ArticlesGetRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ArticlesGetRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ArticlesGetResponse {
  List<ArticleItem> articles;
  int articlesCount;

  ArticlesGetResponse({
    required this.articles,
    required this.articlesCount,
  });
  factory ArticlesGetResponse.fromJson(Map<String, dynamic> json) =>
      _$ArticlesGetResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ArticlesGetResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ArticleItem {
  AuthorItem author;
  String body;
  String createdAt;
  String description;
  bool favorited;
  int favoritesCount;
  String slug;
  List<String> tagList;
  String title;
  String updatedAt;

  ArticleItem({
    required this.author,
    required this.body,
    required this.createdAt,
    required this.description,
    required this.favorited,
    required this.favoritesCount,
    required this.slug,
    required this.tagList,
    required this.title,
    required this.updatedAt,
  });
  factory ArticleItem.fromJson(Map<String, dynamic> json) =>
      _$ArticleItemFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleItemToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AuthorItem {
  String? bio;
  bool following;
  String image;
  String username;

  AuthorItem({
    required this.bio,
    required this.following,
    required this.image,
    required this.username,
  });
  factory AuthorItem.fromJson(Map<String, dynamic> json) =>
      _$AuthorItemFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorItemToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TagsGetRequest {
  TagsGetRequest();
  factory TagsGetRequest.fromJson(Map<String, dynamic> json) =>
      _$TagsGetRequestFromJson(json);
  Map<String, dynamic> toJson() => _$TagsGetRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TagsGetResponse {
  List<String> tags;

  TagsGetResponse({required this.tags});
  factory TagsGetResponse.fromJson(Map<String, dynamic> json) =>
      _$TagsGetResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TagsGetResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserGetRequest {
  UserGetRequest();
  factory UserGetRequest.fromJson(Map<String, dynamic> json) =>
      _$UserGetRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UserGetRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserGetResponse {
  LoginUser user;

  UserGetResponse({required this.user});
  factory UserGetResponse.fromJson(Map<String, dynamic> json) =>
      _$UserGetResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserGetResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LoginPostRequest {
  LoginReqUser user;

  LoginPostRequest({
    required this.user,
  });
  factory LoginPostRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginPostRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginPostRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LoginReqUser {
  String email;
  String password;

  LoginReqUser({
    required this.email,
    required this.password,
  });
  factory LoginReqUser.fromJson(Map<String, dynamic> json) =>
      _$LoginReqUserFromJson(json);
  Map<String, dynamic> toJson() => _$LoginReqUserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LoginPostResponse {
  LoginUser user;

  LoginPostResponse({required this.user});
  factory LoginPostResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginPostResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginPostResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LoginUser {
  String? bio;
  String createdAt;
  String email;
  int id;
  String? image;
  String token;
  String updatedAt;
  String username;

  LoginUser({
    required this.bio,
    required this.createdAt,
    required this.email,
    required this.id,
    required this.image,
    required this.token,
    required this.updatedAt,
    required this.username,
  });
  factory LoginUser.fromJson(Map<String, dynamic> json) =>
      _$LoginUserFromJson(json);
  Map<String, dynamic> toJson() => _$LoginUserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UsersPostRequest {
  SignUpUser user;

  UsersPostRequest({
    required this.user,
  });
  factory UsersPostRequest.fromJson(Map<String, dynamic> json) =>
      _$UsersPostRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UsersPostRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UsersPostResponse {
  LoginUser user;

  UsersPostResponse({
    required this.user,
  });
  factory UsersPostResponse.fromJson(Map<String, dynamic> json) =>
      _$UsersPostResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UsersPostResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SignUpUser {
  String email;
  String password;
  String username;

  SignUpUser({
    required this.email,
    required this.password,
    required this.username,
  });
  factory SignUpUser.fromJson(Map<String, dynamic> json) =>
      _$SignUpUserFromJson(json);
  Map<String, dynamic> toJson() => _$SignUpUserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserPutRequest {
  String username;
  String? image;
  String? bio;
  String email;
  String? password;

  UserPutRequest({
    required this.username,
    required this.image,
    required this.bio,
    required this.email,
    required this.password,
  });
  factory UserPutRequest.fromJson(Map<String, dynamic> json) =>
      _$UserPutRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UserPutRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserPutResponse {
  LoginUser user;

  UserPutResponse({
    required this.user,
  });
  factory UserPutResponse.fromJson(Map<String, dynamic> json) =>
      _$UserPutResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserPutResponseToJson(this);
}
