import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_goal_app/features/auth/widget/login_widget.dart';
import 'package:my_goal_app/theme/pallete.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});
  static route() => MaterialPageRoute(
        builder: (context) => LoginView(),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Pallete.backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Login',
            style: TextStyle(color: Pallete.whiteColor),
          ),
          backgroundColor: Pallete.backgroundColor,
        ),
        body: LoginWidget(),
      ),
    );
  }
}
