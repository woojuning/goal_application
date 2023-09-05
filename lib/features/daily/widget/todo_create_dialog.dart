// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_goal_app/features/daily/controller/daily_controller.dart';
import 'package:my_goal_app/features/daily/daily_provider/current_date_provider.dart';

import 'package:my_goal_app/models/goal_model.dart';
import 'package:my_goal_app/theme/pallete.dart';

class TodoCreateDialog extends ConsumerStatefulWidget {
  final GoalModel currentGoalModel;
  final DateTime currentDate;
  const TodoCreateDialog({
    required this.currentGoalModel,
    required this.currentDate,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      TodoCreateDialogState();
}

class TodoCreateDialogState extends ConsumerState<TodoCreateDialog> {
  final todoTextController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    todoTextController.dispose();
  }

  double time = 0;

  void addTime() {
    setState(() {
      time++;
    });
  }

  void minusTime() {
    setState(() {
      time--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Pallete.whiteColor,
            borderRadius: BorderRadius.circular(
              20,
            )),
        child: Container(
          margin: EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Todo',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: TextField(
                    controller: todoTextController,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'todo : ',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 5),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '목표 시간 : ',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Text(
                      ' ${time} h',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    IconButton(
                      onPressed: () {
                        addTime();
                      },
                      icon: Icon(
                        Icons.plus_one,
                        color: Colors.blue,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        minusTime();
                      },
                      icon: Icon(
                        Icons.exposure_minus_1,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      final cd = ref.watch(currentDateProvider);
                      final DateTime date = DateTime(cd.year, cd.month, cd.day);
                      print(cd);
                      print(date);
                      ref.read(dailyControllerProvider.notifier).createTodo(
                            todoTextController.text,
                            time,
                            date,
                            widget.currentGoalModel,
                            context,
                          );
                    },
                    child: Text(
                      'create',
                      style: TextStyle(color: Pallete.whiteColor),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                      Colors.black,
                    ))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
