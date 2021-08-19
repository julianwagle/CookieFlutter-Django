// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticlesGetRequest _$ArticlesGetRequestFromJson(Map<String, dynamic> json) {
  return ArticlesGetRequest(
    limit: json['limit'] as String,
    offset: json['offset'] as String,
  );
}

Map<String, dynamic> _$ArticlesGetRequestToJson(ArticlesGetRequest instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'offset': instance.offset,
    };

ArticlesGetResponse _$ArticlesGetResponseFromJson(Map<String, dynamic> json) {
  return ArticlesGetResponse(
    articles: (json['articles'] as List<dynamic>)
        .map((e) => ArticleItem.fromJson(e as Map<String, dynamic>))
        .toList(),
    articlesCount: json['articlesCount'] as int,
  );
}

Map<String, dynamic> _$ArticlesGetResponseToJson(
        ArticlesGetResponse instance) =>
    <String, dynamic>{
      'articles': instance.articles.map((e) => e.toJson()).toList(),
      'articlesCount': instance.articlesCount,
    };

ArticleItem _$ArticleItemFromJson(Map<String, dynamic> json) {
  return ArticleItem(
    author: AuthorItem.fromJson(json['author'] as Map<String, dynamic>),
    body: json['body'] as String,
    createdAt: json['createdAt'] as String,
    description: json['description'] as String,
    favorited: json['favorited'] as bool,
    favoritesCount: json['favoritesCount'] as int,
    slug: json['slug'] as String,
    tagList:
        (json['tagList'] as List<dynamic>).map((e) => e as String).toList(),
    title: json['title'] as String,
    updatedAt: json['updatedAt'] as String,
  );
}

Map<String, dynamic> _$ArticleItemToJson(ArticleItem instance) =>
    <String, dynamic>{
      'author': instance.author.toJson(),
      'body': instance.body,
      'createdAt': instance.createdAt,
      'description': instance.description,
      'favorited': instance.favorited,
      'favoritesCount': instance.favoritesCount,
      'slug': instance.slug,
      'tagList': instance.tagList,
      'title': instance.title,
      'updatedAt': instance.updatedAt,
    };

AuthorItem _$AuthorItemFromJson(Map<String, dynamic> json) {
  return AuthorItem(
    bio: json['bio'] as String?,
    following: json['following'] as bool,
    image: json['image'] as String,
    username: json['username'] as String,
  );
}

Map<String, dynamic> _$AuthorItemToJson(AuthorItem instance) =>
    <String, dynamic>{
      'bio': instance.bio,
      'following': instance.following,
      'image': instance.image,
      'username': instance.username,
    };

TagsGetRequest _$TagsGetRequestFromJson(Map<String, dynamic> json) {
  return TagsGetRequest();
}

Map<String, dynamic> _$TagsGetRequestToJson(TagsGetRequest instance) =>
    <String, dynamic>{};

TagsGetResponse _$TagsGetResponseFromJson(Map<String, dynamic> json) {
  return TagsGetResponse(
    tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$TagsGetResponseToJson(TagsGetResponse instance) =>
    <String, dynamic>{
      'tags': instance.tags,
    };

UserGetRequest _$UserGetRequestFromJson(Map<String, dynamic> json) {
  return UserGetRequest();
}

Map<String, dynamic> _$UserGetRequestToJson(UserGetRequest instance) =>
    <String, dynamic>{};

UserGetResponse _$UserGetResponseFromJson(Map<String, dynamic> json) {
  return UserGetResponse(
    user: LoginUser.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserGetResponseToJson(UserGetResponse instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
    };

LoginPostRequest _$LoginPostRequestFromJson(Map<String, dynamic> json) {
  return LoginPostRequest(
    user: LoginReqUser.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LoginPostRequestToJson(LoginPostRequest instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
    };

LoginReqUser _$LoginReqUserFromJson(Map<String, dynamic> json) {
  return LoginReqUser(
    email: json['email'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$LoginReqUserToJson(LoginReqUser instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

LoginPostResponse _$LoginPostResponseFromJson(Map<String, dynamic> json) {
  return LoginPostResponse(
    user: LoginUser.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LoginPostResponseToJson(LoginPostResponse instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
    };

LoginUser _$LoginUserFromJson(Map<String, dynamic> json) {
  return LoginUser(
    bio: json['bio'] as String?,
    createdAt: json['createdAt'] as String,
    email: json['email'] as String,
    id: json['id'] as int,
    image: json['image'] as String?,
    token: json['token'] as String,
    updatedAt: json['updatedAt'] as String,
    username: json['username'] as String,
  );
}

Map<String, dynamic> _$LoginUserToJson(LoginUser instance) => <String, dynamic>{
      'bio': instance.bio,
      'createdAt': instance.createdAt,
      'email': instance.email,
      'id': instance.id,
      'image': instance.image,
      'token': instance.token,
      'updatedAt': instance.updatedAt,
      'username': instance.username,
    };

UsersPostRequest _$UsersPostRequestFromJson(Map<String, dynamic> json) {
  return UsersPostRequest(
    user: SignUpUser.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UsersPostRequestToJson(UsersPostRequest instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
    };

UsersPostResponse _$UsersPostResponseFromJson(Map<String, dynamic> json) {
  return UsersPostResponse(
    user: LoginUser.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UsersPostResponseToJson(UsersPostResponse instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
    };

SignUpUser _$SignUpUserFromJson(Map<String, dynamic> json) {
  return SignUpUser(
    email: json['email'] as String,
    password: json['password'] as String,
    username: json['username'] as String,
  );
}

Map<String, dynamic> _$SignUpUserToJson(SignUpUser instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'username': instance.username,
    };

UserPutRequest _$UserPutRequestFromJson(Map<String, dynamic> json) {
  return UserPutRequest(
    username: json['username'] as String,
    image: json['image'] as String?,
    bio: json['bio'] as String?,
    email: json['email'] as String,
    password: json['password'] as String?,
  );
}

Map<String, dynamic> _$UserPutRequestToJson(UserPutRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'image': instance.image,
      'bio': instance.bio,
      'email': instance.email,
      'password': instance.password,
    };

UserPutResponse _$UserPutResponseFromJson(Map<String, dynamic> json) {
  return UserPutResponse(
    user: LoginUser.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserPutResponseToJson(UserPutResponse instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
    };
