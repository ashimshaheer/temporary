import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  Future<Map<String, dynamic>?> getUserDetails() async {
    try {
      // Get the current user's UID
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print("No user is currently logged in.");
        return null;
      }
      String uid = currentUser.uid;

      // Retrieve user data from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        // Convert the document data to a map and return it
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        print("User data: $userData");
        return userData;
      } else {
        print("User document does not exist.");
        return null;
      }
    } catch (error) {
      print("Failed to get user details: $error");
      return null;
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> registration({required String email, required String password, required String name}) async {
    try {
      // Register user in Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get user ID
      String uid = userCredential.user!.uid;

      // Store user data in Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'uid': uid,
        'email': email,
        'name': name,
        'createdAt': Timestamp.now(),
        // Add any other fields you want to store for the user
      });

      print("User registered and data saved to Firestore");
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      // Initiate Google Sign-In
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        print("Google sign-in was cancelled by the user.");
        return;
      }

      // Obtain Google Sign-In authentication
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential using Google Auth
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase using Google credentials
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        String uid = user.uid;
        String email = user.email ?? "";
        String name = user.displayName ?? "Unnamed";

        // Store user data in Firestore
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'uid': uid,
          'email': email,
          'name': name,
          'createdAt': Timestamp.now(),
        }, SetOptions(merge: true));

        print("User signed in and data stored in Firestore successfully.");
      }
    } on Exception catch (e) {
      print('Error during Google Sign-In and Firestore update: $e');
    }
  }

  Future<String?> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return 'Success';
    } on FirebaseAuthException catch (e) {
      log('eeeeror${e.code}');
      // if (e.code == 'weak-password') {
      //   return 'The password provided is too weak.';
      // } else if (e.code == 'email-already-in-use') {
      //   return 'The account already exists for that email.';
      // } else {
      //   return e.message;
      // }
    } catch (e) {
      return e.toString();
    }
    return null;
  }
}
