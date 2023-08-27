// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:my_goal_app/core/common/constants/appwrite_constants.dart';
import 'package:my_goal_app/core/common/failure.dart';
import 'package:my_goal_app/core/common/provider/appwrite_provider.dart';
import 'package:my_goal_app/core/common/type_def.dart';
import 'package:my_goal_app/models/goal_model.dart';
import 'package:my_goal_app/models/user_model.dart';

final goalAPIProvider = Provider((ref) {
  return GoalAPI(
      db: ref.watch(databasesProvider),
      realtime: ref.watch(realtimeProvider),
      account: ref.watch(accountProvider));
});

class GoalAPI {
  final Databases db;
  final Realtime realtime;
  final Account account;
  GoalAPI({required this.db, required this.realtime, required this.account});

  FutureEithervoid createGoalDocument(GoalModel goalModel) async {
    try {
      await db.createDocument(
        databaseId: AppwriteConstants.databasesId,
        collectionId: AppwriteConstants.goalCollectionId,
        documentId: ID.unique(),
        data: goalModel.toMap(),
      );
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(Failure(
          message: e.message ?? 'unkonw error occured', stackTrace: st));
    } catch (e, st) {
      return left(Failure(message: e.toString(), stackTrace: st));
    }
  }

  Stream<RealtimeMessage> getRealTimeGoal() {
    return realtime.subscribe([
      'databases.${AppwriteConstants.databasesId}.collections.${AppwriteConstants.goalCollectionId}.documents',
    ]).stream;
  }

  Future<List<Document>> getGoalDocuments() async {
    final currentUser = await account.get();
    final documents = await db.listDocuments(
        databaseId: AppwriteConstants.databasesId,
        collectionId: AppwriteConstants.goalCollectionId,
        queries: [
          Query.equal('uid', currentUser.$id),
        ]);
    return documents.documents;
  }
}
