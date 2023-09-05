import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_goal_app/features/auth/controller/auth_controller.dart';
import 'package:my_goal_app/theme/pallete.dart';

class SideDrawer extends ConsumerWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Pallete.backgroundColor,
        child: Column(
          children: [
            SizedBox(height: 40),
            ListTile(
              onTap: () {
                ref.read(authControllerProvider.notifier).logout(context);
              },
              title: Text(
                'logout',
                style: TextStyle(
                  color: Pallete.whiteColor,
                ),
              ),
              leading: Icon(
                Icons.logout,
                color: Pallete.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
