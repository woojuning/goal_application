import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_goal_app/core/common/side_drawer.dart';
import 'package:my_goal_app/features/goal/view/goal_view.dart';
import 'package:my_goal_app/features/home/home_common/index_state.dart';
import 'package:my_goal_app/features/home/widget/home_bottom_widget.dart';
import 'package:my_goal_app/features/home/widget/home_widget.dart';
import 'package:my_goal_app/theme/pallete.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});
  static route() => MaterialPageRoute(
        builder: (context) => HomeView(),
      );

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _HomeViewState();
  }
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      backgroundColor: Pallete.backgroundColor,
      // appBar: AppBar(
      //     backgroundColor: Pallete.backgroundColor,
      //     title: Text(
      //       'home view',
      //       style: TextStyle(color: Pallete.whiteColor),
      //     )),
      body: IndexedStack(
        index: ref.watch(tabIndexProvider),
        children: [
          HomeWidget(),
          GoalView(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Pallete.greyColor,
            ),
          ),
        ),
        child: HomeBottomWidget(),
      ),
    );
  }
}
