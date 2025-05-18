import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import '../handle/firebase_exceptionhandler.dart';
import '../models/user_model.dart';
import 'user_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get authUser => _auth.currentUser;

  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      // Create a new user with email and password
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  Future<UserModel> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return await UserService().fetchUserdetails(userCredential.user!.uid);
    } catch (e) {
      log(ExceptionHandler.handleException(e));
      return UserModel.empty();
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  Future<void> userLogout() async {
    try {
      log(_auth.currentUser!.uid.toString());
      await _auth.signOut();
      // await _googleSignIn.signOut();
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }
}
