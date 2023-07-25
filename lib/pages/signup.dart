import 'package:bestlocaleats/utils/constants.dart';
import 'package:bestlocaleats/utils/router.dart';
import 'package:bestlocaleats/utils/colors.dart';
import 'package:bestlocaleats/widgets/top_bar.dart';
import 'package:bestlocaleats/widgets/responsive.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final List _isHovering = [
    false, // 0: logo
    false, // 1: forgot password
  ];

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  bool _obscureText = true;
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
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
                          'Sign Up',
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
                                    controller: _nameController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'User Name',
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
                                    controller: _emailController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter your email',
                                    ),
                                    validator: (value) {
                                      return _validateEmail(value!);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  Constants.mainPadding * 2,
                                  8,
                                  Constants.mainPadding * 2,
                                  0),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Constants.mainPadding * 2,
                                      vertical: 2),
                                  child: InkWell(
                                    onHover: (value) {
                                      setState(() {
                                        value
                                            ? _isHovering[1] = true
                                            : _isHovering[1] = false;
                                      });
                                    },
                                    onTap: () {
                                      NavigationRouter.switchToForgotPage(
                                          context);
                                    },
                                    child: Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                        color: _isHovering[1]
                                            ? CustomColor.activeColor
                                            : CustomColor.textSecondaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
                                      }
                                    },
                                    child: const Text(
                                      'Continue',
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
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: Constants.mainPadding),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Container(
                                      width: screenSize.width < 1100
                                          ? 80
                                          : screenSize.width * 0.1,
                                      height: 1,
                                      color: CustomColor.textPrimaryColor),
                                ),
                                const Text('OR',
                                    style: TextStyle(fontSize: 12)),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Container(
                                      width: screenSize.width < 1100
                                          ? 80
                                          : screenSize.width * 0.1,
                                      height: 1,
                                      color: CustomColor.textPrimaryColor),
                                ),
                              ])),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: Constants.mainPadding * 2),
                        child: SizedBox(
                            height: 40,
                            width: screenSize.width,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                  shadowColor:
                                      CustomColor.primaryColor.withOpacity(0.5),
                                  padding: const EdgeInsets.all(5)),
                              onPressed: () {},
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(Constants.IMG_GOOGLE1),
                                    const SizedBox(width: 5),
                                    Text(
                                      screenSize.width < 900
                                          ? 'Continue'
                                          : 'Continue With Google',
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 16.0),
                                    ),
                                  ]),
                            )),
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
                                  backgroundColor: Colors.white,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                  shadowColor:
                                      CustomColor.primaryColor.withOpacity(0.5),
                                  padding: const EdgeInsets.all(5)),
                              onPressed: () {},
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(Constants.IMG_FACEBOOK1),
                                    const SizedBox(width: 5),
                                    Text(
                                      screenSize.width < 900
                                          ? 'Continue'
                                          : 'Continue With Facebook',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          overflow: TextOverflow.fade),
                                    ),
                                  ]),
                            )),
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
                                  backgroundColor: Colors.white,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                  shadowColor:
                                      CustomColor.primaryColor.withOpacity(0.5),
                                  padding: const EdgeInsets.all(5)),
                              onPressed: () {},
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(Constants.IMG_APPLE1),
                                    const SizedBox(width: 12),
                                    Text(
                                      screenSize.width < 900
                                          ? 'Continue'
                                          : 'Continue With Apple',
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 16.0),
                                    ),
                                  ]),
                            )),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: Constants.mainPadding),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Container(
                                      width: screenSize.width < 1100
                                          ? 80
                                          : screenSize.width * 0.1,
                                      height: 1,
                                      color: CustomColor.textPrimaryColor),
                                ),
                                const Text('OR',
                                    style: TextStyle(fontSize: 12)),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Container(
                                      width: screenSize.width < 1100
                                          ? 80
                                          : screenSize.width * 0.1,
                                      height: 1,
                                      color: CustomColor.textPrimaryColor),
                                ),
                              ])),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Sign Up with Best Local Eats app',
                            style: TextStyle(fontSize: 15),
                          )),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.center,
                        child: Row(children: [
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.resolveWith<Color>(
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
                          Expanded(
                              child: RichText(
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
                          )),
                        ]),
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
                  'Sign Up',
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
                            controller: _nameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'User Name',
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
                            controller: _emailController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter your email',
                            ),
                            validator: (value) {
                              return _validateEmail(value!);
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          Constants.mainPadding * 2,
                          8,
                          Constants.mainPadding * 2,
                          0),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Constants.mainPadding * 2,
                              vertical: 2),
                          child: InkWell(
                            onHover: (value) {
                              setState(() {
                                value
                                    ? _isHovering[1] = true
                                    : _isHovering[1] = false;
                              });
                            },
                            onTap: () {
                              NavigationRouter.switchToForgotPage(context);
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: _isHovering[1]
                                    ? CustomColor.activeColor
                                    : CustomColor.textSecondaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
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
                              }
                            },
                            child: const Text(
                              'Continue',
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
              Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: Constants.mainPadding),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                              width: screenSize.width * 0.2,
                              height: 1,
                              color: CustomColor.textPrimaryColor),
                        ),
                        const Text('OR', style: TextStyle(fontSize: 12)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                              width: screenSize.width * 0.2,
                              height: 1,
                              color: CustomColor.textPrimaryColor),
                        ),
                      ])),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: Constants.mainPadding * 2),
                child: SizedBox(
                    height: 40,
                    width: screenSize.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          shadowColor:
                              CustomColor.primaryColor.withOpacity(0.5),
                          padding: const EdgeInsets.all(5)),
                      onPressed: () {},
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(Constants.IMG_GOOGLE1),
                            const SizedBox(width: 5),
                            const Text(
                              'Continue With Google',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.0),
                            ),
                          ]),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: Constants.mainPadding * 2),
                child: SizedBox(
                    height: 40,
                    width: screenSize.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          shadowColor:
                              CustomColor.primaryColor.withOpacity(0.5),
                          padding: const EdgeInsets.all(5)),
                      onPressed: () {},
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(Constants.IMG_FACEBOOK1),
                            const SizedBox(width: 5),
                            const Text(
                              'Continue With Facebook',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  overflow: TextOverflow.fade),
                            ),
                          ]),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: Constants.mainPadding * 2),
                child: SizedBox(
                    height: 40,
                    width: screenSize.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          shadowColor:
                              CustomColor.primaryColor.withOpacity(0.5),
                          padding: const EdgeInsets.all(5)),
                      onPressed: () {},
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(Constants.IMG_APPLE1),
                            const SizedBox(width: 12),
                            const Text(
                              'Continue With Apple',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.0),
                            ),
                          ]),
                    )),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: Constants.mainPadding),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                              width: screenSize.width * 0.2,
                              height: 1,
                              color: CustomColor.textPrimaryColor),
                        ),
                        const Text('OR', style: TextStyle(fontSize: 12)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                              width: screenSize.width * 0.2,
                              height: 1,
                              color: CustomColor.textPrimaryColor),
                        ),
                      ])),
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Sign Up with Best Local Eats app',
                    style: TextStyle(fontSize: 15),
                  )),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: Row(children: [
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith<Color>(
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
                  Expanded(
                      child: RichText(
                    text: TextSpan(children: [
                      const TextSpan(
                        text: 'By Signing up i Agree to the',
                      ),
                      const TextSpan(text: ' '),
                      TextSpan(
                          text: 'term and Condition & privacy Police',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()..onTap = () {}),
                    ]),
                  )),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
