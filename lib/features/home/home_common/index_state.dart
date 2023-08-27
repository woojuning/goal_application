import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabIndex extends StateNotifier<int> {
  TabIndex() : super(0);
  void changeIndex(int index) {
    state = index;
  }
}

final tabIndexProvider = StateNotifierProvider<TabIndex, int>((ref) {
  return TabIndex();
});
