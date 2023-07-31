import 'package:bestlocaleats/utils/colors.dart';
import 'package:bestlocaleats/utils/constants.dart';
import 'package:bestlocaleats/utils/router.dart';
import 'package:bestlocaleats/widgets/top_bar.dart';
import 'package:bestlocaleats/widgets/drawer.dart';
import 'package:bestlocaleats/widgets/bottom_bar.dart';
import 'package:bestlocaleats/widgets/responsive.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  NavigationRouter.switchToHomePage(context);
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
              child: const TopBarContents(1, 1),
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

    List<Widget> list = [];
    if (screenSize.width >= 1100) {
      for (var i = 0; i < 2; i++) {
        list.add(SizedBox(
            height: 146,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.mainPadding / 2, vertical: 8),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                brandBox('Mc Donald\'S', 0, cardWidth),
                brandBox('Mc Donald\'S', 0, cardWidth),
                brandBox('Mc Donald\'S', 0, cardWidth)
              ]),
            )));
      }
    } else if (screenSize.width >= 800 && screenSize.width < 1100) {
      for (var i = 0; i < 3; i++) {
        list.add(SizedBox(
            height: 146,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.mainPadding / 2, vertical: 8),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                brandBox('Mc Donald\'S', 0, cardWidth),
                brandBox('Mc Donald\'S', 0, cardWidth)
              ]),
            )));
      }
    } else {
      for (var i = 0; i < 6; i++) {
        list.add(SizedBox(
            height: 146,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.mainPadding / 2, vertical: 8),
              child: brandBox('Mc Donald\'S', 0, cardWidth),
            )));
      }
    }

    return Column(children: list);
  }

  Widget brandBox(String title, int index, double cardWidth) {
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 100,
              child: Image.asset(
                Constants.IMG_GROUP,
                fit: BoxFit.cover,
              )),
          const SizedBox(width: 30),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Mc Donald\'S',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                  const Text(
                    '1.2km',
                    style: TextStyle(
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: CustomColor.activeColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      children: const [
                        Text(
                          '4.8',
                          style: TextStyle(color: Colors.white, fontSize: 14),
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
          const Icon(
            Icons.bookmark,
            color: CustomColor.activeColor,
          ),
        ],
      ),
    );
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
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.network(
                  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
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
                          'Alro Business',
                          style: TextStyle(
                              fontSize: sizes[0], fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'demo.restaurant.com',
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
                            '4.5',
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
                            '1.2km',
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
        const Positioned(
            right: 10,
            top: 10,
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
