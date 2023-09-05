// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoModel {
  final String todoText;
  final double todoTime;
  final DateTime date;
  final String goalId;
  final bool isDone;
  final String id;
  TodoModel({
    required this.todoText,
    required this.todoTime,
    required this.date,
    required this.goalId,
    required this.isDone,
    required this.id,
  });

  factory TodoModel.initial() {
    return TodoModel(
      todoText: '',
      todoTime: 0,
      date: DateTime.now(),
      goalId: '',
      isDone: false,
      id: '',
    );
  }

  TodoModel copyWith({
    String? todoText,
    double? todoTime,
    DateTime? date,
    String? goalId,
    bool? isDone,
    String? id,
  }) {
    return TodoModel(
      todoText: todoText ?? this.todoText,
      todoTime: todoTime ?? this.todoTime,
      date: date ?? this.date,
      goalId: goalId ?? this.goalId,
      isDone: isDone ?? this.isDone,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'todoText': todoText,
      'todoTime': todoTime,
      'date': date.millisecondsSinceEpoch,
      'goalId': goalId,
      'isDone': isDone,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      todoText: map['todoText'] as String,
      todoTime: (map['todoTime'] as num).toDouble(),
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      goalId: map['goalId'] as String,
      isDone: map['isDone'] as bool,
      id: map['\$id'] as String,
    );
  }

  @override
  String toString() {
    return 'TodoModel(todoText: $todoText, todoTime: $todoTime, date: $date, goalId: $goalId, isDone: $isDone)';
  }
}

class TodoModelNotifier extends StateNotifier<TodoModel> {
  TodoModelNotifier() : super(TodoModel.initial());

  void update_isDone(bool isDone) {
    this.state = state.copyWith(isDone: isDone);
  }
}

final TodoModelNotifierProvider =
    StateNotifierProvider<TodoModelNotifier, TodoModel>((ref) {
  return TodoModelNotifier();
});
