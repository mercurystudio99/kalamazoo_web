import 'package:bestlocaleats/utils/constants.dart';
import 'package:bestlocaleats/utils/colors.dart';
import 'package:bestlocaleats/widgets/top_bar.dart';
import 'package:bestlocaleats/widgets/responsive.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final List _isHovering = [
    false, // 0: logo
  ];

  // 4 text editing controllers that associate with the 4 input fields
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final FocusNode _focusOne = FocusNode();
  final FocusNode _focusTwo = FocusNode();
  final FocusNode _focusThree = FocusNode();
  final FocusNode _focusFour = FocusNode();

  // This is the entered code
  // It will be displayed in a Text widget
  String _otp = '';

  void _getOTPcode() {
    setState(() {
      _otp =
          _fieldOne.text + _fieldTwo.text + _fieldThree.text + _fieldFour.text;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _focusOne.dispose();
    _focusTwo.dispose();
    _focusThree.dispose();
    _focusFour.dispose();
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
        child: TopBarContents(0, 0, 'otp', (param) {
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
                          'OTP',
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
                                      'Enter the 4-digit code sent to you at:',
                                ),
                              ]),
                            )),
                      ),
                      const SizedBox(height: 2),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Constants.mainPadding * 2),
                            child: RichText(
                              text: const TextSpan(children: [
                                TextSpan(
                                  text: 'demo@gmail.com',
                                ),
                              ]),
                            )),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Constants.mainPadding, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OtpInput(_fieldOne, _focusOne, true), // auto focus
                            const SizedBox(width: 20),
                            OtpInput(_fieldTwo, _focusTwo, false),
                            const SizedBox(width: 20),
                            OtpInput(_fieldThree, _focusThree, false),
                            const SizedBox(width: 20),
                            OtpInput(_fieldFour, _focusFour, false)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20,
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
                                _getOTPcode();
                                context.go('/reset');
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: Constants.mainPadding * 2),
                        child: SizedBox(
                            height: 40,
                            width: 140,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  side: const BorderSide(
                                      width: 1,
                                      color: CustomColor.primaryColor),
                                  backgroundColor: Colors.white,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                  shadowColor:
                                      CustomColor.primaryColor.withOpacity(0.5),
                                  padding: const EdgeInsets.all(5)),
                              onPressed: () {},
                              child: const Text(
                                'Resend',
                                style: TextStyle(
                                    color: CustomColor.primaryColor,
                                    fontSize: 16.0),
                              ),
                            )),
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
                  'OTP',
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
                          text: 'Enter the 4-digit code sent to you at:',
                        ),
                      ]),
                    )),
              ),
              const SizedBox(height: 2),
              Align(
                alignment: Alignment.center,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Constants.mainPadding * 2),
                    child: RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                          text: 'demo@gmail.com',
                        ),
                      ]),
                    )),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Constants.mainPadding, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OtpInput(_fieldOne, _focusOne, true), // auto focus
                    const SizedBox(width: 20),
                    OtpInput(_fieldTwo, _focusTwo, false),
                    const SizedBox(width: 20),
                    OtpInput(_fieldThree, _focusThree, false),
                    const SizedBox(width: 20),
                    OtpInput(_fieldFour, _focusFour, false)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20, horizontal: Constants.mainPadding * 2),
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
                        _getOTPcode();
                        context.go('/reset');
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
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: Constants.mainPadding * 2),
                child: SizedBox(
                    height: 40,
                    width: 140,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                              width: 1, color: CustomColor.primaryColor),
                          backgroundColor: Colors.white,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          shadowColor:
                              CustomColor.primaryColor.withOpacity(0.5),
                          padding: const EdgeInsets.all(5)),
                      onPressed: () {},
                      child: const Text(
                        'Resend',
                        style: TextStyle(
                            color: CustomColor.primaryColor, fontSize: 16.0),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Create an input widget that takes only one digit
class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focus;
  final bool autoFocus;

  const OtpInput(this.controller, this.focus, this.autoFocus, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.width < 1000 ? 40 : 60,
      width: screenSize.width < 1000 ? 40 : 60,
      child: Stack(
        children: [
          Container(
            height: screenSize.width < 1000 ? 40 : 56,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              boxShadow: [
                BoxShadow(
                    color: CustomColor.primaryColor.withOpacity(0.2),
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: const Offset(0, 0)),
              ],
            ),
          ),
          TextField(
            focusNode: focus,
            autofocus: autoFocus,
            textAlign: TextAlign.center,
            controller: controller,
            maxLength: 1,
            cursorColor: CustomColor.primaryColor,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), counterText: ''),
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
          ),
        ],
      ),
    );
  }
}
