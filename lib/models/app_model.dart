import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bestlocaleats/utils/globals.dart' as globals;
import 'package:scoped_model/scoped_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';

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

  EmailOTP myauth = EmailOTP();
}
