import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:bestlocaleats/utils/constants.dart';
import 'package:bestlocaleats/utils/colors.dart';
import 'package:bestlocaleats/utils/router.dart';

class TopBarContents extends StatefulWidget {
  final double opacity;

  // 0: login/signup, 1: homepage/others(observe), x: homepage/others(user)
  final int status;

  const TopBarContents(this.opacity, this.status, {super.key});

  @override
  State<TopBarContents> createState() => _TopBarContentsState();
}

class _TopBarContentsState extends State<TopBarContents> {
  final List _isHovering = [
    false, // 0: logo
    false, // 1: home
    false, // 2: all restaurant
    false, // 3: contact us
    false, // 4: favorite
    false, // 5: notification
  ];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    if (widget.status == 0) {
      return PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.mainPadding, vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                  child: Image.asset(
                    Constants.IMG_LOGO,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    } else if (widget.status == 1) {
      return PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: Container(
          color: Colors.black.withOpacity(widget.opacity),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.mainPadding, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                  child: Image.asset(
                    Constants.IMG_LOGO,
                  ),
                ),
                if (screenSize.width > 1000)
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: screenSize.width / 8),
                        const Icon(Icons.location_on,
                            color: CustomColor.activeColor, size: 20),
                        const Text('Kalamazoo , Michigan USA',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                InkWell(
                  onHover: (value) {
                    setState(() {
                      value ? _isHovering[1] = true : _isHovering[1] = false;
                    });
                  },
                  onTap: () {},
                  child: Text(
                    'Home',
                    style: TextStyle(
                      color: _isHovering[1]
                          ? CustomColor.activeColor
                          : widget.opacity == 0
                              ? Colors.black
                              : Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                  onHover: (value) {
                    setState(() {
                      value ? _isHovering[2] = true : _isHovering[2] = false;
                    });
                  },
                  onTap: () {
                    NavigationRouter.switchToAllRestaurantPage(context);
                  },
                  child: Text(
                    'All Restaurant',
                    style: TextStyle(
                      color: _isHovering[2]
                          ? CustomColor.activeColor
                          : widget.opacity == 0
                              ? Colors.black
                              : Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                  onHover: (value) {
                    setState(() {
                      value ? _isHovering[3] = true : _isHovering[3] = false;
                    });
                  },
                  onTap: () {},
                  child: Text(
                    'Contact us',
                    style: TextStyle(
                      color: _isHovering[3]
                          ? CustomColor.activeColor
                          : widget.opacity == 0
                              ? Colors.black
                              : Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                    width: 80,
                    height: 30,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          shadowColor:
                              CustomColor.primaryColor.withOpacity(0.5),
                          padding: const EdgeInsets.all(5)),
                      onPressed: () {
                        NavigationRouter.switchToLoginPage(context);
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CustomColor.primaryColor,
                            fontSize: 12),
                      ),
                    )),
                const SizedBox(
                  width: 16,
                ),
                SizedBox(
                    width: 80,
                    height: 30,
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
                        NavigationRouter.switchToSignupPage(context);
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    )),
              ],
            ),
          ),
        ),
      );
    } else {
      return PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: Container(
          color: Colors.black.withOpacity(widget.opacity),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.mainPadding, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onHover: (value) {
                    setState(() {
                      value ? _isHovering[0] = true : _isHovering[0] = false;
                    });
                  },
                  onTap: () {},
                  child: Image.asset(
                    Constants.IMG_LOGO,
                  ),
                ),
                if (screenSize.width > 1100)
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: screenSize.width / 8),
                        const Icon(Icons.location_on,
                            color: CustomColor.activeColor, size: 20),
                        const Text('Kalamazoo , Michigan USA',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                InkWell(
                  onHover: (value) {
                    setState(() {
                      value ? _isHovering[1] = true : _isHovering[1] = false;
                    });
                  },
                  onTap: () {},
                  child: Text(
                    'Home',
                    style: TextStyle(
                      color: _isHovering[1]
                          ? CustomColor.activeColor
                          : widget.opacity == 0
                              ? Colors.black
                              : Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                  onHover: (value) {
                    setState(() {
                      value ? _isHovering[2] = true : _isHovering[2] = false;
                    });
                  },
                  onTap: () {},
                  child: Text(
                    'All Restaurant',
                    style: TextStyle(
                      color: _isHovering[2]
                          ? CustomColor.activeColor
                          : widget.opacity == 0
                              ? Colors.black
                              : Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                  onHover: (value) {
                    setState(() {
                      value ? _isHovering[3] = true : _isHovering[3] = false;
                    });
                  },
                  onTap: () {},
                  child: Text(
                    'Contact us',
                    style: TextStyle(
                      color: _isHovering[3]
                          ? CustomColor.activeColor
                          : widget.opacity == 0
                              ? Colors.black
                              : Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                    onHover: (value) {
                      setState(() {
                        value ? _isHovering[4] = true : _isHovering[4] = false;
                      });
                    },
                    onTap: () {},
                    child: _isHovering[4]
                        ? const Icon(Icons.bookmark,
                            size: 20, color: CustomColor.activeColor)
                        : widget.opacity == 0
                            ? const Icon(Icons.bookmark_outline,
                                size: 20, color: Colors.black)
                            : const Icon(Icons.bookmark_outline,
                                size: 20, color: Colors.white)),
                const SizedBox(width: 20),
                InkWell(
                  onHover: (value) {
                    setState(() {
                      value ? _isHovering[5] = true : _isHovering[5] = false;
                    });
                  },
                  onTap: () {},
                  child: badges.Badge(
                    badgeContent: const Text(
                      '1',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    badgeStyle: const badges.BadgeStyle(
                      badgeColor: CustomColor.activeColor,
                      padding: EdgeInsets.all(4),
                      borderSide: BorderSide(color: Colors.white, width: 1),
                    ),
                    child: Icon(
                      Icons.notifications_outlined,
                      size: 20,
                      color: _isHovering[5]
                          ? CustomColor.activeColor
                          : widget.opacity == 0
                              ? Colors.black
                              : Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 40),
                SizedBox(
                    width: 140,
                    height: 30,
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
                        children: [
                          const SizedBox(width: 2),
                          Image.asset(
                            Constants.IMG_APPLE,
                          ),
                          const SizedBox(width: 2),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'User name',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  'demo@gmail.com',
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.grey),
                                ),
                              ]),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: Colors.black,
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      );
    }
  }
}
