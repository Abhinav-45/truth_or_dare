import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static User? get currentUser => _auth.currentUser;

  Future<bool> signInWithGoogle() async {
    log('Starting Google Sign-In process...');

    try {
      log('Initiating Google Sign-In...');
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(scopes: <String>[
        "email",
        "profile",
      ]).signIn();
      log('Google Sign-In initiated.');

      if (googleUser == null) {
        log('Google Sign-In was canceled by the user.');
        return false;
      }

      log('Google Sign-In successful. User info: {email: ${googleUser.email}, displayName: ${googleUser.displayName}}');

      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;

      log('Google authentication details retrieved: {Access Token: ${googleAuth?.accessToken}, ID Token: ${googleAuth?.idToken}}');

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      log('Firebase credential created with Google credentials.');

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      log('Firebase sign-in successful. User: {uid: ${userCredential.user?.uid}, email: ${userCredential.user?.email}, displayName: ${userCredential.user?.displayName}}');

      await _createOrUpdateUserProfile(userCredential.user!);

      log('User profile successfully created/updated in Firestore for user: ${userCredential.user?.email}');

      return true;
    } catch (e, stackTrace) {
      log('Error during Google Sign-In: $e', error: e, stackTrace: stackTrace);
      return false;
    }
  }

  Future<void> _createOrUpdateUserProfile(User user) async {
    log('Creating or updating Firestore profile for user: {uid: ${user.uid}, email: ${user.email}}');

    final userDoc = _firestore.collection('users').doc(user.uid);

    final Map<String, dynamic> userData = {
      'id': user.uid,
      'name': user.displayName,
      'email': user.email,
      'photoUrl': user.photoURL,
      'lastUpdated': FieldValue.serverTimestamp(),
    };

    log('Prepared user data for Firestore: $userData');

    try {
      await userDoc.set(userData, SetOptions(merge: true));
      log('Firestore profile created/updated successfully for user: ${user.email}');
    } catch (e, stackTrace) {
      log('Error creating/updating Firestore profile: $e',
          error: e, stackTrace: stackTrace);
    }
  }

  Future<Map<String, dynamic>?> getUserProfile() async {
    if (currentUser == null) {
      log('No current user found for fetching profile.');
      return null;
    }

    log('Fetching profile for user: ${currentUser!.email}');

    try {
      final DocumentSnapshot docSnapshot =
          await _firestore.collection('users').doc(currentUser!.uid).get();
      final data = docSnapshot.data() as Map<String, dynamic>?;

      if (data != null) {
        log('User profile data retrieved: $data');
      } else {
        log('No profile data found for user: ${currentUser!.email}');
      }

      return data;
    } catch (e, stackTrace) {
      log('Error fetching user profile: $e', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  Future<void> signOut(BuildContext context) async {
    log('Signing out the user...');

    try {
      await GoogleSignIn().signOut();
      await _auth.signOut();
      context.go('/login');
      log('User signed out successfully.');
    } catch (e, stackTrace) {
      log('Error during sign-out: $e', error: e, stackTrace: stackTrace);
    }
  }

  Future<bool> isUserLoggedIn() async {
    final isLoggedIn = _auth.currentUser != null;
    log('Checking if user is logged in: $isLoggedIn');
    return isLoggedIn;
  }
}
