import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_goal_app/features/daily/controller/daily_controller.dart';
import 'package:my_goal_app/models/daily_model.dart';
import 'package:my_goal_app/models/goal_model.dart';
import 'package:my_goal_app/theme/pallete.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ShowGoalWidget extends ConsumerStatefulWidget {
  final GoalModel goalModel;
  const ShowGoalWidget({super.key, required this.goalModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ShowGoalWidgetState();
  }
}

class _ShowGoalWidgetState extends ConsumerState<ShowGoalWidget> {
  final todayDoTimeController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    todayDoTimeController.dispose();
  }

  @override
  void initState() {
    todayDoTimeController.text = '0';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentGoalModel = ref.watch(goalModelNotifierProvider);
    final currentDailyModel =
        ref.watch(getDailyByGoalIdAndDateProvider).value ?? null;
    if (currentDailyModel != null) {
      todayDoTimeController.text = currentDailyModel.todaysDotime.toString();
    }
    return Container(
      margin: EdgeInsets.symmetric().copyWith(top: 10),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      height: 220,
      decoration: BoxDecoration(
        // color: Pallete.greyColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.greenAccent, width: 5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: double.infinity,
            padding: EdgeInsets.only(
              top: 3,
            ),
            child: Row(
              children: [
                Text(
                  '목표 시간 : ${widget.goalModel.amountTime}h',
                  style: TextStyle(
                    color: Pallete.whiteColor,
                    fontSize: 20,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  '노력한 시간 : ${widget.goalModel.doTime}h',
                  style: TextStyle(
                    color: Pallete.whiteColor,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircularPercentIndicator(
                radius: 70,
                lineWidth: 30,
                animation: true,
                percent: currentGoalModel.doTime / currentGoalModel.amountTime,
                progressColor: Colors.greenAccent,
                center: Text(
                  '${widget.goalModel.doTime / widget.goalModel.amountTime * 100}%',
                  style: TextStyle(
                      color: Pallete.whiteColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Container(
                  height: 160,
                  // color: Colors.amber,
                  margin: EdgeInsets.only(
                    left: 20,
                  ),
                  padding: EdgeInsets.only(bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Text(
                              'today time',
                              style: TextStyle(
                                fontSize: 20,
                                color: Pallete.whiteColor,
                              ),
                            ),
                            SizedBox(width: 2),
                            Expanded(
                                child: Container(
                              height: 30,
                              margin: EdgeInsets.only(
                                  // right: 10,
                                  ),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                onSubmitted: (value) {
                                  print('submitted!');
                                },
                                onChanged: (value) {
                                  try {
                                    ref
                                        .read(
                                            dailyModelNotifierProvider.notifier)
                                        .update_todaysDotime(
                                            double.parse(value));
                                  } catch (e) {
                                    print(e.toString());
                                  }
                                },
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold),
                                controller: todayDoTimeController,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: 13, left: 25),
                                  // enabledBorder: OutlineInputBorder(
                                  //   borderSide: BorderSide(
                                  //     color: Pallete.whiteColor,
                                  //   ),
                                  // ),
                                ),
                              ),
                            )),
                            SizedBox(width: 6),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                'h',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Pallete.whiteColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 3,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.add,
                                  size: 30,
                                  color: Pallete.whiteColor,
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Container(
                              width: 70,
                              height: 70,
                              padding: EdgeInsets.only(bottom: 17),
                              decoration: BoxDecoration(
                                color: Colors.pink,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 3,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.minimize,
                                size: 30,
                                color: Pallete.whiteColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
