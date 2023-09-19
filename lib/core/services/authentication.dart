
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/views/Screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Auth extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;
  bool get isAuthenticated => currentUser != null;

  Auth() {
    _firebaseAuth.authStateChanges().listen((User? user) {
      notifyListeners();
    });
  }

  Future<String?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // Success, no error
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
    required String userName,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = _firebaseAuth.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
          'FullName': fullName,
          'UserName': userName,
          'Email': email,
          'Password': password,
        });
      }

      return null; // Success, no error
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    notifyListeners();
  }
}

