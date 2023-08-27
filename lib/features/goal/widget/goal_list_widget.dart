import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_goal_app/core/common/error_text.dart';
import 'package:my_goal_app/core/common/loader.dart';
import 'package:my_goal_app/features/goal/controller/goal_controller.dart';
import 'package:my_goal_app/models/goal_model.dart';
import 'package:my_goal_app/theme/pallete.dart';

class GoalListWidget extends ConsumerWidget {
  const GoalListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getGoalDocumentsProvider).when(
          data: (goals) {
            return ref.watch(getRealTimeGoalProvider).when(
                  data: (data) {
                    if (data.events.contains(
                        'databases.*.collections.*.documents.*.create')) {
                      goals.insert(0, GoalModel.fromMap(data.payload));
                    }
                    return ListView.builder(
                      itemCount: goals.length,
                      itemBuilder: (context, index) {
                        return Text(
                          goals[index].goal,
                          style: TextStyle(color: Pallete.whiteColor),
                        );
                      },
                    );
                  },
                  error: (error, stackTrace) =>
                      ErrorText(error: error.toString()),
                  loading: () {
                    return ListView.builder(
                      itemCount: goals.length,
                      itemBuilder: (context, index) {
                        return Text(
                          goals[index].goal,
                          style: TextStyle(color: Pallete.whiteColor),
                        );
                      },
                    );
                  },
                );
          },
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => Loader(),
        );
  }
}
