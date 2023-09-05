// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_riverpod/flutter_riverpod.dart';

class GoalModel {
  final String goal;
  final double amountTime; //총 실행 할 시간
  final double doTime; // 실제 실행 시간
  final DateTime declarationTime; //목표를 만든 시간
  final String uid;
  final String id;
  GoalModel({
    required this.goal,
    required this.amountTime,
    required this.doTime,
    required this.declarationTime,
    required this.uid,
    required this.id,
  });

  factory GoalModel.initial() {
    return GoalModel(
      goal: '',
      amountTime: 0,
      doTime: 0,
      declarationTime: DateTime.now(),
      uid: '',
      id: '',
    );
  }

  GoalModel copyWith({
    String? goal,
    double? amountTime,
    double? doTime,
    DateTime? declarationTime,
    String? uid,
    String? id,
  }) {
    return GoalModel(
      goal: goal ?? this.goal,
      amountTime: amountTime ?? this.amountTime,
      doTime: doTime ?? this.doTime,
      declarationTime: declarationTime ?? this.declarationTime,
      uid: uid ?? this.uid,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'goal': goal,
      'amountTime': amountTime,
      'doTime': doTime,
      'declarationTime': declarationTime.millisecondsSinceEpoch,
      'uid': uid,
    };
  }

  factory GoalModel.fromMap(Map<String, dynamic> map) {
    return GoalModel(
      goal: map['goal'] as String,
      amountTime: (map['amountTime'] as num).toDouble(),
      doTime: (map['doTime'] as num).toDouble(),
      declarationTime:
          DateTime.fromMillisecondsSinceEpoch(map['declarationTime'] as int),
      uid: map['uid'] as String,
      id: map['\$id'] as String,
    );
  }
}

class GoalModelNotifier extends StateNotifier<GoalModel> {
  GoalModelNotifier() : super(GoalModel.initial());

  void update_goalModel(GoalModel goalModel) {
    state = goalModel;
  }
}

final goalModelNotifierProvider =
    StateNotifierProvider<GoalModelNotifier, GoalModel>((ref) {
  return GoalModelNotifier();
});
