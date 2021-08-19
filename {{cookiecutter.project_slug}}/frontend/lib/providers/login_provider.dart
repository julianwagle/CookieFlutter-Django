import 'package:frontend/api/api.dart';
import 'package:frontend/api/api_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final loginProvider = ChangeNotifierProvider((_) => LoginProvider());

const tokenKey = 'token';

class LoginProvider extends ChangeNotifier {
  late Box _hiveBox;
  LoginUser? _user;
  bool _isLoading = true;

  Future<void> init(BuildContext context) async {
    try {
      _hiveBox = await Hive.openBox('login');
      String? token = _hiveBox.get(tokenKey);
      if (token != null) {
        await refreshUser(context);
      }
    } catch (e, s) {
      print(e);
      print(s);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signUp(
    BuildContext context, {
    required String username,
    required String email,
    required String password,
  }) async {
    final res = await Api.usersPost(
      context,
      UsersPostRequest(
        user: SignUpUser(
          username: username,
          email: email,
          password: password,
        ),
      ),
    );
    await _hiveBox.put(tokenKey, res.user.token);
    _user = res.user;
    notifyListeners();
  }

  Future<void> login(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    final res = await Api.loginPost(
      context,
      LoginPostRequest(
        user: LoginReqUser(email: email, password: password),
      ),
    );
    await _hiveBox.put(tokenKey, res.user.token);
    _user = res.user;
    notifyListeners();
  }

  Future<void> logout() async {
    _user = null;
    await _hiveBox.delete(tokenKey);
    notifyListeners();
  }

  Future<void> refreshUser(BuildContext context) async {
    final res = await Api.userGet(context, UserGetRequest());
    _user = res.user;
    notifyListeners();
  }

  Future<void> updateUser(
    BuildContext context, {
    required String username,
    required String? image,
    required String? bio,
    required String email,
    required String? password,
  }) async {
    final res = await Api.userPut(
        context,
        UserPutRequest(
          username: username,
          image: image,
          bio: bio,
          email: email,
          password: password,
        ));
    _user = res.user;
    notifyListeners();
  }

  bool get isLoading {
    return _isLoading;
  }

  LoginUser get user {
    final user = _user;
    if (!isLoggedIn) throw Exception('User is not logged in');
    return user!;
  }

  Future<String?> get token async {
    return _user?.token ?? _hiveBox.get(tokenKey);
  }

  bool get isLoggedIn {
    return _user != null;
  }
}
