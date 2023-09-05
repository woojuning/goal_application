import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_goal_app/core/common/error_text.dart';
import 'package:my_goal_app/core/common/loader.dart';
import 'package:my_goal_app/features/api/auth_api.dart';
import 'package:my_goal_app/features/daily/controller/daily_controller.dart';
import 'package:my_goal_app/features/daily/daily_provider/current_date_provider.dart';
import 'package:my_goal_app/features/daily/widget/daily_create_todo_widget.dart';
import 'package:my_goal_app/features/daily/widget/daily_feedback_text.dart';
import 'package:my_goal_app/features/daily/widget/show_goal_widget.dart';
import 'package:my_goal_app/features/goal/controller/goal_controller.dart';
import 'package:my_goal_app/models/daily_model.dart';
import 'package:my_goal_app/models/goal_model.dart';
import 'package:my_goal_app/theme/pallete.dart';

class HomeWidget extends ConsumerStatefulWidget {
  const HomeWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _HomeWidgetState();
  }
}

class _HomeWidgetState extends ConsumerState<HomeWidget> {
  int topflex = 1;
  int bottomflex = 1;
  double dyValue = 200;

  GoalModel? currentGoalModel;

  void onTabSaveButton(WidgetRef ref) async {
    if (currentGoalModel == null) return;

    final user = await ref.read(authAPIProvider).account.get();

    final dailyNotifier = ref.read(dailyModelNotifierProvider.notifier);

    dailyNotifier.update_uid(user.$id);
    dailyNotifier.update_goalId(ref.watch(goalModelNotifierProvider).id);
    dailyNotifier.update_date(ref.watch(currentDateProvider));

    print(ref.watch(dailyModelNotifierProvider).toString());

    final dailyModel = await ref
        .read(dailyControllerProvider.notifier)
        .getDailyByGoalIdAndDate(ref.watch(goalModelNotifierProvider),
            ref.watch(currentDateProvider));
    print(dailyModel.toString());

    if (dailyModel != null) {
      dailyNotifier.update_id(dailyModel.id);
      print('업데이트!');
      print(ref.read(dailyModelNotifierProvider).toString());
      ref.read(dailyControllerProvider.notifier).updateDailyDocument(
          dailyModel, ref.read(dailyModelNotifierProvider), currentGoalModel!);
    } else {
      print('새로 생성!');
      ref.read(dailyControllerProvider.notifier).createDailyDocument(
          ref.read(dailyModelNotifierProvider), currentGoalModel!, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentDate = ref.watch(currentDateProvider);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Pallete.backgroundColor,
        body: ref.watch(getGoalDocumentsProvider).when(
              data: (data) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        backgroundColor: Pallete.backgroundColor,
                        actions: [
                          TextButton.icon(
                              onPressed: () {
                                onTabSaveButton(ref);
                              },
                              icon: Icon(
                                Icons.save,
                                color: Colors.greenAccent,
                              ),
                              label: Text(
                                '저장',
                                style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ],
                        title: GestureDetector(
                          onTap: () async {
                            DateTime date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2010, 01, 01),
                                  lastDate: DateTime(2030, 01, 01),
                                ) ??
                                DateTime.now();
                            print(date);
                            ref
                                .read(currentDateProvider.notifier)
                                .updateDateTime(date);
                          },
                          child: Text(
                            '${currentDate.year}년 ${currentDate.month}월 ${currentDate.day}일',
                            style: TextStyle(
                              color: Pallete.whiteColor,
                            ),
                          ),
                        ),
                        pinned: true,
                      ),
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        toolbarHeight: 20,
                        // backgroundColor: Colors.deepPurple,
                        backgroundColor: Pallete.backgroundColor,
                        flexibleSpace: Container(
                          decoration: BoxDecoration(
                            color: Pallete.backgroundColor,
                            borderRadius: BorderRadius.circular(30),
                            border:
                                Border.all(color: Colors.lightBlue, width: 3),
                          ),
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '목표 : ',
                                style: TextStyle(
                                  color: Pallete.whiteColor,
                                  fontSize: 20,
                                ),
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  focusColor: Colors.black,
                                  iconSize: 25,
                                  hint: Text(
                                    currentGoalModel == null
                                        ? '목표 리스트'
                                        : currentGoalModel!.goal,
                                    style: TextStyle(
                                      color: Pallete.whiteColor,
                                      fontSize: 20,
                                    ),
                                  ),
                                  items: data
                                      // .map((e) => e.goal)
                                      // .toList()
                                      .map((e) => DropdownMenuItem(
                                            child: Text(e.goal),
                                            value: e,
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      currentGoalModel = value;
                                      ref
                                          .read(goalModelNotifierProvider
                                              .notifier)
                                          .update_goalModel(value);
                                      setState(() {});
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (currentGoalModel != null)
                        SliverToBoxAdapter(
                          child: ShowGoalWidget(goalModel: currentGoalModel!),
                        ),
                      if (currentGoalModel != null)
                        SliverToBoxAdapter(
                          child: currentGoalModel == null
                              ? Container()
                              : DailyCreateTodo(
                                  currentDate: currentDate,
                                  currentGoalModel: currentGoalModel!,
                                ),
                        ),
                      if (currentGoalModel != null)
                        SliverToBoxAdapter(
                          child: DailyFeetbackTextWidget(),
                        ),
                    ],
                  ),
                );
              },
              error: (error, stackTrace) => ErrorText(error: error.toString()),
              loading: () => Loader(),
            ),
      ),
    );
  }
}
