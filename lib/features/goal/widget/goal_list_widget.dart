import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_goal_app/core/common/error_text.dart';
import 'package:my_goal_app/core/common/loader.dart';
import 'package:my_goal_app/features/goal/controller/goal_controller.dart';
import 'package:my_goal_app/features/goal/widget/goal_card_widget.dart';
import 'package:my_goal_app/models/goal_model.dart';

class GoalListWidget extends ConsumerWidget {
  List<GoalModel> currentGoalModelList = [];
  GoalListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getGoalDocumentsProvider).when(
          data: (goals) {
            currentGoalModelList = goals;
            return ref.watch(getRealTimeGoalProvider).when(
                  data: (data) {
                    final newGoal = GoalModel.fromMap(data.payload);
                    if (data.events.contains(
                        'databases.*.collections.*.documents.*.create')) {
                      if (currentGoalModelList
                              .where((element) =>
                                  element.id ==
                                  GoalModel.fromMap(data.payload).id)
                              .length ==
                          0) {
                        currentGoalModelList.insert(
                            0, GoalModel.fromMap(data.payload));
                      }
                    } else if (data.events.contains(
                        'databases.*.collections.*.documents.*.update')) {
                      final oldGoal = currentGoalModelList
                          .where((element) => element.id == newGoal.id)
                          .first;
                      final goalIndex = currentGoalModelList.indexOf(oldGoal);
                      goals.removeAt(goalIndex);
                      goals.insert(goalIndex, newGoal);
                    } else if (data.events.contains(
                        'databases.*.collections.*.documents.*.delete')) {
                      final oldGoal = currentGoalModelList
                          .where((element) => element.id == newGoal.id)
                          .first;
                      final goalIndex = currentGoalModelList.indexOf(oldGoal);
                      goals.removeAt(goalIndex);
                    }
                    return ListView.builder(
                      itemCount: currentGoalModelList.length,
                      itemBuilder: (context, index) {
                        return GoalCard(goalModel: currentGoalModelList[index]);
                      },
                    );
                  },
                  error: (error, stackTrace) =>
                      ErrorText(error: error.toString()),
                  loading: () {
                    return ListView.builder(
                      itemCount: currentGoalModelList.length,
                      itemBuilder: (context, index) {
                        return GoalCard(goalModel: currentGoalModelList[index]);
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
