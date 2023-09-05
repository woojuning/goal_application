import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_goal_app/models/daily_model.dart';
import 'package:my_goal_app/theme/pallete.dart';

class DailyFeetbackTextWidget extends ConsumerStatefulWidget {
  const DailyFeetbackTextWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DailyFeetbackTextWidgetState();
}

class _DailyFeetbackTextWidgetState
    extends ConsumerState<DailyFeetbackTextWidget> {
  final disappointingTextController = TextEditingController();
  final feedbackTextController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    disappointingTextController.dispose();
    feedbackTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(
            10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.grey, width: 5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '아쉬운 점',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 20,
                ),
              ),
              TextField(
                onChanged: (value) {
                  ref
                      .read(dailyModelNotifierProvider.notifier)
                      .update_disappointingText(value);
                },
                controller: disappointingTextController,
                style: TextStyle(color: Pallete.whiteColor),
                decoration: InputDecoration(
                    hintText: 'write here',
                    hintStyle: TextStyle(
                      color: Pallete.greyColor,
                    )),
                maxLines: null,
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(
            10,
          ),
          margin: EdgeInsets.only(
            top: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.grey, width: 5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '피드백 일기',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 20,
                ),
              ),
              TextField(
                onChanged: (value) {
                  ref
                      .read(dailyModelNotifierProvider.notifier)
                      .update_feedbackText(value);
                },
                controller: feedbackTextController,
                style: TextStyle(color: Pallete.whiteColor),
                decoration: InputDecoration(
                    hintText: 'write here',
                    hintStyle: TextStyle(
                      color: Pallete.greyColor,
                    )),
                maxLines: null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
