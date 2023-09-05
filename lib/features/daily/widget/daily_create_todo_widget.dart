import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_goal_app/core/common/error_text.dart';
import 'package:my_goal_app/core/common/loader.dart';
import 'package:my_goal_app/core/common/show_snackbar.dart';
import 'package:my_goal_app/features/daily/controller/daily_controller.dart';
import 'package:my_goal_app/features/daily/daily_provider/current_date_provider.dart';
import 'package:my_goal_app/features/daily/widget/todo_card.dart';
import 'package:my_goal_app/features/daily/widget/todo_create_dialog.dart';
import 'package:my_goal_app/models/goal_model.dart';
import 'package:my_goal_app/models/todo_model.dart';
import 'package:my_goal_app/theme/pallete.dart';

class DailyCreateTodo extends ConsumerStatefulWidget {
  final GoalModel currentGoalModel;
  final DateTime currentDate;
  const DailyCreateTodo({
    super.key,
    required this.currentDate,
    required this.currentGoalModel,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DailyCreateTodoState();
}

class _DailyCreateTodoState extends ConsumerState<DailyCreateTodo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.amber, width: 5),
          // color: Colors.amber,
          borderRadius: BorderRadius.circular(30)),
      height: 200,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              alignment: Alignment.topCenter,
              height: 50,
              margin: EdgeInsets.only(
                left: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '목표에 대한 todo',
                    style: TextStyle(
                      color: Pallete.whiteColor,
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    highlightColor: Colors.yellow.withOpacity(0.3),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return TodoCreateDialog(
                                currentGoalModel: widget.currentGoalModel,
                                currentDate: widget.currentDate);
                          });
                    },
                    icon: Icon(
                      Icons.add,
                      color: Pallete.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ref
              .watch(getTodosByDateAndGoalProvider(
                  ref.watch(goalModelNotifierProvider)))
              .when(
                data: (todos) {
                  return ref.watch(getRealTimeTodoProvider).when(
                        data: (data) {
                          final newTodo = TodoModel.fromMap(data.payload);

                          if (data.events.contains(
                              'databases.*.collections.*.documents.*.create')) {
                            //create

                            if (todos
                                        .where((element) =>
                                            element.id ==
                                            TodoModel.fromMap(data.payload).id)
                                        .length ==
                                    0 &&
                                ref.watch(currentDateProvider) ==
                                    TodoModel.fromMap(data.payload).date &&
                                ref.watch(goalModelNotifierProvider).id ==
                                    TodoModel.fromMap(data.payload).goalId) {
                              todos.insert(0, TodoModel.fromMap(data.payload));
                            }
                          } else if (data.events.contains(
                              'databases.*.collections.*.documents.*.update')) {
                            //update
                            final oldTodo = todos
                                .where((element) => element.id == newTodo.id)
                                .first;
                            final index = todos.indexOf(oldTodo);

                            todos.removeAt(index);
                            todos.insert(index, newTodo);
                          } else if (data.events.contains(
                              'databases.*.collections.*.documents.*.delete')) {
                            try {
                              final oldTodo = todos
                                  .where((element) => element.id == newTodo.id)
                                  .first;
                              final index = todos.indexOf(oldTodo);
                              todos.removeAt(index);
                            } catch (e) {}
                          }
                          return SliverList(
                              delegate: SliverChildBuilderDelegate(
                            childCount: todos.length,
                            (context, index) {
                              return TodoCard(todoModel: todos[index]);
                            },
                          ));
                        },
                        error: (error, stackTrace) => SliverToBoxAdapter(
                            child: ErrorText(error: error.toString())),
                        loading: () {
                          return SliverList(
                              delegate: SliverChildBuilderDelegate(
                            childCount: todos.length,
                            (context, index) {
                              return TodoCard(todoModel: todos[index]);
                            },
                          ));
                        },
                      );
                },
                error: (error, stackTrace) => SliverToBoxAdapter(
                    child: ErrorText(error: error.toString())),
                loading: () => SliverToBoxAdapter(child: Loader()),
              ),
        ],
      ),
    );
  }
}
