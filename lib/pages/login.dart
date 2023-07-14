import 'package:bestlocaleats/utils/constants.dart';
import 'package:bestlocaleats/utils/router.dart';
import 'package:bestlocaleats/utils/colors.dart';
import 'package:bestlocaleats/widgets/top_bar.dart';
import 'package:bestlocaleats/widgets/responsive.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final List _isHovering = [
    false, // 0: logo
  ];

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final FocusNode _focusEmail = FocusNode();
  final FocusNode _focusPass = FocusNode();

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _focusEmail.dispose();
    _focusPass.dispose();
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
      return '\u26A0 Please enter your password';
    }
    if (value.length < 8) {
      return '\u26A0 The Password must be at least 8 characters.';
    }
    return null;
  }

  String? _validateEmail(String value) {
    if (value.isEmpty) {
      return "\u26A0 Please enter your email";
    }
    if (!(value.isNotEmpty && value.contains("@") && value.contains("."))) {
      return '\u26A0 The E-mail Address must be a valid email address.';
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: const TopBarContents(0, 0),
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
                  Image.asset(Constants.IMG_START,
                      width: screenSize.width * 0.4),
                  Expanded(
                      child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 120,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Constants.mainPadding),
                        child: Text(
                          'Util.loginTitle',
                          style: TextStyle(
                              color: CustomColor.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 11),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 15.0),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Constants.mainPadding),
                        child: Text(
                          'Util.loginCaption',
                          style: TextStyle(
                              color: CustomColor.textSecondaryColor,
                              fontSize: 11),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 15.0),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: Constants.mainPadding),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 60,
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(14)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 5,
                                            spreadRadius: 1),
                                      ],
                                    ),
                                  ),
                                  TextFormField(
                                    controller: _emailController,
                                    focusNode: _focusEmail,
                                    keyboardType: TextInputType
                                        .emailAddress, // Use email input type for emails.
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'you@example.com',
                                      labelText: 'Email',
                                    ),
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      return _validateEmail(value!);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  Constants.mainPadding,
                                  8,
                                  Constants.mainPadding,
                                  0),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 60,
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(14)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 5,
                                            spreadRadius: 1),
                                      ],
                                    ),
                                  ),
                                  TextFormField(
                                    controller: _passController,
                                    focusNode: _focusPass,
                                    obscureText:
                                        _obscureText, // Use secure text for passwords.
                                    decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        labelText: 'Passwords',
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
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      return _validatePassword(value!);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Constants.mainPadding,
                                        vertical: 2),
                                    child: Text(
                                      'Util.loginForgotPassword',
                                      style: TextStyle(
                                          color: CustomColor.textSecondaryColor,
                                          fontSize: 11),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0,
                                  horizontal: Constants.mainPadding),
                              child: SizedBox(
                                  height: 50, //height of button
                                  width: MediaQuery.of(context)
                                      .size
                                      .width, //width of button
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 10, //elevation of button
                                        shape: RoundedRectangleBorder(
                                            //to set border radius to button
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        shadowColor: CustomColor.primaryColor,
                                        padding: const EdgeInsets.all(
                                            5) //content padding inside button
                                        ),
                                    onPressed: () {
                                      // Validate returns true if the form is valid, or false otherwise.
                                      if (_formKey.currentState!.validate()) {
                                        // If the form is valid, display a snackbar. In the real world,
                                        // you'd often call a server or save the information in a database.
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text('Processing Data')),
                                        );
                                      }
                                    },
                                    child: const Text(
                                      'Util.buttonLogin',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Image.asset(Constants.IMG_GOOGLE),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Image.asset(Constants.IMG_FACEBOOK),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Image.asset(Constants.IMG_APPLE),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'Util.loginQuestion',
                            ),
                            const TextSpan(text: ' '),
                            TextSpan(
                                text: 'Util.registerTitle',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {}),
                          ]),
                        ),
                      ),
                      const SizedBox(
                        height: Constants.mainPadding,
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
              NavigationRouter.switchToHomePage(context);
            },
            child: Image.asset(
              Constants.IMG_LOGO,
              width: 100,
              fit: BoxFit.cover,
            ),
          )),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(children: [
          Stack(
            children: [
              Container(
                // image below the top bar
                child: SizedBox(
                  height: screenSize.height * 0.45,
                  width: screenSize.width,
                  child: Image.asset(
                    'assets/images/cover.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
