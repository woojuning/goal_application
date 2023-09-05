import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_goal_app/core/common/show_snackbar.dart';
import 'package:my_goal_app/features/api/auth_api.dart';
import 'package:my_goal_app/features/auth/view/login_view.dart';
import 'package:my_goal_app/features/home/view/home_view.dart';
import 'package:my_goal_app/models/user_model.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(authAPI: ref.watch(authAPIProvider));
});

final checkLoginSessionProvider = FutureProvider((ref) {
  final authAPI = ref.watch(authAPIProvider);
  return authAPI.checkLoginSession();
});

final getCurrentUserProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getCurrentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI authAPI;
  AuthController({required this.authAPI}) : super(false);

  void createAccount(
      String email, String password, BuildContext context) async {
    final res = await authAPI.createAccount(email, password);
    res.fold(
      (l) {},
      (r) async {
        final userModel = UserModel(
          email: email,
          name: email.split('@').first,
          uid: r.$id,
        );
        final res2 = await authAPI.createUserDocument(userModel);
        res2.fold((l) => showSnackBar(l.message, context), (r) {
          Navigator.pop(context);
        });
      },
    );
  }

  void login(String email, String password, BuildContext context) async {
    final res = await authAPI.login(email, password);
    res.fold((l) => showSnackBar(l.message, context), (r) {
      showSnackBar('login success!!', context);
      Navigator.push(context, HomeView.route());
    });
  }

  Future<UserModel> getCurrentUser() async {
    final document = await authAPI.getCurrentUser();
    print(UserModel.fromMap(document.data));
    return UserModel.fromMap(document.data);
  }

  void logout(BuildContext context) async {
    final res = await authAPI.logout();
    res.fold((l) => print('실패'), (r) {
      print('성공');
      Navigator.pushAndRemoveUntil(
          context, LoginView.route(), (route) => false);
    });
  }
}
