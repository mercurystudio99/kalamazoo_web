import 'package:bestlocaleats/utils/colors.dart';
import 'package:bestlocaleats/utils/constants.dart';
import 'package:bestlocaleats/utils/globals.dart' as global;
import 'package:bestlocaleats/widgets/top_bar.dart';
import 'package:bestlocaleats/widgets/drawer.dart';
import 'package:bestlocaleats/widgets/bottom_bar.dart';
import 'package:bestlocaleats/widgets/responsive.dart';
import 'package:bestlocaleats/widgets/accordion.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int topbarstatus = 1;
    if (global.userID.isNotEmpty) topbarstatus = 2;
    var screenSize = MediaQuery.of(context).size;
    List<double> bannersizes = [300, 360];
    List<double> menusizes = [400];
    if (screenSize.width < 1200) {
      menusizes = [300];
    }
    if (screenSize.width < 800) {
      bannersizes = [300, 250];
      menusizes = [300];
    }
    if (screenSize.width < 680) {
      bannersizes = [300, 0];
      menusizes = [screenSize.width / 2];
    }

    return Scaffold(
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              // for smaller screen sizes
              backgroundColor: Colors.black.withOpacity(1),
              elevation: 0,
              title: InkWell(
                onHover: (value) {},
                onTap: () {
                  context.go('/');
                },
                child: Image.asset(
                  Constants.IMG_LOGO,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ))
          : PreferredSize(
              // for larger & medium screen sizes
              preferredSize: Size(screenSize.width, 1000),
              child: TopBarContents(1, topbarstatus),
            ),
      drawer: const MobileDrawer(),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(children: [
          Stack(
            children: [
              SizedBox(
                width: screenSize.width,
                height: bannersizes[0],
                child: Image.asset(
                  Constants.IMG_ABOUT_BANNER,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Constants.mainPadding, vertical: 50),
                child: Row(children: [
                  SizedBox(
                      width: bannersizes[1],
                      child: Image.asset(
                        Constants.IMG_ABOUT,
                        fit: BoxFit.cover,
                      )),
                  const SizedBox(width: 20),
                  Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Row(children: [
                          Text('Maru Sushi & Grill',
                              style: GoogleFonts.poppins(
                                  fontSize: 30, color: Colors.white)),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: CustomColor.activeColor,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              children: const [
                                Text(
                                  '4.8',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 14,
                                )
                              ],
                            ),
                          ),
                        ]),
                        const SizedBox(height: 20),
                        Row(children: [
                          Container(
                            alignment: const Alignment(0, 0),
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: const Icon(
                              Icons.phone_in_talk_outlined,
                              color: CustomColor.textSecondaryColor,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Phone',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '12345789',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      fontSize: 12.0,
                                      color: CustomColor.textSecondaryColor),
                                ),
                              ]),
                        ]),
                        const SizedBox(height: 12),
                        Row(children: [
                          Container(
                            alignment: const Alignment(0, 0),
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: const Icon(
                              Icons.email_outlined,
                              color: CustomColor.textSecondaryColor,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'E-mail',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'royaldine247@gmail.com',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      fontSize: 12.0,
                                      color: CustomColor.textSecondaryColor),
                                ),
                              ])
                        ]),
                        const SizedBox(height: 12),
                        Row(children: [
                          Container(
                            alignment: const Alignment(0, 0),
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: const Icon(
                              Icons.location_on_outlined,
                              color: CustomColor.textSecondaryColor,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Location',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Kalamazoo, Michigan, USA',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      fontSize: 12.0,
                                      color: CustomColor.textSecondaryColor),
                                ),
                              ]),
                          const SizedBox(width: 40),
                          SizedBox(
                              width: 88,
                              height: 30,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: CustomColor.primaryColor,
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      shadowColor: CustomColor.primaryColor
                                          .withOpacity(0.5),
                                      padding: const EdgeInsets.all(5)),
                                  onPressed: () {},
                                  child: const Text('Open Map',
                                      style: TextStyle(color: Colors.white)))),
                        ]),
                      ]))
                ]),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
              width: screenSize.width,
              height: screenSize.height,
              child: Row(children: [
                SizedBox(
                    width: menusizes[0],
                    child: ListView(
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(
                                Constants.mainPadding,
                                40,
                                Constants.mainPadding,
                                0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Menu',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    'All ITEMS',
                                    style: TextStyle(
                                        color: CustomColor.textPrimaryColor,
                                        fontWeight: FontWeight.bold),
                                  )
                                ])),
                        const Accordion(
                          title: 'Sharin Plates',
                          content: 'Gyoza',
                        ),
                        const Accordion(title: 'Grill', content: 'Fried tofu'),
                        const Accordion(
                            title: 'Desserts', content: 'House salad'),
                      ],
                    )),
                Container(
                  width: 1,
                  color: Colors.black,
                ),
                Expanded(child: _foods())
              ])),
          const BottomBar(),
        ]),
      ),
    );
  }

  Widget _foods() {
    Size screenSize = MediaQuery.of(context).size;
    double cardWidth = (screenSize.width - 420 - Constants.mainPadding * 4) / 3;
    if (screenSize.width < 1400) {
      cardWidth = screenSize.width * 0.25;
    }
    if (screenSize.width < 800) {
      cardWidth = screenSize.width * 0.1;
    }

    List<double> sizes = [20, 14, 14, 150, 15, 5];
    if (screenSize.width < 1200) {
      sizes = [16, 14, 12, 150, 12, 4];
    }
    if (screenSize.width < 900) {
      sizes = [14, 12, 10, 100, 8, 3];
    }
    if (screenSize.width < 800) {
      sizes = [20, 18, 14, 150, 15, 5];
    }
    if (screenSize.width < 650) {
      sizes = [16, 14, 12, 150, 12, 4];
    }
    if (screenSize.width < 550) {
      sizes = [14, 12, 10, 100, 8, 3];
    }

    Widget widget = Container(
      width: cardWidth,
      margin: const EdgeInsets.symmetric(horizontal: Constants.mainPadding / 2),
      child: Stack(children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          shadowColor: CustomColor.primaryColor.withOpacity(0.2),
          elevation: 8,
          margin: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.asset(
                      Constants.IMG_FOOD_BG,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    alignment: Alignment.center,
                    child: Container(
                      width: sizes[3],
                      height: sizes[3],
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              width: 2, color: CustomColor.activeColor),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100))),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        child: Image.asset(
                          Constants.IMG_SLIDER_HAMBURGER,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gyoza',
                      style: TextStyle(
                          color: CustomColor.primaryColor,
                          fontSize: sizes[0],
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$100',
                      style: TextStyle(
                          fontSize: sizes[0], fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam bibendum ornare vulputate. Curabitur faucibus condimentum purus quis tristique.',
                  style: TextStyle(
                      fontSize: sizes[2],
                      color: CustomColor.textSecondaryColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(
                        color: CustomColor.activeColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Text(
                            '4.5',
                            style: TextStyle(
                                color: Colors.white, fontSize: sizes[1]),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.white,
                            size: sizes[1],
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.location_on,
                      color: CustomColor.activeColor,
                      size: sizes[1],
                    ),
                    SizedBox(width: sizes[5]),
                    Text(
                      '1.2km',
                      style: TextStyle(
                          fontSize: sizes[1],
                          color: CustomColor.textSecondaryColor),
                    ),
                    SizedBox(
                      width: sizes[4],
                    ),
                    Icon(
                      Icons.access_time,
                      size: sizes[1],
                      color: CustomColor.textSecondaryColor,
                    ),
                    SizedBox(width: sizes[5]),
                    Text(
                      '10min',
                      style: TextStyle(
                          fontSize: sizes[1],
                          color: CustomColor.textSecondaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Positioned(
            right: 15,
            top: 15,
            child: Icon(
              Icons.bookmark,
              color: CustomColor.activeColor,
            ))
      ]),
    );

    List<Widget> list = [];
    if (screenSize.width >= 1400) {
      for (var i = 0; i < 10; i++) {
        list.add(Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.mainPadding / 2, vertical: 20),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [widget, widget, widget]),
        ));
      }
    } else if (screenSize.width >= 800 && screenSize.width < 1400) {
      for (var i = 0; i < 15; i++) {
        list.add(Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.mainPadding / 2, vertical: 20),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [widget, widget]),
        ));
      }
    } else {
      for (var i = 0; i < 20; i++) {
        list.add(Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.mainPadding / 2, vertical: 14),
          child: widget,
        ));
      }
    }

    return ListView(children: list);
  }
}
