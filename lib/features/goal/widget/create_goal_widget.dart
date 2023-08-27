import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_goal_app/features/auth/controller/auth_controller.dart';
import 'package:my_goal_app/features/goal/controller/goal_controller.dart';
import 'package:my_goal_app/theme/pallete.dart';

class CreateGaolWidget extends ConsumerStatefulWidget {
  const CreateGaolWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateGaolWidgetState();
}

class _CreateGaolWidgetState extends ConsumerState<CreateGaolWidget> {
  final goalController = TextEditingController();
  final timeController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    goalController.dispose();
    timeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserModel = ref.watch(getCurrentUserProvider).value;
    return currentUserModel == null
        ? Container()
        : Dialog(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                color: Pallete.whiteColor,
                borderRadius: BorderRadius.circular(20),
              ),
              height: MediaQuery.of(context).size.height - 200,
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Goal : ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextField(
                    controller: goalController,
                    maxLines: null,
                    decoration: InputDecoration(
                        hintText: '목표',
                        hintStyle: TextStyle(
                          color: Pallete.greyColor,
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '목표 설정 시간 : (시간 기준)',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextField(
                    controller: timeController,
                    keyboardType: TextInputType.number,
                    maxLines: null,
                    decoration: InputDecoration(
                        hintText: '시간',
                        hintStyle: TextStyle(
                          color: Pallete.greyColor,
                        )),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        ref
                            .read(goalControllerProvider.notifier)
                            .createGoalDocument(goalController.text,
                                timeController.text, currentUserModel, context);
                      },
                      child: Text('목표 만들기')),
                ],
              ),
            ),
          );
  }
}
