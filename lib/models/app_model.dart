import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bestlocaleats/utils/globals.dart' as globals;
import 'package:bestlocaleats/utils/constants.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppModel extends Model {
  final _firestore = FirebaseFirestore.instance;

  String? retrieveEmail;
  String? retrieveID;
  Map<String, dynamic> categories = {};

  /// Create Singleton factory for [AppModel]
  ///
  static final AppModel _appModel = AppModel._internal();
  factory AppModel() {
    return _appModel;
  }
  AppModel._internal();
  // End

  // user sign in method
  void userSignIn({
    required String email,
    required String password,
    // callback functions
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) {
    _firestore
        .collection(Constants.C_USERS)
        .where(Constants.USER_EMAIL, isEqualTo: email)
        .get()
        .then(
      (querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          for (var docSnapshot in querySnapshot.docs) {
            if (docSnapshot.data()[Constants.USER_PASS] == password) {
              globals.userEmail = email;
              globals.userID = docSnapshot.id;
              globals.userName = docSnapshot.data()[Constants.USER_FULLNAME];
              globals.userAvatar =
                  docSnapshot.data()[Constants.USER_PROFILE_PHOTO];
              if (docSnapshot.data()[Constants.USER_FAVOURITIES].isNotEmpty) {
                globals.userFavourites =
                    docSnapshot.data()[Constants.USER_FAVOURITIES];
              }
              onSuccess();
            } else {
              onError('Wrong password provided for that user.');
            }
            break;
          }
        } else {
          onError('No user found for that email.');
        }
      },
      onError: (e) => debugPrint("Error completing: $e"),
    );
  }

  // user sign up method
  void userSignUp({
    required String name,
    required String email,
    required String password,
    // callback functions
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) {
    final user = <String, dynamic>{
      Constants.USER_FULLNAME: name,
      Constants.USER_EMAIL: email,
      Constants.USER_PASS: password
    };
    _firestore
        .collection(Constants.C_USERS)
        .add(user)
        .then((DocumentReference doc) {
      globals.userEmail = email;
      globals.userID = doc.id;
      globals.userName = name;
      onSuccess();
    });
  }

  // user exist method
  void userExist({
    required String email,
    // callback functions
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) {
    _firestore
        .collection(Constants.C_USERS)
        .where(Constants.USER_EMAIL, isEqualTo: email)
        .get()
        .then(
      (querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          retrieveEmail = email;
          for (var docSnapshot in querySnapshot.docs) {
            retrieveID = docSnapshot.id;
            if (docSnapshot.data()[Constants.USER_FAVOURITIES].isNotEmpty) {
              globals.userFavourites =
                  docSnapshot.data()[Constants.USER_FAVOURITIES];
            }
            break;
          }
          onSuccess();
        } else {
          onError('No user found for that email.');
        }
      },
      onError: (e) => debugPrint("Error completing: $e"),
    );
  }

  // user reset password method
  void userResetPassword({
    required String newPass,
    required String confirmPass,
    // callback functions
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) {
    (newPass == confirmPass)
        ? _firestore
            .collection(Constants.C_USERS)
            .doc(retrieveID)
            .update({Constants.USER_PASS: newPass}).then((value) {
            globals.userEmail = retrieveEmail!;
            globals.userID = retrieveID!;
            onSuccess();
          }, onError: (e) => debugPrint("Error updating document $e"))
        : onError('Passwords must match.');
  }
}
