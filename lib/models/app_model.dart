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

  String getSearchAreaKey() {
    return (globals.searchPriority == Constants.RESTAURANT_ZIP)
        ? globals.searchZip
        : globals.searchCity;
  }

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
              globals.userRole = docSnapshot.data()[Constants.USER_ROLE];
              if (docSnapshot.data()[Constants.USER_PROFILE_PHOTO] != null) {
                globals.userAvatar =
                    docSnapshot.data()[Constants.USER_PROFILE_PHOTO];
              }
              if (docSnapshot.data()[Constants.USER_FAVOURITIES].isNotEmpty) {
                globals.userFavourites =
                    docSnapshot.data()[Constants.USER_FAVOURITIES];
              }
              if (docSnapshot.data()[Constants.USER_RESTAURANT_ID] != null &&
                  docSnapshot.data()[Constants.USER_RESTAURANT_ID].isNotEmpty) {
                globals.restaurantID =
                    docSnapshot.data()[Constants.USER_RESTAURANT_ID];
                globals.ownerBusinessID =
                    docSnapshot.data()[Constants.USER_RESTAURANT_ID];
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

  // customer sign up method
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

  // owner sign up method
  void ownerSignUp({
    required String restaurantId,
    required String restaurantService,
    required String name,
    required String email,
    required String password,
    required String businessname,
    required String address,
    required String phone,
    // callback functions
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    final docRef = _firestore.collection(Constants.C_USERS).doc();
    await docRef.set({
      Constants.USER_ID: docRef.id,
      Constants.USER_RESTAURANT_ID: restaurantId,
      Constants.USER_RESTAURANT_SERVICE: restaurantService,
      Constants.USER_FULLNAME: name,
      Constants.USER_EMAIL: email,
      Constants.USER_PASS: password,
      Constants.USER_BUSINESSNAME: businessname,
      Constants.USER_LOCATION: address,
      Constants.USER_PHONE_NUMBER: phone,
      Constants.USER_ROLE: globals.userRole,
      Constants.USER_FAVOURITIES: [],
      Constants.USER_AMENITIES: globals.ownerAmenities
    });
    globals.userEmail = email;
    globals.userID = docRef.id;
    globals.restaurantID = restaurantId;
    globals.ownerBusinessID = restaurantId;
    globals.restaurantType = restaurantService;
    onSuccess();
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
    String? gender,
    String? birthYear,
    String? birthMonth,
    String? birthDate,
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
        Constants.USER_GENDER: gender ?? '',
        Constants.USER_BIRTH_YEAR: birthYear ?? '',
        Constants.USER_BIRTH_MONTH: birthMonth ?? '',
        Constants.USER_BIRTH_DAY: birthDate ?? ''
      }).then((value) => onSuccess(),
          onError: (e) => onError('Profile Update Failed!'));
    }
  }

  void getBestOffers({
    required int count,
    String? topMenu,
    // callback functions
    required Function(List<Map<String, dynamic>>) onSuccess,
    required Function(String) onError,
  }) {
    if (count == 0) {
      if (topMenu != null && topMenu.isNotEmpty) {
        _firestore
            .collection(Constants.C_RESTAURANTS)
            .where(Constants.RESTAURANT_CATEGORY, isEqualTo: topMenu)
            .where(globals.searchPriority, isEqualTo: getSearchAreaKey())
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
      } else {
        _firestore
            .collection(Constants.C_RESTAURANTS)
            .where(globals.searchPriority, isEqualTo: getSearchAreaKey())
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
    } else {
      _firestore
          .collection(Constants.C_RESTAURANTS)
          .where(globals.searchPriority, isEqualTo: getSearchAreaKey())
          .limit(count)
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

  void getTopBrands({
    required bool all,
    String? topMenu,
    // callback functions
    required Function(List<Map<String, dynamic>>) onSuccess,
  }) {
    if (all) {
      if (topMenu != null && topMenu.isNotEmpty) {
        _firestore
            .collection(globals.restaurantType)
            .where(Constants.RESTAURANT_CATEGORY, isEqualTo: topMenu)
            .where(globals.searchPriority, isEqualTo: getSearchAreaKey())
            .where(Constants.RESTAURANT_BRAND, isEqualTo: true)
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
      } else {
        _firestore
            .collection(globals.restaurantType)
            .where(globals.searchPriority, isEqualTo: getSearchAreaKey())
            .where(Constants.RESTAURANT_BRAND, isEqualTo: true)
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
    } else {
      _firestore
          .collection(globals.restaurantType)
          .where(globals.searchPriority, isEqualTo: getSearchAreaKey())
          .where(Constants.RESTAURANT_BRAND, isEqualTo: true)
          .limit(3)
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

  void getAmenities({
    required Function(List<Map<String, dynamic>>) onSuccess,
    required VoidCallback onEmpty,
  }) async {
    final snapshots = await _firestore
        .collection(Constants.C_AMENITIES)
        .orderBy(Constants.AMENITY_NAME, descending: false)
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
    final snapshots = await _firestore
        .collection(Constants.C_TOPMENU)
        .orderBy(Constants.TOPMENU_NAME)
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

  void getCategories({
    required Function(List<Map<String, dynamic>>) onSuccess,
    required VoidCallback onEmpty,
  }) async {
    final snapshots = await _firestore.collection(Constants.C_CATEGORIES).get();
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
    required VoidCallback onEmpty,
  }) async {
    final snapshots = await _firestore
        .collection(globals.restaurantType)
        .where(Constants.RESTAURANT_CATEGORY, isEqualTo: topMenu)
        .where(globals.searchPriority, isEqualTo: getSearchAreaKey())
        .get();
    if (snapshots.docs.isNotEmpty) {
      List<Map<String, dynamic>> list = [];
      for (var element in snapshots.docs) {
        list.add(element.data());
      }
      onSuccess(list);
    } else {
      onEmpty();
    }
  }

  void getList({
    // callback functions
    required Function(List<Map<String, dynamic>>) onSuccess,
  }) {
    _firestore
        .collection(globals.restaurantType)
        .where(globals.searchPriority, isEqualTo: getSearchAreaKey())
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

  void getRestaurantProfile({
    required String businessId,
    required String businessService,
    // callback functions
    required Function(Map<String, dynamic>) onSuccess,
  }) {
    _firestore
        .collection(businessService)
        .where(Constants.RESTAURANT_ID, isEqualTo: businessId)
        .get()
        .then(
      (querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          Map<String, dynamic> data = {};
          for (var docSnapshot in querySnapshot.docs) {
            data = docSnapshot.data();
            break;
          }
          onSuccess(data);
        }
      },
      onError: (e) => debugPrint("Error completing: $e"),
    );
  }

  void getRestaurantByID({
    required String id,
    // callback functions
    required Function(Map<String, dynamic>?) onSuccess,
    required Function(String) onError,
  }) {
    _firestore.collection(globals.restaurantType).doc(id).get().then(
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

  void registerRestaurant({
    required String email,
    required String businessname,
    required String address,
    required String phone,
    required String businessservice,
    required String city,
    required String state,
    required String zip,
    required List<Map<String, dynamic>> schedule,
    // callback functions
    required Function(String) onSuccess,
  }) async {
    if (businessservice == Constants.C_RESTAURANTS ||
        businessservice == Constants.C_WINERIES ||
        businessservice == Constants.C_BREWERIES) {
      final docRef = _firestore.collection(businessservice).doc();
      await docRef.set({
        Constants.RESTAURANT_ID: docRef.id,
        Constants.RESTAURANT_ADDRESS: address,
        Constants.RESTAURANT_AMENITIES: globals.ownerAmenities,
        Constants.RESTAURANT_BUSINESSNAME: businessname,
        Constants.RESTAURANT_CATEGORY: '',
        Constants.RESTAURANT_CITY: city,
        Constants.RESTAURANT_EMAIL: email,
        Constants.RESTAURANT_GEOLOCATION: [0, 0],
        Constants.RESTAURANT_PHONE: phone,
        Constants.RESTAURANT_STATE: state,
        Constants.RESTAURANT_URL: '',
        Constants.RESTAURANT_ZIP: zip,
        Constants.RESTAURANT_SCHEDULE: schedule,
      });
      onSuccess(docRef.id);
    }
  }

  void postServiceProfile({
    required String imageUrl,
    required String businessservice,
    required String businessId,
    required List<Map<String, dynamic>> schedule,
    // callback functions
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) {
    if (businessservice == Constants.C_RESTAURANTS ||
        businessservice == Constants.C_WINERIES ||
        businessservice == Constants.C_BREWERIES) {
      _firestore.collection(businessservice).doc(businessId).update({
        Constants.RESTAURANT_IMAGE: imageUrl,
        Constants.RESTAURANT_SCHEDULE: schedule,
      }).then((value) => onSuccess(),
          onError: (e) => debugPrint("Error updating document $e"));
    }
  }

  void postFavourite({
    required String restaurantID,
    // callback functions
    required VoidCallback onSuccess,
  }) {
    if (globals.userFavourites.contains(restaurantID)) {
      globals.userFavourites.remove(restaurantID);
    } else {
      globals.userFavourites.add(restaurantID);
    }

    _firestore
        .collection(Constants.C_USERS)
        .doc(globals.userID)
        .update({Constants.USER_FAVOURITIES: globals.userFavourites}).then(
            (value) => onSuccess(),
            onError: (e) => debugPrint("Error updating document $e"));
  }

  void getFavourites({
    // callback functions
    required Function(List<Map<String, dynamic>>) onSuccess,
  }) {
    List<Map<String, dynamic>> favourites = [];
    if (globals.userFavourites.isNotEmpty) {
      _firestore
          .collection(Constants.C_RESTAURANTS)
          .where(Constants.RESTAURANT_ID, whereIn: globals.userFavourites)
          .get()
          .then(
        (querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            for (var docSnapshot in querySnapshot.docs) {
              favourites.add(docSnapshot.data());
            }
            onSuccess(favourites);
          }
        },
        onError: (e) => debugPrint("Error completing: $e"),
      );
    } else {
      onSuccess(favourites);
    }
  }

  void postSubscription({
    required int count,
    required String type,
    // callback functions
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) {
    _firestore.collection(Constants.C_USERS).doc(globals.userID).update({
      Constants.USER_SUBSCRIPTION_DATE: DateTime.now(),
      Constants.USER_SUBSCRIPTION_COUNT: count,
      Constants.USER_SUBSCRIPTION_TYPE: type,
    }).then((value) => onSuccess(),
        onError: (e) => debugPrint("Error updating document $e"));
  }

  void postDailySpecial({
    required String imageLink,
    required String desc,
    // callback functions
    required VoidCallback onSuccess,
  }) async {
    final docRef = _firestore.collection(Constants.C_DAILYSPECIAL).doc();
    await docRef.set({
      Constants.DAILYSPECIAL_ID: docRef.id,
      Constants.DAILYSPECIAL_IMAGE_LINK: imageLink,
      Constants.DAILYSPECIAL_DESC: desc,
      Constants.DAILYSPECIAL_ACTIVE: false,
      Constants.DAILYSPECIAL_BUSINESS_ID: globals.ownerBusinessID,
      Constants.DAILYSPECIAL_BUSINESS_TYPE: globals.ownerBusinessType,
    });
    onSuccess();
  }
}
