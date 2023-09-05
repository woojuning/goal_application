import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_goal_app/core/common/show_snackbar.dart';
import 'package:my_goal_app/features/api/goal_api.dart';
import 'package:my_goal_app/models/goal_model.dart';
import 'package:my_goal_app/models/user_model.dart';

final goalControllerProvider =
    StateNotifierProvider<GoalController, bool>((ref) {
  return GoalController(goalAPI: ref.watch(goalAPIProvider));
});

final getRealTimeGoalProvider = StreamProvider((ref) {
  final goalAPI = ref.watch(goalAPIProvider);
  return goalAPI.getRealTimeGoal();
});

final getGoalDocumentsProvider = FutureProvider((ref) {
  final goalController = ref.watch(goalControllerProvider.notifier);
  return goalController.getGoalDocuments();
});

class GoalController extends StateNotifier<bool> {
  final GoalAPI goalAPI;
  GoalController({required this.goalAPI}) : super(false);

  void createGoalDocument(String goal, String amountTime,
      UserModel currentUserModel, BuildContext context) async {
    final goalModel = GoalModel(
      goal: goal,
      amountTime: double.parse(amountTime),
      doTime: 0,
      declarationTime: DateTime.now(),
      uid: currentUserModel.uid,
      id: '',
    );
    final res = await goalAPI.createGoalDocument(goalModel);
    res.fold((l) {
      showSnackBar(l.message, context);
      print(l.message);
    }, (r) {
      Navigator.pop(context);
    });
  }

  Future<List<GoalModel>> getGoalDocuments() async {
    final documents = await goalAPI.getGoalDocuments();
    return documents.map((e) => GoalModel.fromMap(e.data)).toList();
  }

  void updateDoTime(GoalModel goalModel, double doTime) async {
    final res = await goalAPI.updateDoTime(goalModel, doTime);
    res.fold((l) => print(l.message), (r) => null);
  }

  void deleteGoalModel(GoalModel goalModel) async {
    final res = await goalAPI.deleteGoalModel(goalModel);
    res.fold((l) => null, (r) => null);
  }
}
