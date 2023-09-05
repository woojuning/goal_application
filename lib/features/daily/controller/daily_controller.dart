import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_goal_app/core/common/show_snackbar.dart';
import 'package:my_goal_app/features/api/daily_api.dart';
import 'package:my_goal_app/features/api/goal_api.dart';
import 'package:my_goal_app/features/api/todo_api.dart';
import 'package:my_goal_app/features/daily/daily_provider/current_date_provider.dart';
import 'package:my_goal_app/models/daily_model.dart';
import 'package:my_goal_app/models/goal_model.dart';
import 'package:my_goal_app/models/todo_model.dart';

final dailyControllerProvider =
    StateNotifierProvider<DailyController, bool>((ref) {
  return DailyController(
    todoAPI: ref.watch(todoAPIProvider),
    dailyAPI: ref.watch(dailyAPIProvider),
    goalAPI: ref.watch(goalAPIProvider),
  );
});

final getTodosByDateAndGoalProvider =
    FutureProvider.family((ref, GoalModel goalModel) {
  final dailyController = ref.watch(dailyControllerProvider.notifier);
  final date = ref.watch(currentDateProvider);
  return dailyController.getTodosByDateAndGoal(
      DateTime(date.year, date.month, date.day), goalModel);
});

final getRealTimeTodoProvider = StreamProvider((ref) {
  final todoAPI = ref.watch(todoAPIProvider);
  return todoAPI.getRealTimeTodo();
});

final getDailyByGoalIdAndDateProvider = FutureProvider((ref) {
  final dailyController = ref.watch(dailyControllerProvider.notifier);
  return dailyController.getDailyByGoalIdAndDate(
      ref.watch(goalModelNotifierProvider), ref.watch(currentDateProvider));
});

class DailyController extends StateNotifier<bool> {
  final TodoAPI todoAPI;
  final DailyAPI dailyAPI;
  final GoalAPI goalAPI;
  DailyController({
    required this.todoAPI,
    required this.dailyAPI,
    required this.goalAPI,
  }) : super(false);

  void createTodo(
    String todoText,
    double todoTime,
    DateTime date,
    GoalModel goalModel,
    BuildContext context,
  ) async {
    final todoModel = TodoModel(
      todoText: todoText,
      todoTime: todoTime,
      date: date,
      goalId: goalModel.id,
      isDone: false,
      id: '',
    );
    final res = await todoAPI.createTodo(todoModel);
    res.fold((l) {
      print(l.message);
    }, (r) {
      print('succes!!');
      Navigator.pop(context);
    });
  }

  Future<List<TodoModel>> getTodosByDateAndGoal(
      DateTime date, GoalModel goalModel) async {
    final documents = await todoAPI.getTodosByDateAndGoal(date, goalModel);
    return documents.map((e) => TodoModel.fromMap(e.data)).toList();
  }

  void createDailyDocument(
      DailyModel dailyModel, GoalModel goalModel, BuildContext context) async {
    final res = await dailyAPI.createDailyDocument(dailyModel);
    res.fold((l) => print(l.message), (r) async {
      showSnackBar('${dailyModel.date}, daily make success!', context);
      final res2 =
          await goalAPI.updateDoTime(goalModel, dailyModel.todaysDotime);
      res2.fold((l) => print(l.message), (r) => print('success!'));
    });
  }

  Future<DailyModel?> getDailyByGoalIdAndDate(
      GoalModel goalModel, DateTime date) async {
    final documents = await dailyAPI.getDailyByGoalIdAndDate(goalModel, date);
    return documents.length == 0
        ? null
        : documents.map((e) => DailyModel.fromMap(e.data)).first;
  }

  //현재 날짜와 목표에 맞는 dailyModel 가져오는 function
  Future<DailyModel> getCurrentDailyDocument(
      GoalModel goalModel, DateTime date) async {
    final documents = await dailyAPI.getCurrentDailyDocument(goalModel, date);

    return documents.map((e) => DailyModel.fromMap(e.data)).first;
  }

  void updateTodo_IsDone(TodoModel todoModel) async {
    final res = await todoAPI.updateTodo_IsDone(todoModel);
    res.fold((l) => null, (r) => null);
  }

  void deleteTodo(TodoModel todoModel) async {
    final res = await todoAPI.deleteTodo(todoModel);
    res.fold((l) => null, (r) => null);
  }

  void updateDailyDocument(DailyModel oldDailyModel, DailyModel newDailyModel,
      GoalModel goalModel) async {
    final res = await dailyAPI.updateDailyDocument(newDailyModel);
    double dotime = 0;
    res.fold((l) => print(l.message), (r) async {
      final updatedDailyModel = DailyModel.fromMap(r.data);

      dotime = updatedDailyModel.todaysDotime - oldDailyModel.todaysDotime;

      final res2 = await goalAPI.updateDoTime(goalModel, dotime);
      res2.fold((l) => print(l.message), (r) => print('res2 success!'));
    });
  }
}
