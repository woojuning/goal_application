import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_goal_app/features/home/home_common/index_state.dart';
import 'package:my_goal_app/theme/pallete.dart';

class HomeBottomWidget extends ConsumerWidget {
  const HomeBottomWidget({super.key});

  bool checkIndex(int index, int index2) {
    if (index == index2) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(tabIndexProvider);
    return CupertinoTabBar(
      backgroundColor: Pallete.backgroundColor,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            checkIndex(0, index) ? Icons.home : Icons.home_outlined,
            color: Pallete.greyColor,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            checkIndex(1, index)
                ? Icons.rocket_launch
                : Icons.rocket_launch_outlined,
            color: Pallete.greyColor,
          ),
          label: 'Goal',
        ),
      ],
      onTap: (value) {
        ref.read(tabIndexProvider.notifier).changeIndex(value);
        print(value);
      },
    );
  }
}
