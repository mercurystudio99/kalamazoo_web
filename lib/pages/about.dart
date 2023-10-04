import 'package:bestlocaleats/models/app_model.dart';
import 'package:bestlocaleats/utils/colors.dart';
import 'package:bestlocaleats/utils/constants.dart';
import 'package:bestlocaleats/utils/globals.dart' as global;
import 'package:bestlocaleats/widgets/top_bar.dart';
import 'package:bestlocaleats/widgets/drawer.dart';
import 'package:bestlocaleats/widgets/bottom_bar.dart';
import 'package:bestlocaleats/widgets/responsive.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  late Map<String, dynamic> restaurant = {};
  late Map<String, dynamic> menu = {};
  late List<Map<String, dynamic>> foods = [];
  late List<Map<String, dynamic>> amenities = [];
  late List<Map<String, dynamic>> categories = [];

  late String target = '';

  void _getCategories() {
    AppModel().getCategories(
      onSuccess: (List<Map<String, dynamic>> param) {
        categories = param;
        getMenu();
      },
      onEmpty: () {},
    );
  }

  void _getRestaurant() {
    AppModel().getRestaurantByID(
        id: global.restaurantID,
        onSuccess: (Map<String, dynamic>? param) {
          restaurant = param!;
          setState(() {});
        },
        onError: (String value) {});
    AppModel().getRestaurantFoodByID(
        id: global.restaurantID,
        onSuccess: (List<Map<String, dynamic>> param) {
          foods = param;
          _getCategories();
        },
        onError: (String value) {});
  }

  void _getAmenities() {
    AppModel().getAmenities(
      onSuccess: (List<Map<String, dynamic>> param) {
        amenities = param;
        setState(() {});
      },
      onEmpty: () {},
    );
  }

  void getMenu() {
    for (var food in foods) {
      if (food[Constants.MENU_CATEGORY] == null) continue;
      if (menu.containsKey(food[Constants.MENU_CATEGORY])) continue;
      for (var category in categories) {
        if (food[Constants.MENU_CATEGORY] == category[Constants.CATEGORY_ID]) {
          menu.addAll({
            category[Constants.CATEGORY_ID]: category[Constants.CATEGORY_NAME]
          });
          break;
        }
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getRestaurant();
    _getAmenities();
  }

  @override
  Widget build(BuildContext context) {
    int topbarstatus = 1;
    if (global.userID.isNotEmpty) topbarstatus = 2;
    var screenSize = MediaQuery.of(context).size;
    List<double> bannersizes = [300, 360];
    List<double> menusizes = [400];
    int amenitiesColCount = 3;
    if (screenSize.width < 1200) {
      menusizes = [300];
      amenitiesColCount = 2;
    }
    if (screenSize.width < 800) {
      bannersizes = [300, 250];
      menusizes = [300];
      amenitiesColCount = 2;
    }
    if (screenSize.width < 680) {
      bannersizes = [300, 0];
      menusizes = [screenSize.width / 2];
      amenitiesColCount = 2;
    }

    List<Widget> leftSideList = [];
    leftSideList.add(Padding(
        padding: const EdgeInsets.fromLTRB(
            Constants.mainPadding, 40, Constants.mainPadding, 0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Menu',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                'All ITEMS',
                style: TextStyle(
                    color: CustomColor.textPrimaryColor,
                    fontWeight: FontWeight.bold),
              )
            ])));
    menu.forEach((key, value) {
      leftSideList.add(Padding(
          padding: const EdgeInsets.all(0),
          child: ListTile(
            title: Text(
              value,
              style: TextStyle(
                  color: target == key
                      ? CustomColor.activeColor
                      : CustomColor.textPrimaryColor,
                  fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              setState(() {
                target = key;
              });
            },
          )));
    });

    leftSideList.add(Padding(
        padding: const EdgeInsets.fromLTRB(
            Constants.mainPadding, 40, Constants.mainPadding, 0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Daily Special',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )
            ])));

    Widget widget = Padding(
        padding: const EdgeInsets.all(10),
        child: InkWell(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.symmetric(
                horizontal: Constants.mainPadding, vertical: 8),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: CustomColor.primaryColor.withOpacity(0.2),
                  blurRadius: 8.0,
                ),
              ],
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(15),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      // child: (restaurant[RESTAURANT_IMAGE] != null)
                      //     ? Image.network(restaurant[RESTAURANT_IMAGE],
                      //         height: 100, fit: BoxFit.cover)
                      //     : Image.asset(
                      //         'assets/group.png',
                      //         fit: BoxFit.cover,
                      //       )),
                      child: Image.asset(
                        'assets/group.png',
                        fit: BoxFit.cover,
                      )),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: _Description(
                    caption:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    discount: '50% OFF',
                    range: 'UPTO',
                    amount: '100',
                  ),
                )
              ],
            ),
          ),
        ));
    leftSideList.add(widget);

    List<Widget> lists = [];
    for (var item in amenities) {
      if (restaurant[Constants.RESTAURANT_AMENITIES] != null &&
          restaurant[Constants.RESTAURANT_AMENITIES]
              .contains(item[Constants.AMENITY_ID])) {
        lists.add(SizedBox(
            width: (menusizes[0] - Constants.mainPadding * 2 - 10) /
                amenitiesColCount,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Column(children: [
                Image.asset(
                  '${Constants.imagePath}amenities/icon (${item[Constants.AMENITY_LOGO]}).png',
                ),
                const SizedBox(height: 5),
                Text(
                    item[Constants.AMENITY_NAME].toString().length < 10
                        ? item[Constants.AMENITY_NAME]
                        : '${item[Constants.AMENITY_NAME].toString().substring(0, 10)}..',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: CustomColor.textPrimaryColor))
              ]),
            )));
      }
    }
    if (lists.isNotEmpty) {
      int rowCount = lists.length ~/ amenitiesColCount;
      List<Widget> rowList = [];
      for (int i = 0; i < rowCount + 1; i++) {
        if (lists.length > amenitiesColCount * (i + 1)) {
          rowList.add(Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: lists.sublist(
                  amenitiesColCount * i, amenitiesColCount * (i + 1))));
        } else {
          rowList.add(Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: lists.sublist(amenitiesColCount * i, lists.length)));
        }
      }

      leftSideList.add(Padding(
          padding: const EdgeInsets.fromLTRB(
              Constants.mainPadding, 40, Constants.mainPadding, 0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Amenities',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )
              ])));
      leftSideList.add(Padding(
          padding: const EdgeInsets.fromLTRB(
              Constants.mainPadding, 20, Constants.mainPadding, 20),
          child: Container(
            width: menusizes[0] - Constants.mainPadding * 2,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: CustomColor.primaryColor.withOpacity(0.2),
                  blurRadius: 8.0,
                ),
              ],
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: rowList),
          )));
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
              child: TopBarContents(1, topbarstatus, 'about', (param) {
                debugPrint('---');
              }),
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
                          Text(
                              restaurant[Constants.RESTAURANT_BUSINESSNAME] ??
                                  '',
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
                              children: [
                                const Text(
                                  'Phone',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  restaurant[Constants.RESTAURANT_PHONE] ?? '',
                                  style: const TextStyle(
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
                              children: [
                                const Text(
                                  'E-mail',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  restaurant[Constants.RESTAURANT_EMAIL] ?? '',
                                  style: const TextStyle(
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
                              children: [
                                const Text(
                                  'Location',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  restaurant[Constants.RESTAURANT_ADDRESS] ??
                                      '',
                                  style: const TextStyle(
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
                      children: leftSideList,
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

    List<Widget> lists = [];
    for (var item in foods) {
      if (item[Constants.MENU_CATEGORY] != null &&
          item[Constants.MENU_CATEGORY] == target) {
        lists.add(Container(
          width: cardWidth,
          margin:
              const EdgeInsets.symmetric(horizontal: Constants.mainPadding / 2),
          child: Stack(children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
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
                            child: (item[Constants.MENU_PHOTO] != null)
                                ? Image.network(
                                    item[Constants.MENU_PHOTO].toString(),
                                    fit: BoxFit.cover)
                                : Image.asset(
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
                          (item[Constants.MENU_NAME].toString().length < 18)
                              ? item[Constants.MENU_NAME].toString()
                              : '${item[Constants.MENU_NAME].toString().substring(0, 15)}..',
                          style: TextStyle(
                              color: CustomColor.primaryColor,
                              fontSize: sizes[0],
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$${item[Constants.MENU_PRICE]}',
                          style: TextStyle(
                              fontSize: sizes[0], fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
                    child: Text(
                      item[Constants.MENU_DESCRIPTION] ?? '',
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
        ));
      }
    }

    List<Widget> rowList = [];
    if (screenSize.width >= 1400) {
      int rowCount = lists.length ~/ 3;
      for (int i = 0; i < rowCount + 1; i++) {
        if (lists.length > 3 * (i + 1)) {
          rowList.add(Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.mainPadding / 2, vertical: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: lists.sublist(3 * i, 3 * (i + 1))),
          ));
        } else {
          rowList.add(Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.mainPadding / 2, vertical: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: lists.sublist(3 * i, lists.length)),
          ));
        }
      }
    } else if (screenSize.width >= 800 && screenSize.width < 1400) {
      int rowCount = lists.length ~/ 2;
      for (int i = 0; i < rowCount + 1; i++) {
        if (lists.length > 2 * (i + 1)) {
          rowList.add(Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.mainPadding / 2, vertical: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: lists.sublist(2 * i, 2 * (i + 1))),
          ));
        } else {
          rowList.add(Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.mainPadding / 2, vertical: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: lists.sublist(2 * i, lists.length)),
          ));
        }
      }
    } else {
      for (var i = 0; i < lists.length; i++) {
        rowList.add(Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.mainPadding / 2, vertical: 14),
          child: lists[i],
        ));
      }
    }

    return ListView(children: rowList);
  }
}

class _Description extends StatelessWidget {
  const _Description({
    required this.caption,
    required this.discount,
    required this.range,
    required this.amount,
  });

  final String caption;
  final String discount;
  final String range;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(children: [
              Text(
                discount,
                style: const TextStyle(
                    color: CustomColor.activeColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              Text(
                '$range  $amount',
                style: const TextStyle(
                    color: CustomColor.textSecondaryColor, fontSize: 10),
              )
            ]),
            const Icon(
              Icons.bookmark,
              color: CustomColor.activeColor,
            ),
          ],
        ),
        Text(
          caption,
          style: const TextStyle(
              color: CustomColor.textSecondaryColor, fontSize: 10),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: CustomColor.activeColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: const [
              Text(
                '5.3',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              Icon(
                Icons.star,
                color: Colors.white,
                size: 12,
              )
            ],
          ),
        ),
      ],
    );
  }
}
