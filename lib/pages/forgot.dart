import 'package:bestlocaleats/utils/constants.dart';
import 'package:bestlocaleats/utils/router.dart';
import 'package:bestlocaleats/utils/colors.dart';
import 'package:bestlocaleats/widgets/top_bar.dart';
import 'package:bestlocaleats/widgets/responsive.dart';

import 'package:flutter/material.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({super.key});

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  final List _isHovering = [
    false, // 0: logo
  ];

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
                          'Forgot Password',
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
                                      'Your passwords must be at least 8 characters long, and contain at least one letter and one digit',
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
                                    controller: _emailController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Email',
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
                                      // if (_formKey.currentState!.validate()) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('Processing Data')),
                                      );
                                      NavigationRouter.switchToOTPPage(context);
                                      // }
                                    },
                                    child: const Text(
                                      'Get OTP',
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
                  'Forgot Password',
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
                              'Your passwords must be at least 8 characters long, and contain at least one letter and one digit',
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
                            controller: _emailController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Email',
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
                              // if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing Data')),
                              );
                              NavigationRouter.switchToOTPPage(context);
                              // }
                            },
                            child: const Text(
                              'Get OTP',
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
