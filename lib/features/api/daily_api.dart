import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:my_goal_app/core/common/constants/appwrite_constants.dart';
import 'package:my_goal_app/core/common/failure.dart';
import 'package:my_goal_app/core/common/provider/appwrite_provider.dart';
import 'package:my_goal_app/core/common/type_def.dart';
import 'package:my_goal_app/models/daily_model.dart';
import 'package:my_goal_app/models/goal_model.dart';

final dailyAPIProvider = Provider((ref) {
  return DailyAPI(db: ref.watch(databasesProvider));
});

class DailyAPI {
  final Databases db;

  DailyAPI({required this.db});

  FutureEithervoid createDailyDocument(DailyModel dailyModel) async {
    try {
      await db.createDocument(
        databaseId: AppwriteConstants.databasesId,
        collectionId: AppwriteConstants.dailysCollectionId,
        documentId: ID.unique(),
        data: dailyModel.toMap(),
      );
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(Failure(
          message: e.message ?? 'unkonw error occured', stackTrace: st));
    } catch (e, st) {
      return left(Failure(message: e.toString(), stackTrace: st));
    }
  }

  Future<List<Document>> getDailyByGoalIdAndDate(
      GoalModel goalModel, DateTime date) async {
    final documents = await db.listDocuments(
        databaseId: AppwriteConstants.databasesId,
        collectionId: AppwriteConstants.dailysCollectionId,
        queries: [
          Query.equal('goalId', goalModel.id),
          Query.equal('date', date.millisecondsSinceEpoch),
        ]);
    return documents.documents;
  }

  FutureEither<Document> updateDailyDocument(DailyModel dailyModel) async {
    try {
      final document = await db.updateDocument(
        databaseId: AppwriteConstants.databasesId,
        collectionId: AppwriteConstants.dailysCollectionId,
        documentId: dailyModel.id,
        data: dailyModel.toMap(),
      );
      final model = DailyModel.fromMap(document.data);
      print(model.toString());
      return right(document);
    } on AppwriteException catch (e, st) {
      return left(Failure(
          message: e.message ?? 'unkonw error occured', stackTrace: st));
    } catch (e, st) {
      return left(Failure(message: e.toString(), stackTrace: st));
    }
  }

  Future<List<Document>> getCurrentDailyDocument(
      GoalModel goalModel, DateTime date) async {
    final documents = await db.listDocuments(
      databaseId: AppwriteConstants.dailysCollectionId,
      collectionId: AppwriteConstants.dailysCollectionId,
      queries: [
        Query.equal('goalId', goalModel.id),
        Query.equal('date', date.millisecondsSinceEpoch),
      ],
    );
    return documents.documents;
  }
}
