import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_goal_app/features/home/home_common/index_state.dart';

class HomeBottomWidget extends ConsumerWidget {
  const HomeBottomWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoTabBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: 'home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: 'goal',
        ),
      ],
      onTap: (value) {
        ref.read(tabIndexProvider.notifier).changeIndex(value);
        print(value);
      },
    );
  }
}
