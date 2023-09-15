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
  String? retrieveName;
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
              if (docSnapshot.data()[Constants.USER_PROFILE_PHOTO] != null) {
                globals.userAvatar =
                    docSnapshot.data()[Constants.USER_PROFILE_PHOTO];
              }
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
      Constants.USER_PASS: password,
      Constants.USER_ROLE: globals.userRole
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
            retrieveName = docSnapshot.data()[Constants.USER_FULLNAME];
            if (docSnapshot.data()[Constants.USER_FAVOURITIES].isNotEmpty) {
              globals.userFavourites =
                  docSnapshot.data()[Constants.USER_FAVOURITIES];
            }
            globals.userPass = docSnapshot.data()[Constants.USER_PASS];
            globals.userRole = docSnapshot.data()[Constants.USER_ROLE];
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
            globals.userName = retrieveName!;
            onSuccess();
          }, onError: (e) => debugPrint("Error updating document $e"))
        : onError('Passwords must match.');
  }

  // user logout method
  void userLogout({
    // callback functions
    required VoidCallback onSuccess,
  }) {
    globals.userID = "";
    globals.userName = "";
    globals.userEmail = "";
    globals.userAvatar = "";
    globals.userFavourites = [];
    globals.userRole = "";

    globals.restaurantID = "";
    globals.restaurantRating = 0;
    globals.menuID = "";
    onSuccess();
  }

  void getProfile({
    required Function(Map<String, dynamic>?) onSuccess,
    required Function(String) onError,
  }) {
    _firestore.collection(Constants.C_USERS).doc(globals.userID).get().then(
      (documentSnapshot) {
        if (documentSnapshot.exists) {
          onSuccess(documentSnapshot.data());
        } else {
          onError('No user found');
        }
      },
      onError: (e) => debugPrint("Error completing: $e"),
    );
  }

  void postProfile({
    required String imageUrl,
    required String name,
    required String location,
    required String email,
    required String gender,
    required String birthYear,
    required String birthMonth,
    required String birthDate,
    // callback functions
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) {
    if (globals.userID.isEmpty) {
      onError('Please login.');
    } else {
      _firestore.collection(Constants.C_USERS).doc(globals.userID).update({
        Constants.USER_PROFILE_PHOTO: imageUrl,
        Constants.USER_FULLNAME: name,
        Constants.USER_LOCATION: location,
        Constants.USER_EMAIL: email,
        Constants.USER_GENDER: gender,
        Constants.USER_BIRTH_YEAR: birthYear,
        Constants.USER_BIRTH_MONTH: birthMonth,
        Constants.USER_BIRTH_DAY: birthDate
      }).then((value) => onSuccess(),
          onError: (e) => onError('Profile Update Failed!'));
    }
  }

  void getBestOffers({
    required int count,
    // callback functions
    required Function(List<Map<String, dynamic>>) onSuccess,
    required Function(String) onError,
  }) {
    if (count == 0) {
      _firestore.collection(Constants.C_RESTAURANTS).get().then(
        (querySnapshot) {
          List<Map<String, dynamic>> result = [];
          for (var snapshot in querySnapshot.docs) {
            result.add(snapshot.data());
          }
          onSuccess(result);
        },
        onError: (e) => debugPrint("Error completing: $e"),
      );
    } else {
      _firestore.collection(Constants.C_RESTAURANTS).limit(count).get().then(
        (querySnapshot) {
          List<Map<String, dynamic>> result = [];
          for (var snapshot in querySnapshot.docs) {
            result.add(snapshot.data());
          }
          onSuccess(result);
        },
        onError: (e) => debugPrint("Error completing: $e"),
      );
    }
  }

  void getAmenities({
    required Function(List<Map<String, dynamic>>) onSuccess,
    required VoidCallback onEmpty,
  }) async {
    final snapshots = await _firestore
        .collection(Constants.C_AMENITIES)
        // .orderBy(AMENITY_NAME, descending: false)
        .get();
    if (snapshots.docs.isEmpty) {
      onEmpty();
    } else {
      List<Map<String, dynamic>> list = [];
      for (var element in snapshots.docs) {
        list.add(element.data());
      }
      onSuccess(list);
    }
  }

  void getTopMenu({
    required Function(List<Map<String, dynamic>>) onSuccess,
    required VoidCallback onEmpty,
  }) async {
    final snapshots = await _firestore.collection(Constants.C_TOPMENU).get();
    if (snapshots.docs.isEmpty) {
      onEmpty();
    } else {
      List<Map<String, dynamic>> list = [];
      for (var element in snapshots.docs) {
        list.add(element.data());
      }
      onSuccess(list);
    }
  }

  void getListByTopMenu({
    required String topMenu,
    // callback functions
    required Function(List<Map<String, dynamic>>) onSuccess,
  }) async {
    final snapshots = await _firestore
        .collection(Constants.C_RESTAURANTS)
        .where(Constants.RESTAURANT_CATEGORY, isEqualTo: topMenu)
        .get();
    if (snapshots.docs.isNotEmpty) {
      List<Map<String, dynamic>> list = [];
      for (var element in snapshots.docs) {
        list.add(element.data());
      }
      onSuccess(list);
    }
  }

  void getRestaurantByID({
    required String id,
    // callback functions
    required Function(Map<String, dynamic>?) onSuccess,
    required Function(String) onError,
  }) {
    _firestore.collection(Constants.C_RESTAURANTS).doc(id).get().then(
      (querySnapshot) {
        onSuccess(querySnapshot.data());
      },
      onError: (e) => debugPrint("Error completing: $e"),
    );
  }

  void getRestaurantFoodByID({
    required String id,
    // callback functions
    required Function(List<Map<String, dynamic>>) onSuccess,
    required Function(String) onError,
  }) {
    _firestore
        .collection(Constants.C_RESTAURANTS)
        .doc(id)
        .collection(Constants.C_C_MENU)
        .get()
        .then(
      (querySnapshot) {
        List<Map<String, dynamic>> result = [];
        for (var snapshot in querySnapshot.docs) {
          result.add(snapshot.data());
        }
        onSuccess(result);
      },
      onError: (e) => debugPrint("Error completing: $e"),
    );
  }
}
