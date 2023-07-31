import 'package:flutter/material.dart';
import 'package:bestlocaleats/utils/colors.dart';
import 'package:bestlocaleats/utils/router.dart';

class MobileDrawer extends StatefulWidget {
  const MobileDrawer({super.key});

  @override
  State<MobileDrawer> createState() => _DrawerState();
}

class _DrawerState extends State<MobileDrawer> {
  final List _isHovering = [
    false, // 0: home
    false, // 1: all restaurant
    false, // 2: contact us
    false, // 3: favorite
    false, // 4: notification
    false, // 5: login
    false, // 6: signup
    false, // 7: profile
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: CustomColor.primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onHover: (value) {
                  setState(() {
                    value ? _isHovering[0] = true : _isHovering[0] = false;
                  });
                },
                onTap: () {
                  NavigationRouter.switchToHomePage(context);
                },
                child: Text(
                  'Home',
                  style: TextStyle(
                      color: _isHovering[0]
                          ? CustomColor.activeColor
                          : Colors.white,
                      fontSize: 22),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: CustomColor.textPrimaryColor,
                  thickness: 2,
                ),
              ),
              InkWell(
                onHover: (value) {
                  setState(() {
                    value ? _isHovering[1] = true : _isHovering[1] = false;
                  });
                },
                onTap: () {
                  NavigationRouter.switchToAllRestaurantPage(context);
                },
                child: Text(
                  'All Restaurant',
                  style: TextStyle(
                      color: _isHovering[1]
                          ? CustomColor.activeColor
                          : Colors.white,
                      fontSize: 22),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: CustomColor.textPrimaryColor,
                  thickness: 2,
                ),
              ),
              InkWell(
                onHover: (value) {
                  setState(() {
                    value ? _isHovering[2] = true : _isHovering[2] = false;
                  });
                },
                onTap: () {
                  NavigationRouter.switchToContactPage(context);
                },
                child: Text(
                  'Contact Us',
                  style: TextStyle(
                      color: _isHovering[2]
                          ? CustomColor.activeColor
                          : Colors.white,
                      fontSize: 22),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: CustomColor.textPrimaryColor,
                  thickness: 2,
                ),
              ),
              InkWell(
                onHover: (value) {
                  setState(() {
                    value ? _isHovering[3] = true : _isHovering[3] = false;
                  });
                },
                onTap: () {
                  NavigationRouter.switchToFavoritePage(context);
                },
                child: Text(
                  'Favorites',
                  style: TextStyle(
                      color: _isHovering[3]
                          ? CustomColor.activeColor
                          : Colors.white,
                      fontSize: 22),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: CustomColor.textPrimaryColor,
                  thickness: 2,
                ),
              ),
              InkWell(
                onHover: (value) {
                  setState(() {
                    value ? _isHovering[4] = true : _isHovering[4] = false;
                  });
                },
                onTap: () {
                  NavigationRouter.switchToNotificationPage(context);
                },
                child: Text(
                  'Notification',
                  style: TextStyle(
                      color: _isHovering[4]
                          ? CustomColor.activeColor
                          : Colors.white,
                      fontSize: 22),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: CustomColor.textPrimaryColor,
                  thickness: 2,
                ),
              ),
              InkWell(
                onHover: (value) {
                  setState(() {
                    value ? _isHovering[5] = true : _isHovering[5] = false;
                  });
                },
                onTap: () {
                  NavigationRouter.switchToLoginPage(context);
                },
                child: Text(
                  'Sign in',
                  style: TextStyle(
                      color: _isHovering[5]
                          ? CustomColor.activeColor
                          : Colors.white,
                      fontSize: 22),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: CustomColor.textPrimaryColor,
                  thickness: 2,
                ),
              ),
              InkWell(
                onHover: (value) {
                  setState(() {
                    value ? _isHovering[6] = true : _isHovering[6] = false;
                  });
                },
                onTap: () {
                  NavigationRouter.switchToSignupPage(context);
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                      color: _isHovering[6]
                          ? CustomColor.activeColor
                          : Colors.white,
                      fontSize: 22),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: CustomColor.textPrimaryColor,
                  thickness: 2,
                ),
              ),
              InkWell(
                onHover: (value) {
                  setState(() {
                    value ? _isHovering[7] = true : _isHovering[7] = false;
                  });
                },
                onTap: () {
                  NavigationRouter.switchToProfilePage(context);
                },
                child: Text(
                  'Profile',
                  style: TextStyle(
                      color: _isHovering[7]
                          ? CustomColor.activeColor
                          : Colors.white,
                      fontSize: 22),
                ),
              ),
              const Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Copyright © 2023 | Thebestlocaleats',
                    style: TextStyle(
                      color: CustomColor.textSecondaryColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
