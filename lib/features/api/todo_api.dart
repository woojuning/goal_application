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
import 'package:my_goal_app/models/todo_model.dart';

final todoAPIProvider = Provider((ref) {
  return TodoAPI(
    db: ref.watch(databasesProvider),
    realtime: ref.watch(realtimeTodoProvider),
  );
});

class TodoAPI {
  final Databases db;
  final Realtime realtime;
  TodoAPI({required this.db, required this.realtime});

  FutureEithervoid createTodo(TodoModel todoModel) async {
    try {
      await db.createDocument(
        databaseId: AppwriteConstants.databasesId,
        collectionId: AppwriteConstants.todoCollectionId,
        documentId: ID.unique(),
        data: todoModel.toMap(),
      );
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(Failure(
          message: e.message ?? 'unkonw error occured', stackTrace: st));
    } catch (e, st) {
      return left(Failure(message: e.toString(), stackTrace: st));
    }
  }

  Future<List<Document>> getTodosByDateAndGoal(
      DateTime date, GoalModel goalModel) async {
    final documents = await db.listDocuments(
      databaseId: AppwriteConstants.databasesId,
      collectionId: AppwriteConstants.todoCollectionId,
      queries: [
        Query.equal('date', date.millisecondsSinceEpoch),
        Query.equal('goalId', goalModel.id),
      ],
    );
    print(documents.documents);
    return documents.documents;
  }

  Stream<RealtimeMessage> getRealTimeTodo() {
    return realtime.subscribe([
      'databases.${AppwriteConstants.databasesId}.collections.${AppwriteConstants.todoCollectionId}.documents'
    ]).stream;
  }

  FutureEithervoid updateTodo_IsDone(TodoModel todoModel) async {
    try {
      await db.updateDocument(
        databaseId: AppwriteConstants.databasesId,
        collectionId: AppwriteConstants.todoCollectionId,
        documentId: todoModel.id,
        data: {
          'isDone': todoModel.isDone,
        },
      );
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(Failure(
          message: e.message ?? 'unkonw error occured', stackTrace: st));
    } catch (e, st) {
      return left(Failure(message: e.toString(), stackTrace: st));
    }
  }

  FutureEithervoid deleteTodo(TodoModel todoModel) async {
    try {
      await db.deleteDocument(
        databaseId: AppwriteConstants.databasesId,
        collectionId: AppwriteConstants.todoCollectionId,
        documentId: todoModel.id,
      );
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(Failure(
          message: e.message ?? 'unkonw error occured', stackTrace: st));
    } catch (e, st) {
      return left(Failure(message: e.toString(), stackTrace: st));
    }
  }
}
