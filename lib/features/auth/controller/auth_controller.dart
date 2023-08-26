import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_goal_app/features/api/auth_api.dart';
import 'package:my_goal_app/models/user_model.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(authAPI: ref.watch(authAPIProvider));
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
        res2.fold((l) => null, (r) {
          Navigator.pop(context);
        });
      },
    );
  }
}
