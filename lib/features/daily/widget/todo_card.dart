import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_goal_app/features/daily/controller/daily_controller.dart';
import 'package:my_goal_app/models/todo_model.dart';
import 'package:my_goal_app/theme/pallete.dart';

class TodoCard extends ConsumerWidget {
  final TodoModel todoModel;
  const TodoCard({super.key, required this.todoModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 7,
      ),
      decoration: BoxDecoration(
        color: todoModel.isDone ? Colors.blueGrey : Colors.blueAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.only(
        left: 10,
        bottom: 5,
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Checkbox(
                  value: todoModel.isDone,
                  onChanged: (value) {
                    ref
                        .read(dailyControllerProvider.notifier)
                        .updateTodo_IsDone(todoModel.copyWith(isDone: value));
                  },
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        child: Text(
                          '${todoModel.todoText}',
                          style: TextStyle(
                            fontSize: 15,
                            color: Pallete.whiteColor,
                          ),
                        ),
                      ),
                      if (todoModel.isDone)
                        Positioned(
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 3,
                            color: Pallete.greyColor.withOpacity(0.8),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              ref.read(dailyControllerProvider.notifier).deleteTodo(todoModel);
            },
            icon: Icon(
              Icons.delete,
              color: Pallete.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
