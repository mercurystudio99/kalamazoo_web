import 'package:bestlocaleats/utils/colors.dart';
import 'package:bestlocaleats/utils/constants.dart';
import 'package:bestlocaleats/utils/globals.dart' as global;
import 'package:bestlocaleats/widgets/top_bar.dart';
import 'package:bestlocaleats/widgets/drawer.dart';
import 'package:bestlocaleats/widgets/bottom_bar.dart';
import 'package:bestlocaleats/widgets/responsive.dart';
import 'package:bestlocaleats/models/app_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:geolocator/geolocator.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  static List<Map<String, dynamic>> favourites = [];

  String _getDistance(List<dynamic> geolocation) {
    double distance = Geolocator.distanceBetween(
        global.latitude, global.longitude, geolocation[0], geolocation[1]);
    distance = distance / 1000;
    return distance.toStringAsFixed(1);
  }

  @override
  void initState() {
    super.initState();
    AppModel().getFavourites(onSuccess: (List<Map<String, dynamic>> param) {
      favourites = param;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    int topbarstatus = 1;
    if (global.userID.isNotEmpty) topbarstatus = 2;
    var screenSize = MediaQuery.of(context).size;
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
              child: TopBarContents(1, topbarstatus, 'favorite', (param) {
                debugPrint('---');
              }),
            ),
      drawer: const MobileDrawer(),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(children: [
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width / 4, vertical: 50),
              child: Stack(
                children: [
                  Container(
                    height: 56,
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
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText:
                            'Search for your favorite foods & restaurants',
                        prefixIcon: Icon(Icons.search,
                            color: CustomColor.textSecondaryColor, size: 24)),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.mainPadding, vertical: 40),
            child: Row(children: const [
              Text('Top Brands', style: TextStyle(fontSize: 24)),
            ]),
          ),
          _topBrands(),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.mainPadding, vertical: 40),
            child: Row(children: const [
              Text('Best offers for you', style: TextStyle(fontSize: 24)),
            ]),
          ),
          _bestOffers(),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.mainPadding, vertical: 40),
            child: Row(children: const [
              Text('Food', style: TextStyle(fontSize: 24)),
            ]),
          ),
          _foods(),
          const SizedBox(height: 40),
          const BottomBar(),
        ]),
      ),
    );
  }

  Widget _topBrands() {
    Size screenSize = MediaQuery.of(context).size;
    double cardWidth = 0;
    if (screenSize.width < 800) {
      cardWidth = 400;
    } else if (screenSize.width < 1100) {
      cardWidth = (screenSize.width - Constants.mainPadding * 3) / 2;
    } else {
      cardWidth = (screenSize.width - Constants.mainPadding * 4) / 3;
    }

    List<Widget> brands = [];
    for (var element in favourites) {
      if (element[Constants.RESTAURANT_BRAND] != null &&
          element[Constants.RESTAURANT_BRAND]) {
        brands.add(brandBox(element, cardWidth));
      }
    }

    if (brands.isEmpty) {
      return Column(children: const [Center(child: Text('No Favorites.'))]);
    }

    List<Widget> list = [];
    if (screenSize.width >= 1100) {
      int rowCount = brands.length ~/ 3;
      for (int i = 0; i < rowCount + 1; i++) {
        if (brands.length > 3 * (i + 1)) {
          list.add(SizedBox(
              height: 146,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Constants.mainPadding / 2, vertical: 8),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: brands.sublist(3 * i, 3 * (i + 1))),
              )));
        } else {
          list.add(SizedBox(
              height: 146,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Constants.mainPadding / 2, vertical: 8),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: brands.sublist(3 * i, brands.length)),
              )));
        }
      }
    } else if (screenSize.width >= 800 && screenSize.width < 1100) {
      int rowCount = brands.length ~/ 2;
      for (int i = 0; i < rowCount + 1; i++) {
        if (brands.length > 2 * (i + 1)) {
          list.add(SizedBox(
              height: 146,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Constants.mainPadding / 2, vertical: 8),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: brands.sublist(2 * i, 2 * (i + 1))),
              )));
        } else {
          list.add(SizedBox(
              height: 146,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Constants.mainPadding / 2, vertical: 8),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: brands.sublist(2 * i, brands.length)),
              )));
        }
      }
    } else {
      for (var i = 0; i < brands.length; i++) {
        list.add(SizedBox(
            height: 146,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.mainPadding / 2, vertical: 8),
              child: brands[i],
            )));
      }
    }

    return Column(children: list);
  }

  Widget brandBox(Map<String, dynamic> item, double cardWidth) {
    return Container(
        margin: const EdgeInsets.symmetric(
            horizontal: Constants.mainPadding / 2, vertical: 12),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        width: cardWidth,
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
        child: InkWell(
          hoverColor: Colors.transparent,
          onTap: () {
            global.restaurantID = item[Constants.RESTAURANT_ID].toString();
            context.go('/about');
          },
          onHover: (value) {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 100,
                child: Image.network(
                    item[Constants.RESTAURANT_IMAGE] ??
                        'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
                    fit: BoxFit.cover),
              ),
              const SizedBox(width: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item[Constants.RESTAURANT_BUSINESSNAME].toString().length <
                            12
                        ? item[Constants.RESTAURANT_BUSINESSNAME].toString()
                        : '${item[Constants.RESTAURANT_BUSINESSNAME].toString().substring(0, 10)}..',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(Constants.SVG_DISH),
                      const SizedBox(width: 5),
                      const Text(
                        'Burger',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: CustomColor.textSecondaryColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.location_on,
                        color: CustomColor.activeColor,
                        size: 16,
                      ),
                      Text(
                        '${_getDistance(item[Constants.RESTAURANT_GEOLOCATION])}km',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: CustomColor.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 1),
                        decoration: BoxDecoration(
                          color: CustomColor.activeColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          children: const [
                            Text(
                              '4.8',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 14,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 30.0,
                      ),
                      const Icon(
                        Icons.access_time,
                        size: 15,
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        '10min',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: CustomColor.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    if (global.userID.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please log in.')),
                      );
                    } else {
                      AppModel().postFavourite(
                          restaurantID: item[Constants.RESTAURANT_ID],
                          onSuccess: () {
                            setState(() {});
                          });
                    }
                  },
                  icon: Icon(
                    global.userFavourites
                            .contains(item[Constants.RESTAURANT_ID])
                        ? Icons.bookmark
                        : Icons.bookmark_outline,
                    color: CustomColor.activeColor,
                  ))
            ],
          ),
        ));
  }

  Widget _bestOffers() {
    Size screenSize = MediaQuery.of(context).size;
    double cardWidth = (screenSize.width - Constants.mainPadding * 5) / 4;
    if (screenSize.width < 1300) {
      cardWidth = (screenSize.width - Constants.mainPadding * 4) / 3;
    }
    if (screenSize.width < 800) {
      cardWidth = (screenSize.width - Constants.mainPadding * 3) / 2;
    }
    if (screenSize.width < 600) {
      cardWidth = screenSize.width / 2;
    }

    List<double> sizes = [20, 18, 14];
    if (screenSize.width < 900) {
      sizes = [18, 16, 12];
    }
    if (screenSize.width < 800) {
      sizes = [20, 18, 14];
    }

    List<Widget> offers = [];
    for (var element in favourites) {
      offers.add(Container(
        width: cardWidth,
        margin:
            const EdgeInsets.symmetric(horizontal: Constants.mainPadding / 2),
        child: Stack(children: [
          InkWell(
            hoverColor: Colors.transparent,
            onTap: () {
              global.restaurantID = element[Constants.RESTAURANT_ID].toString();
              context.go('/about');
            },
            onHover: (value) {},
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              shadowColor: CustomColor.primaryColor.withOpacity(0.2),
              elevation: 8,
              margin: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.network(
                        element[Constants.RESTAURANT_IMAGE] ??
                            'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
                        width: cardWidth,
                        height: cardWidth * 0.6,
                        fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              element[Constants.RESTAURANT_BUSINESSNAME]
                                          .toString()
                                          .length <
                                      12
                                  ? element[Constants.RESTAURANT_BUSINESSNAME]
                                  : '${element[Constants.RESTAURANT_BUSINESSNAME].toString().substring(0, 10)}..',
                              style: TextStyle(
                                  fontSize: sizes[0],
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              element[Constants.RESTAURANT_URL]
                                          .toString()
                                          .length <
                                      22
                                  ? element[Constants.RESTAURANT_URL]
                                  : '${element[Constants.RESTAURANT_URL].toString().substring(0, 20)}..',
                              style: TextStyle(
                                  fontSize: sizes[2],
                                  color: CustomColor.textSecondaryColor),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 1),
                          decoration: BoxDecoration(
                            color: CustomColor.activeColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Row(
                            children: [
                              Text(
                                element[Constants.RESTAURANT_RATING] ?? '0.0',
                                style: TextStyle(
                                    color: Colors.white, fontSize: sizes[2]),
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.white,
                                size: sizes[2],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '50% OFF',
                              style: TextStyle(
                                  fontSize: sizes[0],
                                  color: CustomColor.activeColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'UPTO \$100',
                              style: TextStyle(
                                  fontSize: sizes[1],
                                  color: CustomColor.textSecondaryColor),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: CustomColor.activeColor,
                                size: sizes[2],
                              ),
                              Text(
                                '${_getDistance(element[Constants.RESTAURANT_GEOLOCATION])}km',
                                style: TextStyle(
                                    fontSize: sizes[2],
                                    color: CustomColor.textSecondaryColor),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Icon(
                                Icons.access_time,
                                size: sizes[2],
                                color: CustomColor.textSecondaryColor,
                              ),
                              Text(
                                '10min',
                                style: TextStyle(
                                    fontSize: sizes[2],
                                    color: CustomColor.textSecondaryColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          Positioned(
              right: 10,
              top: 10,
              child: IconButton(
                  onPressed: () {
                    if (global.userID.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please log in.')),
                      );
                    } else {
                      AppModel().postFavourite(
                          restaurantID: element[Constants.RESTAURANT_ID],
                          onSuccess: () {
                            setState(() {});
                          });
                    }
                  },
                  icon: Icon(
                    global.userFavourites
                            .contains(element[Constants.RESTAURANT_ID])
                        ? Icons.bookmark
                        : Icons.bookmark_outline,
                    color: CustomColor.activeColor,
                  )))
        ]),
      ));
    }

    if (offers.isEmpty) {
      return Column(children: const [Center(child: Text('No Favorites.'))]);
    }

    List<Widget> list = [];
    if (screenSize.width >= 1300) {
      int rowCount = offers.length ~/ 4;
      for (int i = 0; i < rowCount + 1; i++) {
        if (offers.length > 4 * (i + 1)) {
          list.add(Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.mainPadding / 2, vertical: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: offers.sublist(4 * i, 4 * (i + 1))),
          ));
        } else {
          list.add(Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.mainPadding / 2, vertical: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: offers.sublist(4 * i, offers.length)),
          ));
        }
      }
    } else if (screenSize.width >= 800 && screenSize.width < 1300) {
      int rowCount = offers.length ~/ 3;
      for (int i = 0; i < rowCount + 1; i++) {
        if (offers.length > 3 * (i + 1)) {
          list.add(Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.mainPadding / 2, vertical: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: offers.sublist(3 * i, 3 * (i + 1))),
          ));
        } else {
          list.add(Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.mainPadding / 2, vertical: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: offers.sublist(3 * i, offers.length)),
          ));
        }
      }
    } else if (screenSize.width >= 600 && screenSize.width < 800) {
      int rowCount = offers.length ~/ 2;
      for (int i = 0; i < rowCount + 1; i++) {
        if (offers.length > 2 * (i + 1)) {
          list.add(Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.mainPadding / 2, vertical: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: offers.sublist(2 * i, 2 * (i + 1))),
          ));
        } else {
          list.add(Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.mainPadding / 2, vertical: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: offers.sublist(2 * i, offers.length)),
          ));
        }
      }
    } else {
      for (var i = 0; i < offers.length; i++) {
        list.add(Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.mainPadding / 2, vertical: 14),
          child: offers[i],
        ));
      }
    }

    return Column(children: list);
  }

  Widget _foods() {
    Size screenSize = MediaQuery.of(context).size;
    double cardWidth = (screenSize.width - Constants.mainPadding * 5) / 4;
    if (screenSize.width < 1300) {
      cardWidth = (screenSize.width - Constants.mainPadding * 4) / 3;
    }
    if (screenSize.width < 800) {
      cardWidth = (screenSize.width - Constants.mainPadding * 3) / 2;
    }
    if (screenSize.width < 600) {
      cardWidth = screenSize.width / 2;
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
    if (screenSize.width >= 1300) {
      for (var i = 0; i < 3; i++) {
        list.add(Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.mainPadding / 2, vertical: 20),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [widget, widget, widget, widget]),
        ));
      }
    } else if (screenSize.width >= 800 && screenSize.width < 1300) {
      for (var i = 0; i < 4; i++) {
        list.add(Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.mainPadding / 2, vertical: 20),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [widget, widget, widget]),
        ));
      }
    } else if (screenSize.width >= 600 && screenSize.width < 800) {
      for (var i = 0; i < 6; i++) {
        list.add(Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.mainPadding / 2, vertical: 20),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [widget, widget]),
        ));
      }
    } else {
      for (var i = 0; i < 12; i++) {
        list.add(Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.mainPadding / 2, vertical: 14),
          child: widget,
        ));
      }
    }

    return Column(children: list);
  }
}
