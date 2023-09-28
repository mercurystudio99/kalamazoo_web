import 'package:bestlocaleats/utils/constants.dart';
import 'package:bestlocaleats/utils/colors.dart';
import 'package:bestlocaleats/utils/globals.dart' as global;
import 'package:bestlocaleats/widgets/top_bar.dart';
import 'package:bestlocaleats/widgets/responsive.dart';
import 'package:bestlocaleats/widgets/drawer.dart';
import 'package:bestlocaleats/widgets/bottom_bar.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  final List _isHovering = [
    false, // 0: logo
    false, // 1: 1 x push
    false, // 2: 2 x push
    false, // 3: 3 x push
    false, // 4: unlimited
  ];

  List<bool> selectIndex = [false, false, false, false, false];

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
    double mainPadding = ResponsiveWidget.isLargeScreen(context)
        ? Constants.mainPadding * 2
        : Constants.mainPadding;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: TopBarContents(1, topbarstatus, () {
          debugPrint('---');
        }),
      ),
      drawer: const MobileDrawer(),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(children: [
          Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: mainPadding, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: screenSize.width * 0.5,
                      child: Center(
                        child: Image.asset(Constants.IMG_SUBSCRIPTION_BG,
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
                          'Subscription Plan',
                          style: TextStyle(
                              color: CustomColor.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 38),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Constants.mainPadding),
                        child: Text(
                            'Subscribe your plan and push Special offers to the people',
                            style: TextStyle(
                                color: CustomColor.textPrimaryColor,
                                height: 1.4)),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: Constants.mainPadding),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: selectIndex[1] || _isHovering[1]
                                    ? CustomColor.primaryColor
                                    : Colors.white,
                                width: 1),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    CustomColor.primaryColor.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 0),
                              ),
                            ]),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectIndex[0] = false;
                              selectIndex[1] = true;
                              selectIndex[2] = false;
                              selectIndex[3] = false;
                              selectIndex[4] = false;
                            });
                          },
                          onHover: (value) {
                            setState(() {
                              value
                                  ? _isHovering[1] = true
                                  : _isHovering[1] = false;
                            });
                          },
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            leading: SizedBox(
                                width: 35,
                                height: 35,
                                child: Image.asset(Constants.IMG_CROWN)),
                            title: const Text(
                              '1 x Push Notification',
                              style: TextStyle(color: CustomColor.primaryColor),
                            ),
                            trailing: RichText(
                              text: const TextSpan(children: [
                                TextSpan(
                                  text: '\$100.00',
                                  style: TextStyle(
                                      color: CustomColor.primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                TextSpan(
                                    text: '/each   ',
                                    style: TextStyle(
                                        color: CustomColor.primaryColor,
                                        fontSize: 18)),
                              ]),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: Constants.mainPadding),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: selectIndex[2] || _isHovering[2]
                                    ? CustomColor.primaryColor
                                    : Colors.white,
                                width: 1),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    CustomColor.primaryColor.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 0),
                              ),
                            ]),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectIndex[0] = false;
                              selectIndex[1] = false;
                              selectIndex[2] = true;
                              selectIndex[3] = false;
                              selectIndex[4] = false;
                            });
                          },
                          onHover: (value) {
                            setState(() {
                              value
                                  ? _isHovering[2] = true
                                  : _isHovering[2] = false;
                            });
                          },
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            leading: SizedBox(
                                width: 35,
                                height: 35,
                                child: Image.asset(Constants.IMG_CROWN)),
                            title: const Text(
                              '4 x Push Notification',
                              style: TextStyle(color: CustomColor.primaryColor),
                            ),
                            trailing: RichText(
                              text: const TextSpan(children: [
                                TextSpan(
                                  text: '\$250.00',
                                  style: TextStyle(
                                      color: CustomColor.primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                TextSpan(
                                    text: '/month',
                                    style: TextStyle(
                                        color: CustomColor.primaryColor,
                                        fontSize: 18)),
                              ]),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: Constants.mainPadding),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: selectIndex[3] || _isHovering[3]
                                    ? CustomColor.primaryColor
                                    : Colors.white,
                                width: 1),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    CustomColor.primaryColor.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 0),
                              ),
                            ]),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectIndex[0] = false;
                              selectIndex[1] = false;
                              selectIndex[2] = false;
                              selectIndex[3] = true;
                              selectIndex[4] = false;
                            });
                          },
                          onHover: (value) {
                            setState(() {
                              value
                                  ? _isHovering[3] = true
                                  : _isHovering[3] = false;
                            });
                          },
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            leading: SizedBox(
                                width: 35,
                                height: 35,
                                child: Image.asset(Constants.IMG_CROWN)),
                            title: const Text(
                              '10 x Push Notification',
                              style: TextStyle(color: CustomColor.primaryColor),
                            ),
                            trailing: RichText(
                              text: const TextSpan(children: [
                                TextSpan(
                                  text: '\$500.00',
                                  style: TextStyle(
                                      color: CustomColor.primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                TextSpan(
                                    text: '/month',
                                    style: TextStyle(
                                        color: CustomColor.primaryColor,
                                        fontSize: 18)),
                              ]),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: Constants.mainPadding),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: selectIndex[4] || _isHovering[4]
                                    ? CustomColor.primaryColor
                                    : Colors.white,
                                width: 1),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    CustomColor.primaryColor.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 0),
                              ),
                            ]),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectIndex[0] = false;
                              selectIndex[1] = false;
                              selectIndex[2] = false;
                              selectIndex[3] = false;
                              selectIndex[4] = true;
                            });
                          },
                          onHover: (value) {
                            setState(() {
                              value
                                  ? _isHovering[4] = true
                                  : _isHovering[4] = false;
                            });
                          },
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            leading: SizedBox(
                                width: 35,
                                height: 35,
                                child: Image.asset(Constants.IMG_CROWN)),
                            title: const Text(
                              'Unlimited Plan - 1 Push Notification/day',
                              style: TextStyle(color: CustomColor.primaryColor),
                            ),
                            trailing: RichText(
                              text: const TextSpan(children: [
                                TextSpan(
                                  text: '\$1000.00         ',
                                  style: TextStyle(
                                      color: CustomColor.primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ]),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 40),
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
                                bool subscripted = false;
                                for (var i = 0; i < selectIndex.length; i++) {
                                  if (selectIndex[i]) {
                                    subscripted = true;
                                  }
                                }
                                if (subscripted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Processing Data')),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Please choose one of the subscriptions.')),
                                  );
                                }
                              },
                              child: const Text(
                                'Active Plan',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    letterSpacing: 1),
                              ),
                            )),
                      ),
                      const SizedBox(height: 40)
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
            SizedBox(
                width: screenSize.width,
                child: Center(
                  child: Image.asset(Constants.IMG_SUBSCRIPTION_BG,
                      width: screenSize.width * 0.5,
                      height: screenSize.width * 0.5),
                )),
            const SizedBox(height: 20),
            const Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Constants.mainPadding * 2),
              child: Text(
                'Subscription Plan',
                style: TextStyle(
                    color: CustomColor.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 38),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Constants.mainPadding * 2),
              child: Text(
                  'Subscribe your plan and push Special offers to the people',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: CustomColor.textPrimaryColor, height: 1.4)),
            ),
            const SizedBox(height: 50),
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: Constants.mainPadding * 2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: selectIndex[1] || _isHovering[1]
                          ? CustomColor.primaryColor
                          : Colors.white,
                      width: 1),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: CustomColor.primaryColor.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 0),
                    ),
                  ]),
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectIndex[0] = false;
                    selectIndex[1] = true;
                    selectIndex[2] = false;
                    selectIndex[3] = false;
                    selectIndex[4] = false;
                  });
                },
                onHover: (value) {
                  setState(() {
                    value ? _isHovering[1] = true : _isHovering[1] = false;
                  });
                },
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  leading: SizedBox(
                      width: 35,
                      height: 35,
                      child: Image.asset(Constants.IMG_CROWN)),
                  title: const Text(
                    '1 x Push Notification',
                    style: TextStyle(color: CustomColor.primaryColor),
                  ),
                  trailing: RichText(
                    text: const TextSpan(children: [
                      TextSpan(
                        text: '\$100.00',
                        style: TextStyle(
                            color: CustomColor.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      TextSpan(
                          text: '/each   ',
                          style: TextStyle(
                              color: CustomColor.primaryColor, fontSize: 18)),
                    ]),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: Constants.mainPadding * 2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: selectIndex[2] || _isHovering[2]
                          ? CustomColor.primaryColor
                          : Colors.white,
                      width: 1),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: CustomColor.primaryColor.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 0),
                    ),
                  ]),
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectIndex[0] = false;
                    selectIndex[1] = false;
                    selectIndex[2] = true;
                    selectIndex[3] = false;
                    selectIndex[4] = false;
                  });
                },
                onHover: (value) {
                  setState(() {
                    value ? _isHovering[2] = true : _isHovering[2] = false;
                  });
                },
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  leading: SizedBox(
                      width: 35,
                      height: 35,
                      child: Image.asset(Constants.IMG_CROWN)),
                  title: const Text(
                    '4 x Push Notification',
                    style: TextStyle(color: CustomColor.primaryColor),
                  ),
                  trailing: RichText(
                    text: const TextSpan(children: [
                      TextSpan(
                        text: '\$250.00',
                        style: TextStyle(
                            color: CustomColor.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      TextSpan(
                          text: '/month',
                          style: TextStyle(
                              color: CustomColor.primaryColor, fontSize: 18)),
                    ]),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: Constants.mainPadding * 2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: selectIndex[3] || _isHovering[3]
                          ? CustomColor.primaryColor
                          : Colors.white,
                      width: 1),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: CustomColor.primaryColor.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 0),
                    ),
                  ]),
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectIndex[0] = false;
                    selectIndex[1] = false;
                    selectIndex[2] = false;
                    selectIndex[3] = true;
                    selectIndex[4] = false;
                  });
                },
                onHover: (value) {
                  setState(() {
                    value ? _isHovering[3] = true : _isHovering[3] = false;
                  });
                },
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  leading: SizedBox(
                      width: 35,
                      height: 35,
                      child: Image.asset(Constants.IMG_CROWN)),
                  title: const Text(
                    '10 x Push Notification',
                    style: TextStyle(color: CustomColor.primaryColor),
                  ),
                  trailing: RichText(
                    text: const TextSpan(children: [
                      TextSpan(
                        text: '\$500.00',
                        style: TextStyle(
                            color: CustomColor.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      TextSpan(
                          text: '/month',
                          style: TextStyle(
                              color: CustomColor.primaryColor, fontSize: 18)),
                    ]),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: Constants.mainPadding * 2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: selectIndex[4] || _isHovering[4]
                          ? CustomColor.primaryColor
                          : Colors.white,
                      width: 1),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: CustomColor.primaryColor.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 0),
                    ),
                  ]),
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectIndex[0] = false;
                    selectIndex[1] = false;
                    selectIndex[2] = false;
                    selectIndex[3] = false;
                    selectIndex[4] = true;
                  });
                },
                onHover: (value) {
                  setState(() {
                    value ? _isHovering[4] = true : _isHovering[4] = false;
                  });
                },
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  leading: SizedBox(
                      width: 35,
                      height: 35,
                      child: Image.asset(Constants.IMG_CROWN)),
                  title: const Text(
                    'Unlimited Plan - 1 Push Notification/day',
                    style: TextStyle(color: CustomColor.primaryColor),
                  ),
                  trailing: RichText(
                    text: const TextSpan(children: [
                      TextSpan(
                        text: '\$1000.00         ',
                        style: TextStyle(
                            color: CustomColor.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 40),
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
                        shadowColor: CustomColor.primaryColor.withOpacity(0.5),
                        padding: const EdgeInsets.all(5)),
                    onPressed: () {
                      bool subscripted = false;
                      for (var i = 0; i < selectIndex.length; i++) {
                        if (selectIndex[i]) {
                          subscripted = true;
                        }
                      }
                      if (subscripted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Please choose one of the subscriptions.')),
                        );
                      }
                    },
                    child: const Text(
                      'Active Plan',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          letterSpacing: 1),
                    ),
                  )),
            ),
            const SizedBox(height: 100),
            const BottomBar()
          ],
        ),
      ),
    );
  }
}
