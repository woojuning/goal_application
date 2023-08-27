// ignore_for_file: public_member_api_docs, sort_constructors_first

class GoalModel {
  final String goal;
  final int amountTime; //총 실행 할 시간
  final int doTime; // 실제 실행 시간
  final DateTime declarationTime; //목표를 만든 시간
  final String uid;
  GoalModel(
      {required this.goal,
      required this.amountTime,
      required this.doTime,
      required this.declarationTime,
      required this.uid});

  GoalModel copyWith({
    String? goal,
    int? amountTime,
    int? doTime,
    DateTime? declarationTime,
    String? uid,
  }) {
    return GoalModel(
      goal: goal ?? this.goal,
      amountTime: amountTime ?? this.amountTime,
      doTime: doTime ?? this.doTime,
      declarationTime: declarationTime ?? this.declarationTime,
      uid: uid ?? this.uid,
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
      amountTime: map['amountTime'] as int,
      doTime: map['doTime'] as int,
      declarationTime:
          DateTime.fromMillisecondsSinceEpoch(map['declarationTime'] as int),
      uid: map['uid'] as String,
    );
  }
}
