import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_goal_app/core/common/constants/appwrite_constants.dart';

final clientProvider = Provider((ref) {
  final client = Client();
  return client
      .setEndpoint(AppwriteConstants.endpoint)
      .setProject(AppwriteConstants.projectId)
      .setSelfSigned(status: true);
});

final accountProvider = Provider((ref) {
  return Account(ref.watch(clientProvider));
});

final databasesProvider = Provider((ref) {
  return Databases(ref.watch(clientProvider));
});
