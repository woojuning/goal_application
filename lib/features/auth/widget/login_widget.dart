import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_goal_app/features/auth/widget/signup_widget.dart';
import 'package:my_goal_app/theme/pallete.dart';

class LoginWidget extends ConsumerStatefulWidget {
  const LoginWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends ConsumerState<LoginWidget> {
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
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 150,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: TextField(
              controller: emailController,
              style: TextStyle(color: Pallete.whiteColor),
              decoration: InputDecoration(
                hintText: 'email : ',
                hintStyle: TextStyle(color: Pallete.whiteColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Pallete.greyColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Pallete.greyColor,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: TextField(
              controller: passwordController,
              style: TextStyle(color: Pallete.whiteColor),
              decoration: InputDecoration(
                hintText: 'password : ',
                hintStyle: TextStyle(color: Pallete.whiteColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Pallete.greyColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Pallete.greyColor,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(
                  right: 30,
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Login'),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'no account?',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                TextSpan(
                    text: ' Click here',
                    style: TextStyle(fontSize: 20, color: Pallete.blueColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Navigator.push(context, SignUpWidget.route());
                        showDialog(
                          context: context,
                          builder: (context) {
                            return SignUpWidget();
                          },
                        );
                      }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
