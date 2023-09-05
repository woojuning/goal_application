import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_goal_app/features/goal/widget/create_goal_widget.dart';
import 'package:my_goal_app/features/goal/widget/goal_list_widget.dart';
import 'package:my_goal_app/theme/pallete.dart';

class GoalView extends ConsumerWidget {
  const GoalView({super.key});
  static route() => MaterialPageRoute(
        builder: (context) => GoalView(),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      appBar: AppBar(
        backgroundColor: Pallete.backgroundColor,
        title: Text(
          '목표 리스트',
          style: TextStyle(color: Pallete.whiteColor),
        ),
      ),
      body: GoalListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return CreateGaolWidget();
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
