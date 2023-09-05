import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_goal_app/features/goal/controller/goal_controller.dart';
import 'package:my_goal_app/features/goal/widget/goal_dotime_edit_widget.dart';
import 'package:my_goal_app/models/goal_model.dart';
import 'package:my_goal_app/theme/pallete.dart';
import 'package:percent_indicator/percent_indicator.dart';

class GoalCard extends ConsumerWidget {
  final GoalModel goalModel;
  const GoalCard({super.key, required this.goalModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.all(
        10,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Pallete.greyColor,
          ),
          top: BorderSide(
            color: Pallete.greyColor,
          ),
        ),
      ),
      height: 150,
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                goalModel.goal,
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '목표 시간 : ${goalModel.amountTime}h',
                style: TextStyle(
                  color: Pallete.whiteColor,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DotimeEditDialog(
                        goalModel: goalModel,
                      );
                    },
                  );
                },
                child: Text(
                  '진행 시간 : ${goalModel.doTime}h',
                  style: TextStyle(
                    color: Pallete.whiteColor,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              top: 10,
            ),
            child: LinearPercentIndicator(
              barRadius: Radius.circular(30),
              backgroundColor: Pallete.greyColor,
              progressColor: Colors.greenAccent,
              lineHeight: 30,
              animation: true,
              percent: (goalModel.doTime / goalModel.amountTime),
              center: Text(
                  '${(goalModel.doTime / goalModel.amountTime) * 100.0} %'),
              trailing: Text(
                '${goalModel.doTime} / ${goalModel.amountTime}',
                style: TextStyle(
                  color: Pallete.whiteColor,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit),
                  color: Pallete.whiteColor),
              IconButton(
                onPressed: () {
                  ref
                      .read(goalControllerProvider.notifier)
                      .deleteGoalModel(goalModel);
                },
                icon: Icon(
                  Icons.delete,
                  color: Pallete.whiteColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
