import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_goal_app/core/common/constants/assets_constants.dart';
import 'package:my_goal_app/features/auth/controller/auth_controller.dart';
import 'package:my_goal_app/theme/pallete.dart';

class SignUpWidget extends ConsumerStatefulWidget {
  const SignUpWidget({super.key});
  static route() => MaterialPageRoute(
        builder: (context) => SignUpWidget(),
      );

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends ConsumerState<SignUpWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Dialog(
        child: Container(
            height: MediaQuery.of(context).size.height / 2,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Pallete.greyColor,
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                  ),
                  child: Text(
                    'Make your Account!',
                    style: TextStyle(
                      color: Pallete.whiteColor,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                  ).copyWith(
                    top: 10,
                  ),
                  child: TextField(
                    controller: emailController,
                    style: TextStyle(
                      color: Pallete.whiteColor,
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                      hintText: 'email : ',
                      hintStyle: TextStyle(color: Pallete.whiteColor),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Pallete.whiteColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Pallete.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: TextField(
                    controller: passwordController,
                    style: TextStyle(
                      color: Pallete.whiteColor,
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                      hintText: 'password : ',
                      hintStyle: TextStyle(color: Pallete.whiteColor),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Pallete.whiteColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Pallete.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(
                    right: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(authControllerProvider.notifier).createAccount(
                            emailController.text,
                            passwordController.text,
                            context,
                          );
                    },
                    child: Text('Sign Up'),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 20,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            AssetImage(AssetsConstants.image_google_logo),
                        backgroundColor: Pallete.greyColor,
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
