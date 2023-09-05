import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_goal_app/core/common/error_text.dart';
import 'package:my_goal_app/features/auth/controller/auth_controller.dart';
import 'package:my_goal_app/features/auth/view/login_view.dart';
import 'package:my_goal_app/features/home/view/home_view.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: ref.watch(checkLoginSessionProvider).when(
            data: (user) {
              if (user == null) {
                return LoginView();
              }
              return HomeView();
            },
            error: (error, stackTrace) => ErrorText(error: error.toString()),
            loading: () => Center(child: CircularProgressIndicator()),
          ),
    );
  }
}
