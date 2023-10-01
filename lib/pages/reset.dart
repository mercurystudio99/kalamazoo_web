import 'package:bestlocaleats/models/app_model.dart';
import 'package:bestlocaleats/utils/constants.dart';
import 'package:bestlocaleats/utils/colors.dart';
import 'package:bestlocaleats/widgets/top_bar.dart';
import 'package:bestlocaleats/widgets/responsive.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResetPage extends StatefulWidget {
  const ResetPage({super.key});

  @override
  State<ResetPage> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  final List _isHovering = [
    false, // 0: logo
  ];

  bool _obscureText1 = true;
  bool _obscureText2 = true;

  final _formKey = GlobalKey<FormState>();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  // Toggles the password show status
  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
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

  @override
  void initState() {
    super.initState();
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
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: TopBarContents(0, 0, 'reset', (param) {
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
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Constants.mainPadding),
                        child: Text(
                          'Reset Password',
                          style: TextStyle(
                              color: CustomColor.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 38),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Constants.mainPadding * 2),
                            child: RichText(
                              text: const TextSpan(children: [
                                TextSpan(
                                  text:
                                      'Your passwords must be at least 8 characters long,\nand contain at least one letter and one digit',
                                ),
                              ]),
                            )),
                      ),
                      const SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: Constants.mainPadding * 2),
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
                                    controller: _newController,
                                    obscureText: _obscureText1,
                                    decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        hintText: 'New Password',
                                        suffixIconConstraints:
                                            const BoxConstraints(
                                          minWidth: 50,
                                          minHeight: 2,
                                        ),
                                        suffixIcon: InkWell(
                                            onTap: _toggle1,
                                            child: Icon(
                                                _obscureText1
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
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: Constants.mainPadding * 2),
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
                                    controller: _confirmController,
                                    obscureText: _obscureText2,
                                    decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        hintText: 'Confirm Password',
                                        suffixIconConstraints:
                                            const BoxConstraints(
                                          minWidth: 50,
                                          minHeight: 2,
                                        ),
                                        suffixIcon: InkWell(
                                            onTap: _toggle2,
                                            child: Icon(
                                                _obscureText2
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
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: Constants.mainPadding * 2),
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
                                          const SnackBar(
                                              content: Text('Processing Data')),
                                        );
                                        AppModel().userResetPassword(
                                            newPass: _newController.text.trim(),
                                            confirmPass:
                                                _confirmController.text.trim(),
                                            onSuccess: () {
                                              context.go('/');
                                            },
                                            onError: (String text) {
                                              // Show error message
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(content: Text(text)),
                                              );
                                            });
                                      }
                                    },
                                    child: const Text(
                                      'Submit',
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
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.mainPadding, vertical: 20),
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
                  'Reset Password',
                  style: TextStyle(
                      color: CustomColor.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 38),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Constants.mainPadding * 2),
                    child: RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                          text:
                              'Your passwords must be at least 8 characters long,\nand contain at least one letter and one digit',
                        ),
                      ]),
                    )),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                    color: CustomColor.primaryColor
                                        .withOpacity(0.2),
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                    offset: const Offset(0, 0)),
                              ],
                            ),
                          ),
                          TextFormField(
                            controller: _newController,
                            obscureText: _obscureText1,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: 'New Password',
                                suffixIconConstraints: const BoxConstraints(
                                  minWidth: 50,
                                  minHeight: 2,
                                ),
                                suffixIcon: InkWell(
                                    onTap: _toggle1,
                                    child: Icon(
                                        _obscureText1
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
                                    color: CustomColor.primaryColor
                                        .withOpacity(0.2),
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                    offset: const Offset(0, 0)),
                              ],
                            ),
                          ),
                          TextFormField(
                            controller: _confirmController,
                            obscureText: _obscureText2,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: 'Confirm Password',
                                suffixIconConstraints: const BoxConstraints(
                                  minWidth: 50,
                                  minHeight: 2,
                                ),
                                suffixIcon: InkWell(
                                    onTap: _toggle2,
                                    child: Icon(
                                        _obscureText2
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
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );
                                AppModel().userResetPassword(
                                    newPass: _newController.text.trim(),
                                    confirmPass: _confirmController.text.trim(),
                                    onSuccess: () {
                                      context.go('/');
                                    },
                                    onError: (String text) {
                                      // Show error message
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(content: Text(text)),
                                      );
                                    });
                              }
                            },
                            child: const Text(
                              'Submit',
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
            ],
          ),
        ),
      ),
    );
  }
}
