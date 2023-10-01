import 'package:bestlocaleats/utils/constants.dart';
import 'package:bestlocaleats/utils/colors.dart';
import 'package:bestlocaleats/utils/globals.dart' as global;
import 'package:bestlocaleats/widgets/top_bar.dart';
import 'package:bestlocaleats/widgets/responsive.dart';
import 'package:bestlocaleats/widgets/drawer.dart';
import 'package:bestlocaleats/widgets/bottom_bar.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final List _isHovering = [
    false, // 0: logo
  ];

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

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

  String? _validateMessage(String value) {
    if (value.isEmpty) {
      return "Please enter your message";
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
    int topbarstatus = 1;
    if (global.userID.isNotEmpty) topbarstatus = 2;
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: TopBarContents(1, topbarstatus, 'contact', (param) {
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
                    child: Column(children: [
                      Center(
                        child: Image.asset(Constants.IMG_CONTACT,
                            width: screenSize.width * 0.35,
                            height: screenSize.width * 0.35),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                              width: screenSize.width * 0.35,
                              padding: const EdgeInsets.fromLTRB(
                                  Constants.mainPadding * 2, 20, 0, 20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: CustomColor.primaryColor
                                          .withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(0, 0),
                                    ),
                                  ]),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Contact US',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 15),
                                    Row(children: const [
                                      Icon(Icons.phone,
                                          color: CustomColor.primaryColor),
                                      SizedBox(width: 5),
                                      Text('0123456789')
                                    ]),
                                    const SizedBox(height: 5),
                                    Row(children: const [
                                      Icon(Icons.email,
                                          color: CustomColor.textPrimaryColor),
                                      SizedBox(width: 5),
                                      Text('bestlocaleats@gmail.com')
                                    ]),
                                    const SizedBox(height: 5),
                                    Row(children: const [
                                      Icon(Icons.location_on,
                                          color: CustomColor.activeColor),
                                      SizedBox(width: 5),
                                      Text('Kalamazoo, Michigan USA')
                                    ]),
                                  ]))),
                    ]),
                  ),
                  Expanded(
                      child: Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Constants.mainPadding),
                        child: Text(
                          'Contact Us',
                          style: TextStyle(
                              color: CustomColor.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 38),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Constants.mainPadding * 2),
                          child: RichText(
                            text: const TextSpan(children: [
                              TextSpan(
                                  text:
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam bibendum ornare vulputate. Curabitur faucibus condimentum purus quis tristique.',
                                  style: TextStyle(
                                      color: CustomColor.textPrimaryColor,
                                      height: 1.4)),
                            ]),
                          )),
                      const SizedBox(height: 30),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Constants.mainPadding * 2),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Send Your Message',
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
                            const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Constants.mainPadding * 2,
                                    vertical: 10),
                                child: Text(
                                  'Name',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
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
                                    horizontal: Constants.mainPadding * 2,
                                    vertical: 10),
                                child: Text(
                                  'Email',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
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
                                    horizontal: Constants.mainPadding * 2,
                                    vertical: 10),
                                child: Text(
                                  'Message',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  Constants.mainPadding * 2,
                                  8,
                                  Constants.mainPadding * 2,
                                  0),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 98,
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
                                    controller: _messageController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Type your Message here...',
                                    ),
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 3,
                                    validator: (value) {
                                      return _validateMessage(value!);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 60),
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
                      const SizedBox(height: 20),
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
            Center(
              child: Image.asset(Constants.IMG_CONTACT,
                  width: screenSize.width * 0.5,
                  height: screenSize.width * 0.5),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                    width: screenSize.width * 0.5,
                    padding: const EdgeInsets.fromLTRB(
                        Constants.mainPadding, 20, 0, 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: CustomColor.primaryColor.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 0),
                          ),
                        ]),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Contact US',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 15),
                          Row(children: const [
                            Icon(Icons.phone, color: CustomColor.primaryColor),
                            SizedBox(width: 5),
                            Text('0123456789')
                          ]),
                          const SizedBox(height: 5),
                          Row(children: const [
                            Icon(Icons.email,
                                color: CustomColor.textPrimaryColor),
                            SizedBox(width: 5),
                            Text('bestlocaleats@gmail.com')
                          ]),
                          const SizedBox(height: 5),
                          Row(children: const [
                            Icon(Icons.location_on,
                                color: CustomColor.activeColor),
                            SizedBox(width: 5),
                            Text('Kalamazoo, Michigan USA')
                          ]),
                        ]))),
            const SizedBox(height: 80),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Constants.mainPadding),
              child: Text(
                'Contact Us',
                style: TextStyle(
                    color: CustomColor.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 38),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Constants.mainPadding * 2),
                child: RichText(
                  text: const TextSpan(children: [
                    TextSpan(
                        text:
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam bibendum ornare vulputate. Curabitur faucibus condimentum purus quis tristique.',
                        style: TextStyle(
                            color: CustomColor.textPrimaryColor, height: 1.4)),
                  ]),
                )),
            const SizedBox(height: 30),
            const Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Constants.mainPadding * 2),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Send Your Message',
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
                        'Message',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                        Constants.mainPadding * 2,
                        8,
                        Constants.mainPadding * 2,
                        0),
                    child: Stack(
                      children: [
                        Container(
                          height: 98,
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
                          controller: _messageController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Type your Message here...',
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          validator: (value) {
                            return _validateMessage(value!);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 60),
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
            const SizedBox(height: 100),
            const BottomBar()
          ],
        ),
      ),
    );
  }
}
