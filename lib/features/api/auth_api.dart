// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:my_goal_app/core/common/constants/appwrite_constants.dart';
import 'package:my_goal_app/core/common/failure.dart';
import 'package:my_goal_app/core/common/provider/appwrite_provider.dart';
import 'package:my_goal_app/core/common/type_def.dart';
import 'package:my_goal_app/models/user_model.dart';

final authAPIProvider = Provider((ref) {
  return AuthAPI(
    account: ref.watch(accountProvider),
    db: ref.watch(databasesProvider),
  );
});

class AuthAPI {
  final Account account;
  final Databases db;
  AuthAPI({required this.account, required this.db});

  FutureEither<User> createAccount(String email, String password) async {
    try {
      final user = await account.create(
          userId: ID.unique(), email: email, password: password);
      return right(user);
    } on AppwriteException catch (e, st) {
      return left(Failure(
          message: e.message ?? 'unkonw error occured', stackTrace: st));
    } catch (e, st) {
      return left(Failure(message: e.toString(), stackTrace: st));
    }
  }

  FutureEithervoid createUserDocument(UserModel userModel) async {
    try {
      await db.createDocument(
        databaseId: AppwriteConstants.databasesId,
        collectionId: AppwriteConstants.userCollectionId,
        documentId: ID.unique(),
        data: userModel.toMap(),
      );
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(Failure(
          message: e.message ?? 'unkonw error occured', stackTrace: st));
    } catch (e, st) {
      return left(Failure(message: e.toString(), stackTrace: st));
    }
  }

  FutureEithervoid login(String email, String password) async {
    try {
      await account.createEmailSession(email: email, password: password);
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(Failure(
          message: e.message ?? 'unkonw error occured', stackTrace: st));
    } catch (e, st) {
      return left(Failure(message: e.toString(), stackTrace: st));
    }
  }

  Future<Session?> checkLoginSession() async {
    final Session? session = await account.getSession(sessionId: 'current');
    return session;
  }

  Future<Document> getCurrentUser() async {
    final user = await account.get();
    final document = await db.listDocuments(
        databaseId: AppwriteConstants.databasesId,
        collectionId: AppwriteConstants.userCollectionId,
        queries: [
          Query.equal('uid', user.$id),
        ]);
    return document.documents.first;
  }
}
