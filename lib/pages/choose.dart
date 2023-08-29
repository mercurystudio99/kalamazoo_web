import 'package:bestlocaleats/utils/constants.dart';
import 'package:bestlocaleats/utils/colors.dart';
import 'package:bestlocaleats/utils/globals.dart' as global;
import 'package:bestlocaleats/widgets/top_bar.dart';
import 'package:bestlocaleats/widgets/responsive.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ChoosePage extends StatefulWidget {
  const ChoosePage({super.key});

  @override
  State<ChoosePage> createState() => _ChoosePageState();
}

class _ChoosePageState extends State<ChoosePage> {
  final List _isHovering = [
    false, // 0: logo
    false, // 1: owner
    false, // 2: customer
  ];

  late String userType = '';

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
    double cardWidth = screenSize.width / 4 - Constants.mainPadding * 2;
    if (screenSize.width < 1250) {
      cardWidth = screenSize.width * 0.3;
    }

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
                      const SizedBox(height: 50),
                      if (screenSize.width >= 1250)
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Register as a Restaurant',
                            style: TextStyle(
                                color: CustomColor.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 38),
                          ),
                        ),
                      if (screenSize.width >= 1250)
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Owner Or Customer',
                            style: TextStyle(
                                color: CustomColor.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 38),
                          ),
                        ),
                      if (screenSize.width < 1250)
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Register as a Restaurant Owner Or Customer',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: CustomColor.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 38),
                          ),
                        ),
                      const SizedBox(height: 20),
                      if (screenSize.width >= 1250)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 50,
                              horizontal: Constants.mainPadding / 2),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                    onHover: (value) {
                                      setState(() {
                                        value
                                            ? _isHovering[2] = true
                                            : _isHovering[2] = false;
                                      });
                                    },
                                    onTap: () {
                                      setState(() {
                                        userType = 'customer';
                                      });
                                    },
                                    child: Container(
                                        width: cardWidth,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: (userType == 'customer' ||
                                                      _isHovering[2])
                                                  ? CustomColor.primaryColor
                                                  : Colors.white),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                                offset: const Offset(10, 10),
                                                color: CustomColor.primaryColor
                                                    .withOpacity(0.2),
                                                blurRadius: 20,
                                                spreadRadius: 1),
                                          ],
                                        ),
                                        child: Card(
                                            margin: const EdgeInsets.all(0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            elevation: 0,
                                            child: Stack(children: [
                                              Positioned(
                                                  top: 10,
                                                  right: 20,
                                                  child: Container(
                                                    width: 20,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            width: (userType ==
                                                                        'customer' ||
                                                                    _isHovering[
                                                                        2])
                                                                ? 5
                                                                : 1,
                                                            color: CustomColor
                                                                .primaryColor),
                                                        color: Colors.white),
                                                  )),
                                              Padding(
                                                  padding: const EdgeInsets.all(
                                                      Constants.mainPadding /
                                                          2),
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const SizedBox(
                                                            height: 10),
                                                        Image.asset(Constants
                                                            .IMG_CUSTOMER),
                                                        const SizedBox(
                                                            height: 10),
                                                        const Text(
                                                          'I am customer',
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        )
                                                      ]))
                                            ])))),
                                InkWell(
                                    onHover: (value) {
                                      setState(() {
                                        value
                                            ? _isHovering[1] = true
                                            : _isHovering[1] = false;
                                      });
                                    },
                                    onTap: () {
                                      setState(() {
                                        userType = 'owner';
                                      });
                                    },
                                    child: Container(
                                        width: cardWidth,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: (userType == 'owner' ||
                                                      _isHovering[1])
                                                  ? CustomColor.primaryColor
                                                  : Colors.white),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                                offset: const Offset(10, 10),
                                                color: CustomColor.primaryColor
                                                    .withOpacity(0.2),
                                                blurRadius: 20,
                                                spreadRadius: 1),
                                          ],
                                        ),
                                        child: Card(
                                            margin: const EdgeInsets.all(0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            elevation: 0,
                                            child: Stack(children: [
                                              Positioned(
                                                  top: 10,
                                                  right: 20,
                                                  child: Container(
                                                    width: 20,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            width: (userType ==
                                                                        'owner' ||
                                                                    _isHovering[
                                                                        1])
                                                                ? 5
                                                                : 1,
                                                            color: CustomColor
                                                                .primaryColor),
                                                        color: Colors.white),
                                                  )),
                                              Padding(
                                                  padding: const EdgeInsets.all(
                                                      Constants.mainPadding /
                                                          2),
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const SizedBox(
                                                            height: 10),
                                                        Image.asset(Constants
                                                            .IMG_OWNER),
                                                        const SizedBox(
                                                            height: 10),
                                                        const Text(
                                                          'I am Restaurant Owner',
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        )
                                                      ]))
                                            ]))))
                              ]),
                        ),
                      if (screenSize.width < 1250)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: Constants.mainPadding / 2),
                          child: InkWell(
                              onHover: (value) {
                                setState(() {
                                  value
                                      ? _isHovering[2] = true
                                      : _isHovering[2] = false;
                                });
                              },
                              onTap: () {
                                setState(() {
                                  userType = 'customer';
                                });
                              },
                              child: Container(
                                  width: cardWidth,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: (userType == 'customer' ||
                                                _isHovering[2])
                                            ? CustomColor.primaryColor
                                            : Colors.white),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: const Offset(10, 10),
                                          color: CustomColor.primaryColor
                                              .withOpacity(0.2),
                                          blurRadius: 20,
                                          spreadRadius: 1),
                                    ],
                                  ),
                                  child: Card(
                                      margin: const EdgeInsets.all(0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      elevation: 0,
                                      child: Stack(children: [
                                        Positioned(
                                            top: 10,
                                            right: 20,
                                            child: Container(
                                              width: 20,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      width: (userType ==
                                                                  'customer' ||
                                                              _isHovering[2])
                                                          ? 5
                                                          : 1,
                                                      color: CustomColor
                                                          .primaryColor),
                                                  color: Colors.white),
                                            )),
                                        Padding(
                                            padding: const EdgeInsets.all(
                                                Constants.mainPadding / 2),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(height: 10),
                                                  Image.asset(
                                                      Constants.IMG_CUSTOMER),
                                                  const SizedBox(height: 10),
                                                  const Text(
                                                    'I am customer',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  )
                                                ]))
                                      ])))),
                        ),
                      if (screenSize.width < 1250)
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: Constants.mainPadding / 2),
                            child: InkWell(
                                onHover: (value) {
                                  setState(() {
                                    value
                                        ? _isHovering[1] = true
                                        : _isHovering[1] = false;
                                  });
                                },
                                onTap: () {
                                  setState(() {
                                    userType = 'owner';
                                  });
                                },
                                child: Container(
                                    width: cardWidth,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color: (userType == 'owner' ||
                                                  _isHovering[1])
                                              ? CustomColor.primaryColor
                                              : Colors.white),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                            offset: const Offset(10, 10),
                                            color: CustomColor.primaryColor
                                                .withOpacity(0.2),
                                            blurRadius: 20,
                                            spreadRadius: 1),
                                      ],
                                    ),
                                    child: Card(
                                        margin: const EdgeInsets.all(0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        elevation: 0,
                                        child: Stack(children: [
                                          Positioned(
                                              top: 10,
                                              right: 20,
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        width: (userType ==
                                                                    'owner' ||
                                                                _isHovering[1])
                                                            ? 5
                                                            : 1,
                                                        color: CustomColor
                                                            .primaryColor),
                                                    color: Colors.white),
                                              )),
                                          Padding(
                                              padding: const EdgeInsets.all(
                                                  Constants.mainPadding / 2),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(height: 10),
                                                    Image.asset(
                                                        Constants.IMG_OWNER),
                                                    const SizedBox(height: 10),
                                                    const Text(
                                                      'I am Restaurant Owner',
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    )
                                                  ]))
                                        ]))))),
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
                                          color:
                                              CustomColor.textSecondaryColor)),
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
                            vertical: 10,
                            horizontal: Constants.mainPadding * 2),
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
                                if (userType.isEmpty) return;
                                global.userType = userType;
                                if (global.userType == 'customer') {
                                  context.go('/signup');
                                } else {
                                  context.go('/signup');
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
    double cardWidth = screenSize.width / 2 - Constants.mainPadding * 2;
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
                  'Register as a Restaurant Owner Or Customer',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: CustomColor.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 38),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 50, horizontal: Constants.mainPadding / 2),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                          onHover: (value) {
                            setState(() {
                              value
                                  ? _isHovering[2] = true
                                  : _isHovering[2] = false;
                            });
                          },
                          onTap: () {
                            setState(() {
                              userType = 'customer';
                            });
                          },
                          child: Container(
                              width: cardWidth,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: (userType == 'customer' ||
                                            _isHovering[2])
                                        ? CustomColor.primaryColor
                                        : Colors.white),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(10, 10),
                                      color: CustomColor.primaryColor
                                          .withOpacity(0.2),
                                      blurRadius: 20,
                                      spreadRadius: 1),
                                ],
                              ),
                              child: Card(
                                  margin: const EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 0,
                                  child: Stack(children: [
                                    Positioned(
                                        top: 10,
                                        right: 20,
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width:
                                                      (userType == 'customer' ||
                                                              _isHovering[2])
                                                          ? 5
                                                          : 1,
                                                  color:
                                                      CustomColor.primaryColor),
                                              color: Colors.white),
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.all(
                                            Constants.mainPadding / 2),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 10),
                                              Image.asset(
                                                  Constants.IMG_CUSTOMER),
                                              const SizedBox(height: 10),
                                              const Text(
                                                'I am customer',
                                                style: TextStyle(fontSize: 18),
                                              )
                                            ]))
                                  ])))),
                      InkWell(
                          onHover: (value) {
                            setState(() {
                              value
                                  ? _isHovering[1] = true
                                  : _isHovering[1] = false;
                            });
                          },
                          onTap: () {
                            setState(() {
                              userType = 'owner';
                            });
                          },
                          child: Container(
                              width: cardWidth,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color:
                                        (userType == 'owner' || _isHovering[1])
                                            ? CustomColor.primaryColor
                                            : Colors.white),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(10, 10),
                                      color: CustomColor.primaryColor
                                          .withOpacity(0.2),
                                      blurRadius: 20,
                                      spreadRadius: 1),
                                ],
                              ),
                              child: Card(
                                  margin: const EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 0,
                                  child: Stack(children: [
                                    Positioned(
                                        top: 10,
                                        right: 20,
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: (userType == 'owner' ||
                                                          _isHovering[1])
                                                      ? 5
                                                      : 1,
                                                  color:
                                                      CustomColor.primaryColor),
                                              color: Colors.white),
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.all(
                                            Constants.mainPadding / 2),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 10),
                                              Image.asset(Constants.IMG_OWNER),
                                              const SizedBox(height: 10),
                                              const Text(
                                                'I am Restaurant Owner',
                                                style: TextStyle(fontSize: 18),
                                              )
                                            ]))
                                  ]))))
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'Already have an account?',
                          style: GoogleFonts.poppins(
                              color: CustomColor.textSecondaryColor)),
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
                        if (userType.isEmpty) return;
                        global.userType = userType;
                        if (global.userType == 'customer') {
                          context.go('/signup');
                        } else {
                          context.go('/signup');
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
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
