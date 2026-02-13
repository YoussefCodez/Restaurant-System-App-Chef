import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_chef/core/models/chef_model.dart';
import 'package:food_chef/core/entities/chef_entity.dart';
import 'package:food_chef/auth/domain/repositories/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRepoImpl(this._firebaseAuth, this._firestore);

  @override
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser;
    });
  }

  @override
  Future<ChefEntity> signUp({
    required ChefEntity chefEntity,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: chefEntity.email,
        password: password,
      );
      ChefModel newChefModel = ChefModel.empty.copyWith(
        uid: credential.user!.uid,
        email: chefEntity.email,
        name: chefEntity.name,
        phoneNumber: chefEntity.phoneNumber,
        address: chefEntity.address,
      );
      await _firestore
          .collection("chefs")
          .doc(credential.user!.uid)
          .set(newChefModel.toDocument());
      return ChefEntity(
        name: newChefModel.name!,
        email: newChefModel.email!,
        phoneNumber: newChefModel.phoneNumber!,
        address: newChefModel.address!,
      );
    } catch (e) {
      throw _handleException(e);
    }
  }

  @override
  Future<ChefEntity> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final newChefModel = await _firestore
          .collection("chefs")
          .doc(credential.user!.uid)
          .get();
      ChefModel chefModel = ChefModel.fromDocument(newChefModel);
      return ChefEntity(
        name: chefModel.name!,
        email: chefModel.email!,
        phoneNumber: chefModel.phoneNumber!,
        address: chefModel.address!,
      );
    } catch (e) {
      throw _handleException(e);
    }
  }

  @override
  Future<void> logOut() {
    return _firebaseAuth.signOut();
  }

  String _handleException(dynamic e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found':
          return 'No user found for that email.';
        case 'wrong-password':
          return 'Wrong password provided for that user.';
        case 'invalid-email':
          return 'The email address is badly formatted.';
        case 'email-already-in-use':
          return 'The account already exists for that email.';
        case 'weak-password':
          return 'The password provided is too weak.';
        case 'invalid-credential':
          return 'Invalid email or password.';
        case 'network-request-failed':
          return 'Please check your internet connection.';
        case 'too-many-requests':
          return 'Too many attempts. Please try again later.';
        default:
          return e.message ?? 'An authentication error occurred.';
      }
    } else if (e.toString().contains('SocketException') ||
        e.toString().contains('network_error') ||
        e.toString().contains('connectivity')) {
      return 'Please check your internet connection.';
    }
    return 'An unexpected error occurred: ${e.toString()}';
  }
}
