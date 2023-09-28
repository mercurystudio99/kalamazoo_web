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

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List _isHovering = [
    false, // 0: logo
  ];

  PlatformFile? _imageFile;
  String _imageLink = '';

  final _storage = FirebaseStorage.instance;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _emailController = TextEditingController();

  static const List<String> listGender = <String>['Male', 'Female'];
  static List<String> listYear = ['1950'];
  static const List<String> listMonth = <String>[
    'January',
    'Febrary',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  static List<String> listDate = ['1'];

  String gender = '';
  String birthYear = '';
  String birthMonth = '';
  String birthDate = '';

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

  void _saveProfile(
      {required VoidCallback onCallback,
      required Function(String) onError}) async {
    if (_imageFile != null) {
      AppModel().userExist(
          email: _emailController.text.trim(),
          onSuccess: () async {
            if (_emailController.text.trim() == global.userEmail) {
              Uint8List? fileBytes = _imageFile!.bytes;
              String filename =
                  DateTime.now().millisecondsSinceEpoch.toString() +
                      _imageFile!.name;
              var snapshot = await _storage
                  .ref()
                  .child('avatar/$filename')
                  .putData(fileBytes!);

              var url = await snapshot.ref.getDownloadURL();

              AppModel().postProfile(
                  imageUrl: url.toString(),
                  name: _nameController.text.trim(),
                  location: _locationController.text.trim(),
                  email: _emailController.text.trim(),
                  gender: gender,
                  birthYear: birthYear,
                  birthMonth: birthMonth,
                  birthDate: birthDate,
                  onSuccess: () {
                    global.userName = _nameController.text.trim();
                    global.userEmail = _emailController.text.trim();
                    global.userAvatar = url.toString();
                    onCallback();
                  },
                  onError: (String text) {
                    onError(text);
                  });
            } else {
              global.userFavourites = [];
              onError('The account already exists for that email.');
            }
          },
          onError: (String text) async {
            Uint8List? fileBytes = _imageFile!.bytes;
            String filename = DateTime.now().millisecondsSinceEpoch.toString() +
                _imageFile!.name;
            var snapshot = await _storage
                .ref()
                .child('avatar/$filename')
                .putData(fileBytes!);

            var url = await snapshot.ref.getDownloadURL();

            AppModel().postProfile(
                imageUrl: url.toString(),
                name: _nameController.text.trim(),
                location: _locationController.text.trim(),
                email: _emailController.text.trim(),
                gender: gender,
                birthYear: birthYear,
                birthMonth: birthMonth,
                birthDate: birthDate,
                onSuccess: () {
                  global.userName = _nameController.text.trim();
                  global.userEmail = _emailController.text.trim();
                  global.userAvatar = url.toString();
                  onCallback();
                },
                onError: (String text) {
                  onError(text);
                });
          });
    } else {
      if (_imageLink.isEmpty) {
        onError("Please upload your image.");
      } else {
        AppModel().userExist(
            email: _emailController.text.trim(),
            onSuccess: () {
              if (_emailController.text.trim() == global.userEmail) {
                AppModel().postProfile(
                    imageUrl: _imageLink,
                    name: _nameController.text.trim(),
                    location: _locationController.text.trim(),
                    email: _emailController.text.trim(),
                    gender: gender,
                    birthYear: birthYear,
                    birthMonth: birthMonth,
                    birthDate: birthDate,
                    onSuccess: () {
                      global.userName = _nameController.text.trim();
                      global.userEmail = _emailController.text.trim();
                      global.userAvatar = _imageLink;
                      onCallback();
                    },
                    onError: (String text) {
                      onError(text);
                    });
              } else {
                global.userFavourites = [];
                onError('The account already exists for that email.');
              }
            },
            onError: (String text) {
              AppModel().postProfile(
                  imageUrl: _imageLink,
                  name: _nameController.text.trim(),
                  location: _locationController.text.trim(),
                  email: _emailController.text.trim(),
                  gender: gender,
                  birthYear: birthYear,
                  birthMonth: birthMonth,
                  birthDate: birthDate,
                  onSuccess: () {
                    global.userName = _nameController.text.trim();
                    global.userEmail = _emailController.text.trim();
                    global.userAvatar = _imageLink;
                    onCallback();
                  },
                  onError: (String text) {
                    onError(text);
                  });
            });
      }
    }
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

  String? _validateLocation(String value) {
    if (value.isEmpty) {
      return "Please enter your location";
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    listYear = ['1950'];
    for (var i = 1951; i < 2024; i++) {
      listYear.add(i.toString());
    }
    listDate = ['1'];
    for (var i = 2; i < 32; i++) {
      listDate.add(i.toString());
    }
    gender = listGender.first;
    birthMonth = listMonth.first;
    birthDate = listDate.first;
    birthYear = listYear.first;

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
            if (param[Constants.USER_GENDER] != null) {
              gender =
                  listGender[listGender.indexOf(param[Constants.USER_GENDER])];
            }
            if (param[Constants.USER_BIRTH_DAY] != null) {
              birthDate =
                  listDate[listDate.indexOf(param[Constants.USER_BIRTH_DAY])];
            }
            if (param[Constants.USER_BIRTH_MONTH] != null) {
              birthMonth = listMonth[
                  listMonth.indexOf(param[Constants.USER_BIRTH_MONTH])];
            }
            if (param[Constants.USER_BIRTH_YEAR] != null) {
              birthYear =
                  listYear[listYear.indexOf(param[Constants.USER_BIRTH_YEAR])];
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
        child: TopBarContents(1, topbarstatus, () {
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
                                  'Name',
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
                                      hintText: 'James Hawkins',
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
                                  'Email',
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
                                  'Location',
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
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: formPadding, vertical: 10),
                              child: const Text(
                                'Gender',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: formPadding),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(14)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: CustomColor.primaryColor
                                          .withOpacity(0.2),
                                      blurRadius: 8.0,
                                      offset: const Offset(1.0, 1.0),
                                    ),
                                  ],
                                ),
                                padding:
                                    const EdgeInsets.only(left: 10, right: 8),
                                child: DropdownButton<String>(
                                  underline: const SizedBox(
                                    width: 1,
                                  ),
                                  value: gender,
                                  borderRadius: BorderRadius.circular(10.0),
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  elevation: 16,
                                  onChanged: (String? value) {
                                    setState(() {
                                      gender = value!;
                                    });
                                  },
                                  items: listGender
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: formPadding, vertical: 10),
                              child: const Text(
                                'Birthday',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: formPadding),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(14)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: CustomColor.primaryColor
                                              .withOpacity(0.2),
                                          blurRadius: 8.0,
                                          offset: const Offset(1.0, 1.0),
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 8),
                                    child: DropdownButton<String>(
                                      underline: const SizedBox(
                                        width: 1,
                                      ),
                                      value: birthDate,
                                      hint: const Text('DD'),
                                      borderRadius: BorderRadius.circular(10.0),
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      elevation: 16,
                                      onChanged: (String? value) {
                                        setState(() {
                                          birthDate = value!;
                                        });
                                      },
                                      items: listDate
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(14)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: CustomColor.primaryColor
                                              .withOpacity(0.2),
                                          blurRadius: 8.0,
                                          offset: const Offset(1.0, 1.0),
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 8),
                                    child: DropdownButton<String>(
                                      underline: const SizedBox(
                                        width: 1,
                                      ),
                                      value: birthMonth,
                                      hint: const Text('MM'),
                                      borderRadius: BorderRadius.circular(10.0),
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      elevation: 16,
                                      onChanged: (String? value) {
                                        setState(() {
                                          birthMonth = value!;
                                        });
                                      },
                                      items: listMonth
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(14)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: CustomColor.primaryColor
                                              .withOpacity(0.2),
                                          blurRadius: 8.0,
                                          offset: const Offset(1.0, 1.0),
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 8),
                                    child: DropdownButton<String>(
                                      underline: const SizedBox(
                                        width: 1,
                                      ),
                                      value: birthYear,
                                      hint: const Text('YY'),
                                      borderRadius: BorderRadius.circular(10.0),
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      elevation: 16,
                                      onChanged: (String? value) {
                                        setState(() {
                                          birthYear = value!;
                                        });
                                      },
                                      items: listYear
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
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
                                      if (_formKey.currentState!.validate()) {
                                        _saveProfile(onCallback: () {
                                          setState(() {});
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Successfully Updated.')),
                                          );
                                        }, onError: (String text) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(content: Text(text)),
                                          );
                                        });
                                      }
                                    },
                                    child: const Text(
                                      'Save',
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
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: formPadding),
                        child: SizedBox(
                            height: 40,
                            width: 200,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  shadowColor:
                                      CustomColor.primaryColor.withOpacity(0.5),
                                  padding: const EdgeInsets.all(5)),
                              onPressed: () {
                                AppModel().userLogout(onSuccess: () {
                                  context.go('/');
                                });
                              },
                              child: const Text(
                                'Log Out',
                                style: TextStyle(
                                    color: CustomColor.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    letterSpacing: 1),
                              ),
                            )),
                      ),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: Constants.mainPadding * 2),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: Constants.mainPadding * 2),
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
                        'Name',
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
                            hintText: 'James Hawkins',
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
                        'Email',
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
                        'Location',
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
                  const Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Constants.mainPadding * 2, vertical: 10),
                    child: Text(
                      'Gender',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: Constants.mainPadding * 2),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(14)),
                        boxShadow: [
                          BoxShadow(
                            color: CustomColor.primaryColor.withOpacity(0.2),
                            blurRadius: 8.0,
                            offset: const Offset(1.0, 1.0),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.only(left: 10, right: 8),
                      child: DropdownButton<String>(
                        underline: const SizedBox(
                          width: 1,
                        ),
                        value: gender,
                        borderRadius: BorderRadius.circular(10.0),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        elevation: 16,
                        onChanged: (String? value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                        items: listGender
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Constants.mainPadding * 2, vertical: 10),
                    child: Text(
                      'Birthday',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: Constants.mainPadding * 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(14)),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    CustomColor.primaryColor.withOpacity(0.2),
                                blurRadius: 8.0,
                                offset: const Offset(1.0, 1.0),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.only(left: 10, right: 8),
                          child: DropdownButton<String>(
                            underline: const SizedBox(
                              width: 1,
                            ),
                            value: birthDate,
                            hint: const Text('DD'),
                            borderRadius: BorderRadius.circular(10.0),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            elevation: 16,
                            onChanged: (String? value) {
                              setState(() {
                                birthDate = value!;
                              });
                            },
                            items: listDate
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(14)),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    CustomColor.primaryColor.withOpacity(0.2),
                                blurRadius: 8.0,
                                offset: const Offset(1.0, 1.0),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.only(left: 10, right: 8),
                          child: DropdownButton<String>(
                            underline: const SizedBox(
                              width: 1,
                            ),
                            value: birthMonth,
                            hint: const Text('MM'),
                            borderRadius: BorderRadius.circular(10.0),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            elevation: 16,
                            onChanged: (String? value) {
                              setState(() {
                                birthMonth = value!;
                              });
                            },
                            items: listMonth
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(14)),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    CustomColor.primaryColor.withOpacity(0.2),
                                blurRadius: 8.0,
                                offset: const Offset(1.0, 1.0),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.only(left: 10, right: 8),
                          child: DropdownButton<String>(
                            underline: const SizedBox(
                              width: 1,
                            ),
                            value: birthYear,
                            hint: const Text('YY'),
                            borderRadius: BorderRadius.circular(10.0),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            elevation: 16,
                            onChanged: (String? value) {
                              setState(() {
                                birthYear = value!;
                              });
                            },
                            items: listYear
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
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
                            if (_formKey.currentState!.validate()) {
                              _saveProfile(onCallback: () {
                                setState(() {});
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Successfully Updated.')),
                                );
                              }, onError: (String text) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(text)),
                                );
                              });
                            }
                          },
                          child: const Text(
                            'Save',
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
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: Constants.mainPadding * 2),
              child: SizedBox(
                  height: 40,
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        shadowColor: CustomColor.primaryColor.withOpacity(0.5),
                        padding: const EdgeInsets.all(5)),
                    onPressed: () {
                      AppModel().userLogout(onSuccess: () {
                        context.go('/');
                      });
                    },
                    child: const Text(
                      'Log Out',
                      style: TextStyle(
                          color: CustomColor.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          letterSpacing: 1),
                    ),
                  )),
            ),
            const SizedBox(height: 50),
            const BottomBar()
          ],
        ),
      ),
    );
  }
}
