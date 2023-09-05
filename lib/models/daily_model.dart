// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_riverpod/flutter_riverpod.dart';

class DailyModel {
  final double todaysDotime; //오늘 목표 할애 시간
  final String uid;
  final String goalId;
  final DateTime date;
  final String feedbackText;
  final String disappointingText;
  final String id;
  DailyModel({
    required this.todaysDotime,
    required this.uid,
    required this.goalId,
    required this.date,
    required this.feedbackText,
    required this.disappointingText,
    required this.id,
  });

  factory DailyModel.initial() {
    final date = DateTime.now();
    return DailyModel(
      todaysDotime: 0,
      uid: '',
      goalId: '',
      date: DateTime(date.year, date.month, date.day),
      feedbackText: '',
      disappointingText: '',
      id: '',
    );
  }

  DailyModel copyWith({
    double? todaysDotime,
    String? uid,
    String? goalId,
    DateTime? date,
    String? feedbackText,
    String? disappointingText,
    String? id,
  }) {
    return DailyModel(
      todaysDotime: todaysDotime ?? this.todaysDotime,
      uid: uid ?? this.uid,
      goalId: goalId ?? this.goalId,
      date: date ?? this.date,
      feedbackText: feedbackText ?? this.feedbackText,
      disappointingText: disappointingText ?? this.disappointingText,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'todaysDotime': todaysDotime,
      'uid': uid,
      'goalId': goalId,
      'date': date.millisecondsSinceEpoch,
      'feedbackText': feedbackText,
      'disappointingText': disappointingText,
    };
  }

  factory DailyModel.fromMap(Map<String, dynamic> map) {
    return DailyModel(
      todaysDotime: (map['todaysDotime'] as num).toDouble(),
      uid: map['uid'] as String,
      goalId: map['goalId'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      feedbackText: map['feedbackText'] as String,
      disappointingText: map['disappointingText'] as String,
      id: map['\$id'] as String,
    );
  }

  @override
  String toString() {
    return 'DailyModel(todaysDotime: $todaysDotime, uid: $uid, goalId: $goalId, date: $date, feedbackText: $feedbackText, disappointingText: $disappointingText, id : $id)';
  }

  @override
  bool operator ==(covariant DailyModel other) {
    if (identical(this, other)) return true;

    return other.todaysDotime == todaysDotime &&
        other.uid == uid &&
        other.goalId == goalId &&
        other.date == date &&
        other.feedbackText == feedbackText &&
        other.disappointingText == disappointingText;
  }

  @override
  int get hashCode {
    return todaysDotime.hashCode ^
        uid.hashCode ^
        goalId.hashCode ^
        date.hashCode ^
        feedbackText.hashCode ^
        disappointingText.hashCode;
  }
}

class DailyModelNotifier extends StateNotifier<DailyModel> {
  DailyModelNotifier() : super(DailyModel.initial());

  void update_goalId(String goalId) {
    this.state = state.copyWith(goalId: goalId);
  }

  void update_todaysDotime(double dotime) {
    this.state = state.copyWith(todaysDotime: dotime);
  }

  void update_uid(String uid) {
    this.state = state.copyWith(uid: uid);
  }

  void update_date(DateTime date) {
    this.state = state.copyWith(date: date);
  }

  void update_feedbackText(String text) {
    this.state = state.copyWith(feedbackText: text);
  }

  void update_disappointingText(String text) {
    this.state = state.copyWith(disappointingText: text);
  }

  void update_id(String text) {
    this.state = state.copyWith(id: text);
  }

  void update_dailyModel(DailyModel dailyModel) {
    this.state = dailyModel;
  }
}

final dailyModelNotifierProvider =
    StateNotifierProvider<DailyModelNotifier, DailyModel>((ref) {
  return DailyModelNotifier();
});
