import 'package:bestlocaleats/models/app_model.dart';
import 'package:bestlocaleats/utils/constants.dart';
import 'package:bestlocaleats/utils/colors.dart';
import 'package:bestlocaleats/widgets/top_bar.dart';
import 'package:bestlocaleats/widgets/responsive.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final List _isHovering = [
    false, // 0: logo
  ];

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _businessController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  late List<Map<String, dynamic>> amenities = [];
  late final Map<String, dynamic> _isCheckedAmenities = {};

  bool _obscureText = true;
  bool _isChecked = false;
  bool _showDaysHours = false;
  bool _showAmenities = false;
  final bool _checkConfirmBusiness = false;
  final List<bool> _isCheckedBusiness = <bool>[
    false,
    false,
    false,
    false,
    false
  ];

  void _getAmenities() {
    AppModel().getAmenities(
      onSuccess: (List<Map<String, dynamic>> param) {
        amenities = param;
        for (var element in amenities) {
          _isCheckedAmenities[element[Constants.AMENITY_ID]] = false;
        }
        setState(() {});
      },
      onEmpty: () {},
    );
  }

  @override
  void initState() {
    super.initState();
    _getAmenities();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'The Password must be at least 8 characters.';
    }
    return null;
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

  String? _validateBusiness(String value) {
    if (value.isEmpty) {
      return "Please enter your business name";
    }
    return null;
  }

  String? _validateAddress(String value) {
    if (value.isEmpty) {
      return "Please enter your address";
    }
    return null;
  }

  String? _validatePhone(String value) {
    if (value.isEmpty) {
      return "Please enter your phone number";
    }
    return null;
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
    Size screenSize = MediaQuery.of(context).size;
    double rightSidePaddingX = Constants.mainPadding * 2;
    double checkItemWidth = screenSize.width / 6 - Constants.mainPadding / 2;
    if (screenSize.width < 1200) {
      rightSidePaddingX = Constants.mainPadding;
      checkItemWidth = screenSize.width / 6;
    }
    if (screenSize.width < 1000) {
      rightSidePaddingX = 10;
      checkItemWidth = screenSize.width / 6 + Constants.mainPadding / 2;
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: TopBarContents(0, 0, 'register', (param) {
          debugPrint('---');
        }),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.mainPadding, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: screenSize.width * 0.5,
                      child: Center(
                        child: Image.asset(Constants.IMG_START,
                            width: screenSize.width * 0.35,
                            height: screenSize.width * 0.35),
                      )),
                  Expanded(
                      child: Column(
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: rightSidePaddingX),
                        child: const Text(
                          'Register',
                          style: TextStyle(
                              color: CustomColor.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 38),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: rightSidePaddingX),
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
                                      hintText: 'Personal Name',
                                    ),
                                    validator: (value) {
                                      return _validateName(value!);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: rightSidePaddingX),
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
                                    controller: _businessController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Business Name',
                                    ),
                                    validator: (value) {
                                      return _validateBusiness(value!);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: rightSidePaddingX),
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
                                    controller: _addressController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Add Address',
                                    ),
                                    validator: (value) {
                                      return _validateAddress(value!);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: rightSidePaddingX),
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
                                      hintText: 'Phone Number',
                                    ),
                                    validator: (value) {
                                      return _validatePhone(value!);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: rightSidePaddingX),
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
                                      hintText: 'Email Address',
                                    ),
                                    validator: (value) {
                                      return _validateEmail(value!);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: rightSidePaddingX),
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
                                    controller: _passController,
                                    obscureText: _obscureText,
                                    decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        hintText: 'Password',
                                        suffixIconConstraints:
                                            const BoxConstraints(
                                          minWidth: 50,
                                          minHeight: 2,
                                        ),
                                        suffixIcon: InkWell(
                                            onTap: _toggle,
                                            child: Icon(
                                                _obscureText
                                                    ? Icons
                                                        .remove_red_eye_outlined
                                                    : Icons
                                                        .visibility_off_outlined,
                                                color: CustomColor
                                                    .textSecondaryColor,
                                                size: 24))),
                                    validator: (value) {
                                      return _validatePassword(value!);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: rightSidePaddingX),
                              child: Stack(children: [
                                Container(
                                  height: _showDaysHours ? 204 : 50,
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
                                          Row(children: [
                                            const Text(
                                              'Business Day/Hours',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            const Spacer(),
                                            IconButton(
                                              icon: Icon(
                                                _showDaysHours
                                                    ? Icons.keyboard_arrow_down
                                                    : Icons
                                                        .keyboard_arrow_right,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _showDaysHours =
                                                      !_showDaysHours;
                                                });
                                              },
                                            ),
                                          ]),
                                          // Show or hide the content based on the state
                                          _showDaysHours
                                              ? Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 12),
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const Text(
                                                                  'Tuesday',
                                                                  style: TextStyle(
                                                                      color: CustomColor
                                                                          .textSecondaryColor,
                                                                      fontSize:
                                                                          12)),
                                                              const Spacer(),
                                                              const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            50),
                                                                child: Text(
                                                                    'Closed',
                                                                    style: TextStyle(
                                                                        color: CustomColor
                                                                            .activeColor,
                                                                        fontSize:
                                                                            12)),
                                                              ),
                                                              InkWell(
                                                                  onTap: () {},
                                                                  child:
                                                                      const Icon(
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
                                                              const Text(
                                                                  'Wednesday',
                                                                  style: TextStyle(
                                                                      color: CustomColor
                                                                          .textSecondaryColor,
                                                                      fontSize:
                                                                          12)),
                                                              const Spacer(),
                                                              const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            50),
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
                                                                  child:
                                                                      const Icon(
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
                                                              const Text(
                                                                  'Thursday',
                                                                  style: TextStyle(
                                                                      color: CustomColor
                                                                          .textSecondaryColor,
                                                                      fontSize:
                                                                          12)),
                                                              const Spacer(),
                                                              const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            50),
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
                                                                  child:
                                                                      const Icon(
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
                                                              const Text(
                                                                  'Friday',
                                                                  style: TextStyle(
                                                                      color: CustomColor
                                                                          .textSecondaryColor,
                                                                      fontSize:
                                                                          12)),
                                                              const Spacer(),
                                                              const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            50),
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
                                                                  child:
                                                                      const Icon(
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
                                                              const Text(
                                                                  'Saturday',
                                                                  style: TextStyle(
                                                                      color: CustomColor
                                                                          .textSecondaryColor,
                                                                      fontSize:
                                                                          12)),
                                                              const Spacer(),
                                                              const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            50),
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
                                                                  child:
                                                                      const Icon(
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
                                                              const Text(
                                                                  'Sunday',
                                                                  style: TextStyle(
                                                                      color: CustomColor
                                                                          .textSecondaryColor,
                                                                      fontSize:
                                                                          12)),
                                                              const Spacer(),
                                                              const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            50),
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
                                                                  child:
                                                                      const Icon(
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
                                                              const Text(
                                                                  'Monday',
                                                                  style: TextStyle(
                                                                      color: CustomColor
                                                                          .textSecondaryColor,
                                                                      fontSize:
                                                                          12)),
                                                              const Spacer(),
                                                              const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            50),
                                                                child: Text(
                                                                    'Closed',
                                                                    style: TextStyle(
                                                                        color: CustomColor
                                                                            .activeColor,
                                                                        fontSize:
                                                                            12)),
                                                              ),
                                                              InkWell(
                                                                  onTap: () {},
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .edit_outlined,
                                                                    size: 22,
                                                                  )),
                                                            ]),
                                                      ]),
                                                )
                                              : Container(),
                                        ])))
                              ]),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: rightSidePaddingX),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        width: checkItemWidth,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 6),
                                          child: Row(children: [
                                            Container(
                                              width: 24,
                                              height: 24,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color:
                                                          Colors.grey.shade400,
                                                      blurRadius: 5,
                                                      spreadRadius: 1),
                                                ],
                                              ),
                                              child: ColoredBox(
                                                  color: Colors.white,
                                                  child: Transform.scale(
                                                    scale: 1.3,
                                                    child: Checkbox(
                                                      side: const BorderSide(
                                                          color: Colors.white),
                                                      checkColor: Colors.white,
                                                      fillColor:
                                                          MaterialStateProperty
                                                              .resolveWith<
                                                                  Color>((Set<
                                                                      MaterialState>
                                                                  states) {
                                                        if (states.contains(
                                                            MaterialState
                                                                .disabled)) {
                                                          return (_checkConfirmBusiness
                                                              ? CustomColor
                                                                  .activeColor
                                                              : CustomColor
                                                                  .primaryColor);
                                                        }
                                                        return (_checkConfirmBusiness
                                                            ? CustomColor
                                                                .activeColor
                                                            : CustomColor
                                                                .primaryColor);
                                                      }),
                                                      value:
                                                          _isCheckedBusiness[0],
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          _isCheckedBusiness[
                                                              0] = value!;
                                                        });
                                                      },
                                                    ),
                                                  )),
                                            ),
                                            const SizedBox(width: 5),
                                            const Text(
                                              'Brewery',
                                              style: TextStyle(fontSize: 16),
                                            )
                                          ]),
                                        )),
                                    SizedBox(
                                        width: checkItemWidth,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 6),
                                          child: Row(children: [
                                            Container(
                                              width: 24,
                                              height: 24,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color:
                                                          Colors.grey.shade400,
                                                      blurRadius: 5,
                                                      spreadRadius: 1),
                                                ],
                                              ),
                                              child: ColoredBox(
                                                  color: Colors.white,
                                                  child: Transform.scale(
                                                    scale: 1.3,
                                                    child: Checkbox(
                                                      side: const BorderSide(
                                                          color: Colors.white),
                                                      checkColor: Colors.white,
                                                      fillColor:
                                                          MaterialStateProperty
                                                              .resolveWith<
                                                                  Color>((Set<
                                                                      MaterialState>
                                                                  states) {
                                                        if (states.contains(
                                                            MaterialState
                                                                .disabled)) {
                                                          return (_checkConfirmBusiness
                                                              ? CustomColor
                                                                  .activeColor
                                                              : CustomColor
                                                                  .primaryColor);
                                                        }
                                                        return (_checkConfirmBusiness
                                                            ? CustomColor
                                                                .activeColor
                                                            : CustomColor
                                                                .primaryColor);
                                                      }),
                                                      value:
                                                          _isCheckedBusiness[1],
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          _isCheckedBusiness[
                                                              1] = value!;
                                                        });
                                                      },
                                                    ),
                                                  )),
                                            ),
                                            const SizedBox(width: 5),
                                            const Text(
                                              'Food Truck',
                                              style: TextStyle(fontSize: 16),
                                            )
                                          ]),
                                        )),
                                  ]),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: rightSidePaddingX),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        width: checkItemWidth,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 6),
                                          child: Row(children: [
                                            Container(
                                              width: 24,
                                              height: 24,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color:
                                                          Colors.grey.shade400,
                                                      blurRadius: 5,
                                                      spreadRadius: 1),
                                                ],
                                              ),
                                              child: ColoredBox(
                                                  color: Colors.white,
                                                  child: Transform.scale(
                                                    scale: 1.3,
                                                    child: Checkbox(
                                                      side: const BorderSide(
                                                          color: Colors.white),
                                                      checkColor: Colors.white,
                                                      fillColor:
                                                          MaterialStateProperty
                                                              .resolveWith<
                                                                  Color>((Set<
                                                                      MaterialState>
                                                                  states) {
                                                        if (states.contains(
                                                            MaterialState
                                                                .disabled)) {
                                                          return (_checkConfirmBusiness
                                                              ? CustomColor
                                                                  .activeColor
                                                              : CustomColor
                                                                  .primaryColor);
                                                        }
                                                        return (_checkConfirmBusiness
                                                            ? CustomColor
                                                                .activeColor
                                                            : CustomColor
                                                                .primaryColor);
                                                      }),
                                                      value:
                                                          _isCheckedBusiness[2],
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          _isCheckedBusiness[
                                                              2] = value!;
                                                        });
                                                      },
                                                    ),
                                                  )),
                                            ),
                                            const SizedBox(width: 5),
                                            const Text(
                                              'Restaurant',
                                              style: TextStyle(fontSize: 16),
                                            )
                                          ]),
                                        )),
                                    SizedBox(
                                        width: checkItemWidth,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 6),
                                          child: Row(children: [
                                            Container(
                                              width: 24,
                                              height: 24,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color:
                                                          Colors.grey.shade400,
                                                      blurRadius: 5,
                                                      spreadRadius: 1),
                                                ],
                                              ),
                                              child: ColoredBox(
                                                  color: Colors.white,
                                                  child: Transform.scale(
                                                    scale: 1.3,
                                                    child: Checkbox(
                                                      side: const BorderSide(
                                                          color: Colors.white),
                                                      checkColor: Colors.white,
                                                      fillColor:
                                                          MaterialStateProperty
                                                              .resolveWith<
                                                                  Color>((Set<
                                                                      MaterialState>
                                                                  states) {
                                                        if (states.contains(
                                                            MaterialState
                                                                .disabled)) {
                                                          return (_checkConfirmBusiness
                                                              ? CustomColor
                                                                  .activeColor
                                                              : CustomColor
                                                                  .primaryColor);
                                                        }
                                                        return (_checkConfirmBusiness
                                                            ? CustomColor
                                                                .activeColor
                                                            : CustomColor
                                                                .primaryColor);
                                                      }),
                                                      value:
                                                          _isCheckedBusiness[3],
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          _isCheckedBusiness[
                                                              3] = value!;
                                                        });
                                                      },
                                                    ),
                                                  )),
                                            ),
                                            const SizedBox(width: 5),
                                            const Text(
                                              'Winery',
                                              style: TextStyle(fontSize: 16),
                                            )
                                          ]),
                                        )),
                                  ]),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: rightSidePaddingX),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        width: checkItemWidth,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 6),
                                          child: Row(children: [
                                            Container(
                                              width: 24,
                                              height: 24,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color:
                                                          Colors.grey.shade400,
                                                      blurRadius: 5,
                                                      spreadRadius: 1),
                                                ],
                                              ),
                                              child: ColoredBox(
                                                  color: Colors.white,
                                                  child: Transform.scale(
                                                    scale: 1.3,
                                                    child: Checkbox(
                                                      side: const BorderSide(
                                                          color: Colors.white),
                                                      checkColor: Colors.white,
                                                      fillColor:
                                                          MaterialStateProperty
                                                              .resolveWith<
                                                                  Color>((Set<
                                                                      MaterialState>
                                                                  states) {
                                                        if (states.contains(
                                                            MaterialState
                                                                .disabled)) {
                                                          return (_checkConfirmBusiness
                                                              ? CustomColor
                                                                  .activeColor
                                                              : CustomColor
                                                                  .primaryColor);
                                                        }
                                                        return (_checkConfirmBusiness
                                                            ? CustomColor
                                                                .activeColor
                                                            : CustomColor
                                                                .primaryColor);
                                                      }),
                                                      value:
                                                          _isCheckedBusiness[4],
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          _isCheckedBusiness[
                                                              4] = value!;
                                                        });
                                                      },
                                                    ),
                                                  )),
                                            ),
                                            const SizedBox(width: 5),
                                            const Text(
                                              'Catering',
                                              style: TextStyle(fontSize: 16),
                                            )
                                          ]),
                                        )),
                                  ]),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: rightSidePaddingX),
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
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: rightSidePaddingX),
                              child: Stack(children: [
                                Container(
                                  height: _showAmenities ? 735 : 50,
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
                                          Row(children: [
                                            Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: const BoxDecoration(
                                                    color: Colors.white),
                                                alignment:
                                                    const Alignment(0, 0),
                                                child: Image.asset(
                                                    Constants.IMG_AMENITIES)),
                                            const Text(
                                              'Amenities',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            const Spacer(),
                                            IconButton(
                                              icon: Icon(
                                                _showAmenities
                                                    ? Icons.keyboard_arrow_down
                                                    : Icons
                                                        .keyboard_arrow_right,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _showAmenities =
                                                      !_showAmenities;
                                                });
                                              },
                                            ),
                                          ]),
                                          // Show or hide the content based on the state
                                          _showAmenities
                                              ? _listing()
                                              : Container(),
                                        ])))
                              ]),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 30, horizontal: rightSidePaddingX),
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
                                      'PROMOTE YOUR BUSINESS',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          letterSpacing: 1),
                                    ),
                                  )),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                      checkColor: Colors.white,
                                      fillColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.disabled)) {
                                          return Colors.black;
                                        }
                                        return Colors.black;
                                      }),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      value: _isChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _isChecked = value!;
                                        });
                                      },
                                    ),
                                    RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text: (screenSize.width < 1000)
                                              ? 'Agree to the'
                                              : 'By Signing up i Agree to the',
                                        ),
                                        const TextSpan(text: ' '),
                                        TextSpan(
                                            text:
                                                'term and Condition & privacy Police',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {}),
                                      ]),
                                    ),
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: 'Already have an account?',
                                            style: GoogleFonts.poppins(
                                                color: CustomColor
                                                    .textPrimaryColor)),
                                        const TextSpan(text: '  '),
                                        TextSpan(
                                            text: 'Login',
                                            style: GoogleFonts.poppins(
                                                color:
                                                    CustomColor.primaryColor),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                context.go('/login');
                                              }),
                                      ]),
                                    ),
                                  ]),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: rightSidePaddingX),
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
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(content: Text('OK')),
                                        );
                                      }
                                    },
                                    child: const Text(
                                      'Create Account',
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
                      const SizedBox(height: 10),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 1),
                          child: Text(
                            '\'Do You Need Help? Contact Us!\'',
                            style: TextStyle(
                                fontSize: 15,
                                color: CustomColor.textPrimaryColor),
                          )),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 1),
                          child: Text(
                            'contactus@bestlocaleats.net',
                            style: TextStyle(
                                fontSize: 15, color: CustomColor.primaryColor),
                          )),
                      const SizedBox(height: 10),
                    ],
                  )),
                ],
              )),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: <Widget>[
              SizedBox(
                  width: screenSize.width,
                  child: Center(
                    child: Image.asset(Constants.IMG_START,
                        width: screenSize.width * 0.5,
                        height: screenSize.width * 0.5),
                  )),
              const SizedBox(height: 20),
              const Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: Constants.mainPadding),
                child: Text(
                  'Register',
                  style: TextStyle(
                      color: CustomColor.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 38),
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: Constants.mainPadding),
                      child: Stack(
                        children: [
                          Container(
                            height: 56,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
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
                              hintText: 'Personal Name',
                            ),
                            validator: (value) {
                              return _validateName(value!);
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: Constants.mainPadding),
                      child: Stack(
                        children: [
                          Container(
                            height: 56,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
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
                            controller: _businessController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Business Name',
                            ),
                            validator: (value) {
                              return _validateBusiness(value!);
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: Constants.mainPadding),
                      child: Stack(
                        children: [
                          Container(
                            height: 56,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
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
                            controller: _addressController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Add Address',
                            ),
                            validator: (value) {
                              return _validateAddress(value!);
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: Constants.mainPadding),
                      child: Stack(
                        children: [
                          Container(
                            height: 56,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
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
                              hintText: 'Phone Number',
                            ),
                            validator: (value) {
                              return _validatePhone(value!);
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: Constants.mainPadding),
                      child: Stack(
                        children: [
                          Container(
                            height: 56,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
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
                              hintText: 'Email Address',
                            ),
                            validator: (value) {
                              return _validateEmail(value!);
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: Constants.mainPadding),
                      child: Stack(
                        children: [
                          Container(
                            height: 56,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
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
                            controller: _passController,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: 'Password',
                                suffixIconConstraints: const BoxConstraints(
                                  minWidth: 50,
                                  minHeight: 2,
                                ),
                                suffixIcon: InkWell(
                                    onTap: _toggle,
                                    child: Icon(
                                        _obscureText
                                            ? Icons.remove_red_eye_outlined
                                            : Icons.visibility_off_outlined,
                                        color: CustomColor.textSecondaryColor,
                                        size: 24))),
                            validator: (value) {
                              return _validatePassword(value!);
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          Constants.mainPadding, 8, Constants.mainPadding, 8),
                      child: Stack(children: [
                        Container(
                          height: _showDaysHours ? 204 : 50,
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
                                  Row(children: [
                                    const Text(
                                      'Business Day/Hours',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      icon: Icon(
                                        _showDaysHours
                                            ? Icons.keyboard_arrow_down
                                            : Icons.keyboard_arrow_right,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _showDaysHours = !_showDaysHours;
                                        });
                                      },
                                    ),
                                  ]),
                                  // Show or hide the content based on the state
                                  _showDaysHours
                                      ? Container(
                                          padding:
                                              const EdgeInsets.only(right: 12),
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
                                                            EdgeInsets.only(
                                                                right: 50),
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
                                                            EdgeInsets.only(
                                                                right: 50),
                                                        child: Text(
                                                            '8:00 AM - 9:00 PM',
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
                                                            EdgeInsets.only(
                                                                right: 50),
                                                        child: Text(
                                                            '8:00 AM - 9:00 PM',
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
                                                            EdgeInsets.only(
                                                                right: 50),
                                                        child: Text(
                                                            '8:00 AM - 9:00 PM',
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
                                                            EdgeInsets.only(
                                                                right: 50),
                                                        child: Text(
                                                            '8:00 AM - 9:00 PM',
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
                                                            EdgeInsets.only(
                                                                right: 50),
                                                        child: Text(
                                                            '8:00 AM - 9:00 PM',
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
                                                            EdgeInsets.only(
                                                                right: 50),
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
                                      : Container(),
                                ])))
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: Constants.mainPadding),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: screenSize.width * 0.3,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  child: Row(children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.shade400,
                                              blurRadius: 5,
                                              spreadRadius: 1),
                                        ],
                                      ),
                                      child: ColoredBox(
                                          color: Colors.white,
                                          child: Transform.scale(
                                            scale: 1.3,
                                            child: Checkbox(
                                              side: const BorderSide(
                                                  color: Colors.white),
                                              checkColor: Colors.white,
                                              fillColor: MaterialStateProperty
                                                  .resolveWith<Color>(
                                                      (Set<MaterialState>
                                                          states) {
                                                if (states.contains(
                                                    MaterialState.disabled)) {
                                                  return (_checkConfirmBusiness
                                                      ? CustomColor.activeColor
                                                      : CustomColor
                                                          .primaryColor);
                                                }
                                                return (_checkConfirmBusiness
                                                    ? CustomColor.activeColor
                                                    : CustomColor.primaryColor);
                                              }),
                                              value: _isCheckedBusiness[0],
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  _isCheckedBusiness[0] =
                                                      value!;
                                                });
                                              },
                                            ),
                                          )),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      'Brewery',
                                      style: TextStyle(fontSize: 16),
                                    )
                                  ]),
                                )),
                            SizedBox(
                                width: screenSize.width * 0.3,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  child: Row(children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.shade400,
                                              blurRadius: 5,
                                              spreadRadius: 1),
                                        ],
                                      ),
                                      child: ColoredBox(
                                          color: Colors.white,
                                          child: Transform.scale(
                                            scale: 1.3,
                                            child: Checkbox(
                                              side: const BorderSide(
                                                  color: Colors.white),
                                              checkColor: Colors.white,
                                              fillColor: MaterialStateProperty
                                                  .resolveWith<Color>(
                                                      (Set<MaterialState>
                                                          states) {
                                                if (states.contains(
                                                    MaterialState.disabled)) {
                                                  return (_checkConfirmBusiness
                                                      ? CustomColor.activeColor
                                                      : CustomColor
                                                          .primaryColor);
                                                }
                                                return (_checkConfirmBusiness
                                                    ? CustomColor.activeColor
                                                    : CustomColor.primaryColor);
                                              }),
                                              value: _isCheckedBusiness[1],
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  _isCheckedBusiness[1] =
                                                      value!;
                                                });
                                              },
                                            ),
                                          )),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      'Food Truck',
                                      style: TextStyle(fontSize: 16),
                                    )
                                  ]),
                                )),
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: Constants.mainPadding),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: screenSize.width * 0.3,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  child: Row(children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.shade400,
                                              blurRadius: 5,
                                              spreadRadius: 1),
                                        ],
                                      ),
                                      child: ColoredBox(
                                          color: Colors.white,
                                          child: Transform.scale(
                                            scale: 1.3,
                                            child: Checkbox(
                                              side: const BorderSide(
                                                  color: Colors.white),
                                              checkColor: Colors.white,
                                              fillColor: MaterialStateProperty
                                                  .resolveWith<Color>(
                                                      (Set<MaterialState>
                                                          states) {
                                                if (states.contains(
                                                    MaterialState.disabled)) {
                                                  return (_checkConfirmBusiness
                                                      ? CustomColor.activeColor
                                                      : CustomColor
                                                          .primaryColor);
                                                }
                                                return (_checkConfirmBusiness
                                                    ? CustomColor.activeColor
                                                    : CustomColor.primaryColor);
                                              }),
                                              value: _isCheckedBusiness[2],
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  _isCheckedBusiness[2] =
                                                      value!;
                                                });
                                              },
                                            ),
                                          )),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      'Restaurant',
                                      style: TextStyle(fontSize: 16),
                                    )
                                  ]),
                                )),
                            SizedBox(
                                width: screenSize.width * 0.3,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  child: Row(children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.shade400,
                                              blurRadius: 5,
                                              spreadRadius: 1),
                                        ],
                                      ),
                                      child: ColoredBox(
                                          color: Colors.white,
                                          child: Transform.scale(
                                            scale: 1.3,
                                            child: Checkbox(
                                              side: const BorderSide(
                                                  color: Colors.white),
                                              checkColor: Colors.white,
                                              fillColor: MaterialStateProperty
                                                  .resolveWith<Color>(
                                                      (Set<MaterialState>
                                                          states) {
                                                if (states.contains(
                                                    MaterialState.disabled)) {
                                                  return (_checkConfirmBusiness
                                                      ? CustomColor.activeColor
                                                      : CustomColor
                                                          .primaryColor);
                                                }
                                                return (_checkConfirmBusiness
                                                    ? CustomColor.activeColor
                                                    : CustomColor.primaryColor);
                                              }),
                                              value: _isCheckedBusiness[3],
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  _isCheckedBusiness[3] =
                                                      value!;
                                                });
                                              },
                                            ),
                                          )),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      'Winery',
                                      style: TextStyle(fontSize: 16),
                                    )
                                  ]),
                                )),
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: Constants.mainPadding),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: screenSize.width * 0.3,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  child: Row(children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.shade400,
                                              blurRadius: 5,
                                              spreadRadius: 1),
                                        ],
                                      ),
                                      child: ColoredBox(
                                          color: Colors.white,
                                          child: Transform.scale(
                                            scale: 1.3,
                                            child: Checkbox(
                                              side: const BorderSide(
                                                  color: Colors.white),
                                              checkColor: Colors.white,
                                              fillColor: MaterialStateProperty
                                                  .resolveWith<Color>(
                                                      (Set<MaterialState>
                                                          states) {
                                                if (states.contains(
                                                    MaterialState.disabled)) {
                                                  return (_checkConfirmBusiness
                                                      ? CustomColor.activeColor
                                                      : CustomColor
                                                          .primaryColor);
                                                }
                                                return (_checkConfirmBusiness
                                                    ? CustomColor.activeColor
                                                    : CustomColor.primaryColor);
                                              }),
                                              value: _isCheckedBusiness[4],
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  _isCheckedBusiness[4] =
                                                      value!;
                                                });
                                              },
                                            ),
                                          )),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      'Catering',
                                      style: TextStyle(fontSize: 16),
                                    )
                                  ]),
                                )),
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: Constants.mainPadding),
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          Constants.mainPadding, 8, Constants.mainPadding, 0),
                      child: Stack(children: [
                        Container(
                          height: _showAmenities ? 735 : 50,
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
                                  Row(children: [
                                    Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: const BoxDecoration(
                                            color: Colors.white),
                                        alignment: const Alignment(0, 0),
                                        child: Image.asset(
                                            Constants.IMG_AMENITIES)),
                                    const Text(
                                      'Amenities',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      icon: Icon(
                                        _showAmenities
                                            ? Icons.keyboard_arrow_down
                                            : Icons.keyboard_arrow_right,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _showAmenities = !_showAmenities;
                                        });
                                      },
                                    ),
                                  ]),
                                  // Show or hide the content based on the state
                                  _showAmenities ? _listing() : Container(),
                                ])))
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: Constants.mainPadding),
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
                              'PROMOTE YOUR BUSINESS',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  letterSpacing: 1),
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              fillColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return Colors.black;
                                }
                                return Colors.black;
                              }),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3)),
                              value: _isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked = value!;
                                });
                              },
                            ),
                            RichText(
                              text: TextSpan(children: [
                                const TextSpan(
                                  text: 'By Signing up i Agree to the',
                                ),
                                const TextSpan(text: ' '),
                                TextSpan(
                                    text: 'term and Condition & privacy Police',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {}),
                              ]),
                            ),
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'Already have an account?',
                                    style: GoogleFonts.poppins(
                                        color: CustomColor.textPrimaryColor)),
                                const TextSpan(text: '  '),
                                TextSpan(
                                    text: 'Login',
                                    style: GoogleFonts.poppins(
                                        color: CustomColor.primaryColor),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        context.go('/login');
                                      }),
                              ]),
                            ),
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: Constants.mainPadding),
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
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('OK')),
                                );
                              }
                            },
                            child: const Text(
                              'Create Account',
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
              const SizedBox(height: 10),
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 1),
                  child: Text(
                    '\'Do You Need Help? Contact Us!\'',
                    style: TextStyle(
                        fontSize: 15, color: CustomColor.textPrimaryColor),
                  )),
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 1),
                  child: Text(
                    'contactus@bestlocaleats.net',
                    style: TextStyle(
                        fontSize: 15, color: CustomColor.primaryColor),
                  )),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listing() {
    Size size = MediaQuery.of(context).size;
    int length = 18;
    double itemWidth = size.width / 6 - Constants.mainPadding / 2;
    if (size.width < 1400) {
      length = 14;
    }
    if (size.width < 1200) {
      itemWidth = size.width / 6;
      length = 10;
    }
    if (size.width < 1000) {
      itemWidth = size.width / 6 + Constants.mainPadding / 2;
      length = 8;
    }
    if (size.width < 800) {
      length = 18;
      itemWidth = size.width / 2 - Constants.mainPadding * 2;
    }
    if (size.width < 600) {
      length = 12;
    }

    List<Widget> lists = amenities.map((item) {
      return SizedBox(
          width: itemWidth,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 5,
                        spreadRadius: 1),
                  ],
                ),
                child: ColoredBox(
                    color: Colors.white,
                    child: Transform.scale(
                      scale: 1.3,
                      child: Checkbox(
                        side: const BorderSide(color: Colors.white),
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return CustomColor.primaryColor;
                          }
                          return CustomColor.primaryColor;
                        }),
                        value: _isCheckedAmenities[item[Constants.AMENITY_ID]],
                        onChanged: (bool? value) {
                          setState(() {
                            _isCheckedAmenities[item[Constants.AMENITY_ID]] =
                                value!;
                          });
                        },
                      ),
                    )),
              ),
              const SizedBox(width: 5),
              Image.asset(
                '${Constants.imagePath}amenities/icon (${item[Constants.AMENITY_LOGO]}).png',
              ),
              const SizedBox(width: 5),
              Text(item[Constants.AMENITY_NAME].toString().length < length
                  ? item[Constants.AMENITY_NAME]
                  : '${item[Constants.AMENITY_NAME].toString().substring(0, length - 2)}..')
            ]),
          ));
    }).toList();
    int rowCount = lists.length ~/ 2;
    List<Widget> rowList = [];
    for (int i = 0; i < rowCount + 1; i++) {
      if (lists.length > 2 * (i + 1)) {
        rowList.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: lists.sublist(2 * i, 2 * (i + 1))));
      } else {
        rowList.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: lists.sublist(2 * i, lists.length)));
      }
    }

    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: rowList),
    );
  }
}
