import 'package:bestlocaleats/utils/constants.dart';
import 'package:bestlocaleats/utils/colors.dart';
import 'package:bestlocaleats/utils/globals.dart' as global;
import 'package:bestlocaleats/widgets/top_bar.dart';
import 'package:bestlocaleats/widgets/responsive.dart';
import 'package:bestlocaleats/widgets/drawer.dart';
import 'package:bestlocaleats/widgets/bottom_bar.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List _isHovering = [
    false, // 0: logo
  ];

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
                        child: Image.asset(Constants.IMG_NOTIFICATION_BG,
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
                          'Notifications',
                          style: TextStyle(
                              color: CustomColor.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 38),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
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
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          leading: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: CustomColor.primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Icon(
                              Icons.notifications_outlined,
                              color: CustomColor.primaryColor,
                            ),
                          ),
                          title: const Text(
                            'Your Password has been changed.',
                            style:
                                TextStyle(color: CustomColor.textPrimaryColor),
                          ),
                          trailing: const Text(
                            '20 Min ago',
                            style: TextStyle(
                                color: CustomColor.textPrimaryColor,
                                fontSize: 12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
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
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          leading: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: CustomColor.primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Icon(
                              Icons.notifications_outlined,
                              color: CustomColor.primaryColor,
                            ),
                          ),
                          title: const Text(
                            'Your Password has been changed.',
                            style:
                                TextStyle(color: CustomColor.textPrimaryColor),
                          ),
                          trailing: const Text(
                            '20 Min ago',
                            style: TextStyle(
                                color: CustomColor.textPrimaryColor,
                                fontSize: 12),
                          ),
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
            SizedBox(
                width: screenSize.width,
                child: Center(
                  child: Image.asset(Constants.IMG_NOTIFICATION_BG,
                      width: screenSize.width * 0.5,
                      height: screenSize.width * 0.5),
                )),
            const SizedBox(height: 20),
            const Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Constants.mainPadding * 2),
              child: Text(
                'Notifications',
                style: TextStyle(
                    color: CustomColor.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 38),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: Constants.mainPadding * 2),
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
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                leading: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: CustomColor.primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Icon(
                    Icons.notifications_outlined,
                    color: CustomColor.primaryColor,
                  ),
                ),
                title: const Text(
                  'Your Password has been changed.',
                  style: TextStyle(color: CustomColor.textPrimaryColor),
                ),
                trailing: const Text(
                  '20 Min ago',
                  style: TextStyle(
                      color: CustomColor.textPrimaryColor, fontSize: 12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: Constants.mainPadding * 2),
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
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                leading: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: CustomColor.primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Icon(
                    Icons.notifications_outlined,
                    color: CustomColor.primaryColor,
                  ),
                ),
                title: const Text(
                  'Your Password has been changed.',
                  style: TextStyle(color: CustomColor.textPrimaryColor),
                ),
                trailing: const Text(
                  '20 Min ago',
                  style: TextStyle(
                      color: CustomColor.textPrimaryColor, fontSize: 12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 100),
            const BottomBar()
          ],
        ),
      ),
    );
  }
}
