import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_goal_app/features/goal/controller/goal_controller.dart';
import 'package:my_goal_app/models/goal_model.dart';
import 'package:my_goal_app/theme/pallete.dart';

class DotimeEditDialog extends ConsumerStatefulWidget {
  final GoalModel goalModel;
  const DotimeEditDialog({super.key, required this.goalModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      DotimeEditDialogState();
}

class DotimeEditDialogState extends ConsumerState<DotimeEditDialog> {
  final doTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    doTimeController.text = widget.goalModel.doTime.toString();
  }

  @override
  void dispose() {
    super.dispose();
    doTimeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        width: MediaQuery.of(context).size.width * 0.4,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              height: 50,
              child: IconButton(
                  color: Colors.red,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close)),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 20,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '진행 시간 : ',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 40,
                    child: TextField(
                      controller: doTimeController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Pallete.greyColor,
                          ),
                        ),
                      ),
                      style: TextStyle(
                        color: Pallete.blueColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Text(
                    ' h',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      doTimeController.text =
                          (double.parse(doTimeController.text) + 0.5)
                              .toString();
                    },
                    child: Text('+ 30min')),
                ElevatedButton(
                    onPressed: () {
                      doTimeController.text =
                          (double.parse(doTimeController.text) + 1).toString();
                    },
                    child: Text('+ 1hour')),
              ],
            ),
            SizedBox(height: 20),
            Container(
                margin: EdgeInsets.only(
                  right: 20,
                ),
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    onPressed: () {
                      ref.read(goalControllerProvider.notifier).updateDoTime(
                          widget.goalModel,
                          double.parse(doTimeController.text));
                      Navigator.pop(context);
                    },
                    child: Text('save'))),
          ],
        ),
      ),
    );
  }
}
