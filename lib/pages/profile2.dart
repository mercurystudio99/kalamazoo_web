import 'package:bestlocaleats/utils/constants.dart';
import 'package:bestlocaleats/utils/colors.dart';
import 'package:bestlocaleats/utils/globals.dart' as global;
import 'package:bestlocaleats/models/app_model.dart';
import 'package:bestlocaleats/widgets/top_bar.dart';
import 'package:bestlocaleats/widgets/responsive.dart';
import 'package:bestlocaleats/widgets/bottom_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Profile2Page extends StatefulWidget {
  const Profile2Page({super.key});

  @override
  State<Profile2Page> createState() => _Profile2PageState();
}

class _Profile2PageState extends State<Profile2Page> {
  final List _isHovering = [
    false, // 0: logo
  ];

  PlatformFile? _imageFile;
  String _imageLink = '';

  final _storage = FirebaseStorage.instance;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();
  final _emailController = TextEditingController();

  Future getImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    if (result == null) return;
    setState(() {
      _imageFile = result.files.first;
      _imageLink = '';
    });
  }

  String? _validateEmail(String value) {
    if (value.isEmpty) {
      return "Please enter your email";
    }
    if (!(value.isNotEmpty && value.contains("@") && value.contains("."))) {
      return 'The E-mail Address must be a valid email address.';
    }
    return null;
  }

  String? _validateName(String value) {
    if (value.isEmpty) {
      return "Please enter your name";
    }
    return null;
  }

  String? _validatePhone(String value) {
    if (value.isEmpty) {
      return "Please enter your phone";
    }
    return null;
  }

  String? _validateLocation(String value) {
    if (value.isEmpty) {
      return "Please enter your location";
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    if (global.userID.isNotEmpty) {
      AppModel().getProfile(
          onSuccess: (Map<String, dynamic>? param) {
            if (param == null) return;
            if (param[Constants.USER_PROFILE_PHOTO] != null) {
              _imageLink = param[Constants.USER_PROFILE_PHOTO];
            }
            _nameController.text = param[Constants.USER_FULLNAME];
            if (param[Constants.USER_LOCATION] != null) {
              _locationController.text = param[Constants.USER_LOCATION];
            }
            _emailController.text = param[Constants.USER_EMAIL];
            if (param[Constants.USER_PHONE_NUMBER] != null) {
              _phoneController.text = param[Constants.USER_PHONE_NUMBER];
            }
            setState(() {});
          },
          onError: (String text) {});
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isSmallScreen(context)) {
      return _mobile();
    } else {
      return _desktop();
    }
  }

  Widget _desktop() {
    int topbarstatus = 1;
    if (global.userID.isNotEmpty) topbarstatus = 2;
    Size screenSize = MediaQuery.of(context).size;
    double formPadding = ResponsiveWidget.isLargeScreen(context)
        ? Constants.mainPadding * 2
        : Constants.mainPadding;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: TopBarContents(1, topbarstatus, 'profile2', (param) {
          debugPrint('---');
        }),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.mainPadding, vertical: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: screenSize.width * 0.5,
                    child: Center(
                      child: Image.asset(Constants.IMG_PROFILE_BG,
                          width: screenSize.width * 0.35,
                          height: screenSize.width * 0.35),
                    ),
                  ),
                  Expanded(
                      child: Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Constants.mainPadding),
                        child: Text(
                          'Profile',
                          style: TextStyle(
                              color: CustomColor.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 38),
                        ),
                      ),
                      const SizedBox(height: 50),
                      screenSize.width > 1100
                          ? Row(children: [
                              Stack(children: [
                                _imageFile != null
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal:
                                                Constants.mainPadding * 2),
                                        child: ClipOval(
                                          child: Image.memory(
                                            Uint8List.fromList(
                                                _imageFile!.bytes!),
                                            width: 150,
                                            height: 150,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : _imageLink.isNotEmpty
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal:
                                                    Constants.mainPadding * 2),
                                            child: ClipOval(
                                                child: CachedNetworkImage(
                                              imageUrl: _imageLink,
                                              width: 150,
                                              height: 150,
                                              fit: BoxFit.cover,
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            )),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal:
                                                    Constants.mainPadding * 2),
                                            child: ClipOval(
                                                child: Container(
                                              width: 150,
                                              height: 150,
                                              color: CustomColor
                                                  .textSecondaryColor,
                                            ))),
                                Positioned(
                                    right: Constants.mainPadding * 2,
                                    bottom: 10,
                                    child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color:
                                                CustomColor.textPrimaryColor),
                                        child: const Icon(Icons.camera_alt)))
                              ]),
                              Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        height: 40,
                                        width: 160,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  CustomColor.primaryColor,
                                              elevation: 3,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              shadowColor: CustomColor
                                                  .primaryColor
                                                  .withOpacity(0.5),
                                              padding: const EdgeInsets.all(5)),
                                          onPressed: () {
                                            getImage();
                                          },
                                          child: const Text(
                                            'Upload New',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                                letterSpacing: 1),
                                          ),
                                        )),
                                    const SizedBox(height: 20),
                                    SizedBox(
                                        height: 40,
                                        width: 160,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      width: 1,
                                                      color: CustomColor
                                                          .activeColor),
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              padding: const EdgeInsets.all(5)),
                                          onPressed: () {
                                            setState(() {
                                              _imageFile = null;
                                              _imageLink = '';
                                            });
                                          },
                                          child: const Text(
                                            'Delete photo',
                                            style: TextStyle(
                                                color: CustomColor.activeColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                                letterSpacing: 1),
                                          ),
                                        )),
                                  ])
                            ])
                          : Center(
                              child: Column(children: [
                              Stack(children: [
                                _imageFile != null
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal:
                                                Constants.mainPadding * 2),
                                        child: ClipOval(
                                          child: Image.memory(
                                            Uint8List.fromList(
                                                _imageFile!.bytes!),
                                            width: 150,
                                            height: 150,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : _imageLink.isNotEmpty
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal:
                                                    Constants.mainPadding * 2),
                                            child: ClipOval(
                                                child: CachedNetworkImage(
                                              imageUrl: _imageLink,
                                              width: 150,
                                              height: 150,
                                              fit: BoxFit.cover,
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            )),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal:
                                                    Constants.mainPadding * 2),
                                            child: ClipOval(
                                                child: Container(
                                              width: 150,
                                              height: 150,
                                              color: CustomColor
                                                  .textSecondaryColor,
                                            ))),
                                Positioned(
                                    right: Constants.mainPadding * 2,
                                    bottom: 10,
                                    child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color:
                                                CustomColor.textPrimaryColor),
                                        child: const Icon(Icons.camera_alt)))
                              ]),
                              const SizedBox(height: 20),
                              SizedBox(
                                  height: 40,
                                  width: 160,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            CustomColor.primaryColor,
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        shadowColor: CustomColor.primaryColor
                                            .withOpacity(0.5),
                                        padding: const EdgeInsets.all(5)),
                                    onPressed: () {
                                      getImage();
                                    },
                                    child: const Text(
                                      'Upload New',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          letterSpacing: 1),
                                    ),
                                  )),
                              const SizedBox(height: 20),
                              SizedBox(
                                  height: 40,
                                  width: 160,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                width: 1,
                                                color: CustomColor.activeColor),
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        padding: const EdgeInsets.all(5)),
                                    onPressed: () {
                                      setState(() {
                                        _imageFile = null;
                                        _imageLink = '';
                                      });
                                    },
                                    child: const Text(
                                      'Delete photo',
                                      style: TextStyle(
                                          color: CustomColor.activeColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          letterSpacing: 1),
                                    ),
                                  )),
                            ])),
                      const SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: formPadding),
                        child: const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Basic Info',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 35),
                            )),
                      ),
                      const SizedBox(height: 30),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: formPadding, vertical: 10),
                                child: const Text(
                                  'Business Name',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: formPadding),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 56,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: CustomColor.primaryColor
                                                .withOpacity(0.2),
                                            blurRadius: 5,
                                            spreadRadius: 1,
                                            offset: const Offset(0, 0)),
                                      ],
                                    ),
                                  ),
                                  TextFormField(
                                    controller: _nameController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Best local eats',
                                    ),
                                    validator: (value) {
                                      return _validateName(value!);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: formPadding, vertical: 10),
                                child: const Text(
                                  'Phone Number',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: formPadding),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 56,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: CustomColor.primaryColor
                                                .withOpacity(0.2),
                                            blurRadius: 5,
                                            spreadRadius: 1,
                                            offset: const Offset(0, 0)),
                                      ],
                                    ),
                                  ),
                                  TextFormField(
                                    controller: _phoneController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: '123456789',
                                    ),
                                    validator: (value) {
                                      return _validatePhone(value!);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: formPadding, vertical: 10),
                                child: const Text(
                                  'Full Address',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: formPadding),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 56,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: CustomColor.primaryColor
                                                .withOpacity(0.2),
                                            blurRadius: 5,
                                            spreadRadius: 1,
                                            offset: const Offset(0, 0)),
                                      ],
                                    ),
                                  ),
                                  TextFormField(
                                    controller: _locationController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Kalamazoo, Michigan, USA',
                                    ),
                                    validator: (value) {
                                      return _validateLocation(value!);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: formPadding, vertical: 10),
                                child: const Text(
                                  'Email Address',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: formPadding),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 56,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: CustomColor.primaryColor
                                                .withOpacity(0.2),
                                            blurRadius: 5,
                                            spreadRadius: 1,
                                            offset: const Offset(0, 0)),
                                      ],
                                    ),
                                  ),
                                  TextFormField(
                                    controller: _emailController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'demo@gmail.com',
                                    ),
                                    validator: (value) {
                                      return _validateEmail(value!);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: formPadding, vertical: 10),
                                child: const Text(
                                  'Service Category',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: formPadding, vertical: 10),
                                child: Row(children: const [
                                  SizedBox(
                                      width: 100,
                                      child: Text(
                                        'Brewery',
                                        style: TextStyle(
                                          color: CustomColor.textPrimaryColor,
                                        ),
                                      )),
                                  SizedBox(
                                      width: 100,
                                      child: Text(
                                        'Food Truck',
                                        style: TextStyle(
                                          color: CustomColor.textPrimaryColor,
                                        ),
                                      )),
                                ])),
                            const SizedBox(height: 20),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: formPadding, vertical: 10),
                                child: const Text(
                                  'Day/House',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: formPadding, vertical: 10),
                              child: Stack(children: [
                                Container(
                                  height: 164,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: CustomColor.primaryColor
                                              .withOpacity(0.2),
                                          blurRadius: 5,
                                          spreadRadius: 1,
                                          offset: const Offset(0, 0)),
                                    ],
                                  ),
                                ),
                                Card(
                                    margin: const EdgeInsets.all(0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    elevation: 0,
                                    child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            12, 5, 0, 5),
                                        child: Column(children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                right: 12),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text('Tuesday',
                                                            style: TextStyle(
                                                                color: CustomColor
                                                                    .textSecondaryColor,
                                                                fontSize: 12)),
                                                        const Spacer(),
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 45),
                                                          child: Text('Closed',
                                                              style: TextStyle(
                                                                  color: CustomColor
                                                                      .activeColor,
                                                                  fontSize:
                                                                      12)),
                                                        ),
                                                        InkWell(
                                                            onTap: () {},
                                                            child: const Icon(
                                                              Icons
                                                                  .edit_outlined,
                                                              size: 22,
                                                            )),
                                                      ]),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text('Wednesday',
                                                            style: TextStyle(
                                                                color: CustomColor
                                                                    .textSecondaryColor,
                                                                fontSize: 12)),
                                                        const Spacer(),
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 45),
                                                          child: Text(
                                                              '8:00 AM - 9:00 PM',
                                                              style: TextStyle(
                                                                  color: CustomColor
                                                                      .textSecondaryColor,
                                                                  fontSize:
                                                                      12)),
                                                        ),
                                                        InkWell(
                                                            onTap: () {},
                                                            child: const Icon(
                                                              Icons
                                                                  .edit_outlined,
                                                              size: 22,
                                                            )),
                                                      ]),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text('Thursday',
                                                            style: TextStyle(
                                                                color: CustomColor
                                                                    .textSecondaryColor,
                                                                fontSize: 12)),
                                                        const Spacer(),
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 45),
                                                          child: Text(
                                                              '8:00 AM - 9:00 PM',
                                                              style: TextStyle(
                                                                  color: CustomColor
                                                                      .textSecondaryColor,
                                                                  fontSize:
                                                                      12)),
                                                        ),
                                                        InkWell(
                                                            onTap: () {},
                                                            child: const Icon(
                                                              Icons
                                                                  .edit_outlined,
                                                              size: 22,
                                                            )),
                                                      ]),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text('Friday',
                                                            style: TextStyle(
                                                                color: CustomColor
                                                                    .textSecondaryColor,
                                                                fontSize: 12)),
                                                        const Spacer(),
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 45),
                                                          child: Text(
                                                              '8:00 AM - 9:00 PM',
                                                              style: TextStyle(
                                                                  color: CustomColor
                                                                      .textSecondaryColor,
                                                                  fontSize:
                                                                      12)),
                                                        ),
                                                        InkWell(
                                                            onTap: () {},
                                                            child: const Icon(
                                                              Icons
                                                                  .edit_outlined,
                                                              size: 22,
                                                            )),
                                                      ]),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text('Saturday',
                                                            style: TextStyle(
                                                                color: CustomColor
                                                                    .textSecondaryColor,
                                                                fontSize: 12)),
                                                        const Spacer(),
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 45),
                                                          child: Text(
                                                              '8:00 AM - 9:00 PM',
                                                              style: TextStyle(
                                                                  color: CustomColor
                                                                      .textSecondaryColor,
                                                                  fontSize:
                                                                      12)),
                                                        ),
                                                        InkWell(
                                                            onTap: () {},
                                                            child: const Icon(
                                                              Icons
                                                                  .edit_outlined,
                                                              size: 22,
                                                            )),
                                                      ]),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text('Sunday',
                                                            style: TextStyle(
                                                                color: CustomColor
                                                                    .textSecondaryColor,
                                                                fontSize: 12)),
                                                        const Spacer(),
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 45),
                                                          child: Text(
                                                              '8:00 AM - 9:00 PM',
                                                              style: TextStyle(
                                                                  color: CustomColor
                                                                      .textSecondaryColor,
                                                                  fontSize:
                                                                      12)),
                                                        ),
                                                        InkWell(
                                                            onTap: () {},
                                                            child: const Icon(
                                                              Icons
                                                                  .edit_outlined,
                                                              size: 22,
                                                            )),
                                                      ]),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text('Monday',
                                                            style: TextStyle(
                                                                color: CustomColor
                                                                    .textSecondaryColor,
                                                                fontSize: 12)),
                                                        const Spacer(),
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 45),
                                                          child: Text('Closed',
                                                              style: TextStyle(
                                                                  color: CustomColor
                                                                      .activeColor,
                                                                  fontSize:
                                                                      12)),
                                                        ),
                                                        InkWell(
                                                            onTap: () {},
                                                            child: const Icon(
                                                              Icons
                                                                  .edit_outlined,
                                                              size: 22,
                                                            )),
                                                      ]),
                                                ]),
                                          )
                                        ])))
                              ]),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: formPadding),
                              child: SizedBox(
                                  height: 40,
                                  width: screenSize.width,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            CustomColor.primaryColor,
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        shadowColor: CustomColor.primaryColor
                                            .withOpacity(0.5),
                                        padding: const EdgeInsets.all(5)),
                                    onPressed: () {},
                                    child: const Text(
                                      'UPLOAD MENU',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          letterSpacing: 1),
                                    ),
                                  )),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: formPadding),
                              child: SizedBox(
                                  height: 40,
                                  width: screenSize.width,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            CustomColor.primaryColor,
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        shadowColor: CustomColor.primaryColor
                                            .withOpacity(0.5),
                                        padding: const EdgeInsets.all(5)),
                                    onPressed: () {
                                      context.go('/subscription');
                                    },
                                    child: const Text(
                                      'PROMOTE YOUR BUSINESS',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          letterSpacing: 1),
                                    ),
                                  )),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: formPadding),
                              child: SizedBox(
                                  height: 40,
                                  width: screenSize.width,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            CustomColor.primaryColor,
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        shadowColor: CustomColor.primaryColor
                                            .withOpacity(0.5),
                                        padding: const EdgeInsets.all(5)),
                                    onPressed: () {},
                                    child: const Text(
                                      'UPLOAD DAILY SPECIAL',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          letterSpacing: 1),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  )),
                ],
              )),
          const BottomBar(),
        ]),
      ),
    );
  }

  Widget _mobile() {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          leading: Container(),
          backgroundColor: Colors.black,
          elevation: 0,
          title: InkWell(
            onHover: (value) {
              setState(() {
                value ? _isHovering[0] = true : _isHovering[0] = false;
              });
            },
            onTap: () {
              context.go('/');
            },
            child: Image.asset(
              Constants.IMG_LOGO,
              width: 100,
              fit: BoxFit.cover,
            ),
          )),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 50),
            Center(
              child: Image.asset(Constants.IMG_PROFILE_BG,
                  width: screenSize.width * 0.5,
                  height: screenSize.width * 0.5),
            ),
            const SizedBox(height: 50),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Constants.mainPadding),
              child: Text(
                'Profile',
                style: TextStyle(
                    color: CustomColor.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 38),
              ),
            ),
            const SizedBox(height: 50),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Stack(children: [
                _imageFile != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ClipOval(
                          child: Image.memory(
                            Uint8List.fromList(_imageFile!.bytes!),
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : _imageLink.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ClipOval(
                                child: CachedNetworkImage(
                              imageUrl: _imageLink,
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            )),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ClipOval(
                                child: Container(
                              width: 150,
                              height: 150,
                              color: CustomColor.textSecondaryColor,
                            ))),
                Positioned(
                    right: 10,
                    bottom: 10,
                    child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: CustomColor.textPrimaryColor),
                        child: const Icon(Icons.camera_alt)))
              ]),
              const SizedBox(width: 30),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        height: 40,
                        width: 160,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColor.primaryColor,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              shadowColor:
                                  CustomColor.primaryColor.withOpacity(0.5),
                              padding: const EdgeInsets.all(5)),
                          onPressed: () {
                            getImage();
                          },
                          child: const Text(
                            'Upload New',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                letterSpacing: 1),
                          ),
                        )),
                    const SizedBox(height: 20),
                    SizedBox(
                        height: 40,
                        width: 160,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 1, color: CustomColor.activeColor),
                                  borderRadius: BorderRadius.circular(4)),
                              padding: const EdgeInsets.all(5)),
                          onPressed: () {
                            setState(() {
                              _imageFile = null;
                              _imageLink = '';
                            });
                          },
                          child: const Text(
                            'Delete photo',
                            style: TextStyle(
                                color: CustomColor.activeColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                letterSpacing: 1),
                          ),
                        )),
                  ])
            ]),
            const SizedBox(height: 30),
            const Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Constants.mainPadding * 2),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Basic Info',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                  )),
            ),
            const SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Constants.mainPadding * 2, vertical: 10),
                      child: Text(
                        'Business Name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: Constants.mainPadding * 2),
                    child: Stack(
                      children: [
                        Container(
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      CustomColor.primaryColor.withOpacity(0.2),
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 0)),
                            ],
                          ),
                        ),
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Best local eats',
                          ),
                          validator: (value) {
                            return _validateName(value!);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Constants.mainPadding * 2, vertical: 10),
                      child: Text(
                        'Phone Number',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: Constants.mainPadding * 2),
                    child: Stack(
                      children: [
                        Container(
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      CustomColor.primaryColor.withOpacity(0.2),
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 0)),
                            ],
                          ),
                        ),
                        TextFormField(
                          controller: _phoneController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: '123456789',
                          ),
                          validator: (value) {
                            return _validatePhone(value!);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Constants.mainPadding * 2, vertical: 10),
                      child: Text(
                        'Full Address',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: Constants.mainPadding * 2),
                    child: Stack(
                      children: [
                        Container(
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      CustomColor.primaryColor.withOpacity(0.2),
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 0)),
                            ],
                          ),
                        ),
                        TextFormField(
                          controller: _locationController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Kalamazoo, Michigan, USA',
                          ),
                          validator: (value) {
                            return _validateLocation(value!);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Constants.mainPadding * 2, vertical: 10),
                      child: Text(
                        'Email Address',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: Constants.mainPadding * 2),
                    child: Stack(
                      children: [
                        Container(
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      CustomColor.primaryColor.withOpacity(0.2),
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 0)),
                            ],
                          ),
                        ),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'demo@gmail.com',
                          ),
                          validator: (value) {
                            return _validateEmail(value!);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Constants.mainPadding * 2, vertical: 10),
                      child: Text(
                        'Service Category',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Constants.mainPadding * 2, vertical: 10),
                      child: Row(children: const [
                        SizedBox(
                            width: 100,
                            child: Text(
                              'Brewery',
                              style: TextStyle(
                                color: CustomColor.textPrimaryColor,
                              ),
                            )),
                        SizedBox(
                            width: 100,
                            child: Text(
                              'Food Truck',
                              style: TextStyle(
                                color: CustomColor.textPrimaryColor,
                              ),
                            )),
                      ])),
                  const SizedBox(height: 20),
                  const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Constants.mainPadding * 2, vertical: 10),
                      child: Text(
                        'Day/House',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Constants.mainPadding * 2, vertical: 10),
                    child: Stack(children: [
                      Container(
                        height: 164,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          boxShadow: [
                            BoxShadow(
                                color:
                                    CustomColor.primaryColor.withOpacity(0.2),
                                blurRadius: 5,
                                spreadRadius: 1,
                                offset: const Offset(0, 0)),
                          ],
                        ),
                      ),
                      Card(
                          margin: const EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          elevation: 0,
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(12, 5, 0, 5),
                              child: Column(children: [
                                Container(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const Text('Tuesday',
                                                  style: TextStyle(
                                                      color: CustomColor
                                                          .textSecondaryColor,
                                                      fontSize: 12)),
                                              const Spacer(),
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(right: 45),
                                                child: Text('Closed',
                                                    style: TextStyle(
                                                        color: CustomColor
                                                            .activeColor,
                                                        fontSize: 12)),
                                              ),
                                              InkWell(
                                                  onTap: () {},
                                                  child: const Icon(
                                                    Icons.edit_outlined,
                                                    size: 22,
                                                  )),
                                            ]),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const Text('Wednesday',
                                                  style: TextStyle(
                                                      color: CustomColor
                                                          .textSecondaryColor,
                                                      fontSize: 12)),
                                              const Spacer(),
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(right: 45),
                                                child: Text('8:00 AM - 9:00 PM',
                                                    style: TextStyle(
                                                        color: CustomColor
                                                            .textSecondaryColor,
                                                        fontSize: 12)),
                                              ),
                                              InkWell(
                                                  onTap: () {},
                                                  child: const Icon(
                                                    Icons.edit_outlined,
                                                    size: 22,
                                                  )),
                                            ]),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const Text('Thursday',
                                                  style: TextStyle(
                                                      color: CustomColor
                                                          .textSecondaryColor,
                                                      fontSize: 12)),
                                              const Spacer(),
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(right: 45),
                                                child: Text('8:00 AM - 9:00 PM',
                                                    style: TextStyle(
                                                        color: CustomColor
                                                            .textSecondaryColor,
                                                        fontSize: 12)),
                                              ),
                                              InkWell(
                                                  onTap: () {},
                                                  child: const Icon(
                                                    Icons.edit_outlined,
                                                    size: 22,
                                                  )),
                                            ]),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const Text('Friday',
                                                  style: TextStyle(
                                                      color: CustomColor
                                                          .textSecondaryColor,
                                                      fontSize: 12)),
                                              const Spacer(),
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(right: 45),
                                                child: Text('8:00 AM - 9:00 PM',
                                                    style: TextStyle(
                                                        color: CustomColor
                                                            .textSecondaryColor,
                                                        fontSize: 12)),
                                              ),
                                              InkWell(
                                                  onTap: () {},
                                                  child: const Icon(
                                                    Icons.edit_outlined,
                                                    size: 22,
                                                  )),
                                            ]),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const Text('Saturday',
                                                  style: TextStyle(
                                                      color: CustomColor
                                                          .textSecondaryColor,
                                                      fontSize: 12)),
                                              const Spacer(),
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(right: 45),
                                                child: Text('8:00 AM - 9:00 PM',
                                                    style: TextStyle(
                                                        color: CustomColor
                                                            .textSecondaryColor,
                                                        fontSize: 12)),
                                              ),
                                              InkWell(
                                                  onTap: () {},
                                                  child: const Icon(
                                                    Icons.edit_outlined,
                                                    size: 22,
                                                  )),
                                            ]),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const Text('Sunday',
                                                  style: TextStyle(
                                                      color: CustomColor
                                                          .textSecondaryColor,
                                                      fontSize: 12)),
                                              const Spacer(),
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(right: 45),
                                                child: Text('8:00 AM - 9:00 PM',
                                                    style: TextStyle(
                                                        color: CustomColor
                                                            .textSecondaryColor,
                                                        fontSize: 12)),
                                              ),
                                              InkWell(
                                                  onTap: () {},
                                                  child: const Icon(
                                                    Icons.edit_outlined,
                                                    size: 22,
                                                  )),
                                            ]),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const Text('Monday',
                                                  style: TextStyle(
                                                      color: CustomColor
                                                          .textSecondaryColor,
                                                      fontSize: 12)),
                                              const Spacer(),
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(right: 45),
                                                child: Text('Closed',
                                                    style: TextStyle(
                                                        color: CustomColor
                                                            .activeColor,
                                                        fontSize: 12)),
                                              ),
                                              InkWell(
                                                  onTap: () {},
                                                  child: const Icon(
                                                    Icons.edit_outlined,
                                                    size: 22,
                                                  )),
                                            ]),
                                      ]),
                                )
                              ])))
                    ]),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: Constants.mainPadding * 2),
                    child: SizedBox(
                        height: 40,
                        width: screenSize.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColor.primaryColor,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              shadowColor:
                                  CustomColor.primaryColor.withOpacity(0.5),
                              padding: const EdgeInsets.all(5)),
                          onPressed: () {},
                          child: const Text(
                            'UPLOAD MENU',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                letterSpacing: 1),
                          ),
                        )),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: Constants.mainPadding * 2),
                    child: SizedBox(
                        height: 40,
                        width: screenSize.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColor.primaryColor,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              shadowColor:
                                  CustomColor.primaryColor.withOpacity(0.5),
                              padding: const EdgeInsets.all(5)),
                          onPressed: () {
                            context.go('/subscription');
                          },
                          child: const Text(
                            'PROMOTE YOUR BUSINESS',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                letterSpacing: 1),
                          ),
                        )),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: Constants.mainPadding * 2),
                    child: SizedBox(
                        height: 40,
                        width: screenSize.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColor.primaryColor,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              shadowColor:
                                  CustomColor.primaryColor.withOpacity(0.5),
                              padding: const EdgeInsets.all(5)),
                          onPressed: () {},
                          child: const Text(
                            'UPLOAD DAILY SPECIAL',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                letterSpacing: 1),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            const BottomBar()
          ],
        ),
      ),
    );
  }
}
