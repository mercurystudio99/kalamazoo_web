import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:bestlocaleats/models/app_model.dart';
import 'package:bestlocaleats/utils/globals.dart' as globals;

class Authentication {
  final auth = FirebaseAuth.instance;
  Future<void> signInWithGoogle({
    // Callback functions
    required VoidCallback onSuccess,
    required VoidCallback onError,
  }) async {
    try {
      GoogleAuthProvider authProvider = GoogleAuthProvider();
      // Once signed in, return the Firebase UserCredential
      final UserCredential userCredential =
          await auth.signInWithPopup(authProvider);
      if (userCredential.user != null) {
        AppModel().userExist(
            email: userCredential.user!.email!,
            onSuccess: () {
              AppModel().userSignIn(
                  email: userCredential.user!.email!,
                  password: globals.userPass,
                  onSuccess: () {
                    onSuccess();
                  },
                  onError: (String text) {
                    onError();
                  });
            },
            onError: (String text) {
              AppModel().userSignUp(
                  name: userCredential.user!.displayName!,
                  email: userCredential.user!.email!,
                  password: '123456789',
                  onSuccess: () {
                    onSuccess();
                  },
                  onError: (String text) {
                    onError();
                  });
            });
      } else {
        onError();
      }
    } on PlatformException catch (error) {
      debugPrint('error code: $error');
      onError();
    } on FirebaseAuthException catch (error) {
      debugPrint('error code: $error');
      onError();
    }
  }

  Future<void> signOut({required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      debugPrint('Error signing out. Try again.');
    }
  }
}
