import 'package:bestlocaleats/utils/colors.dart';
import 'package:bestlocaleats/utils/constants.dart';
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
              // for smaller screen sizes
              backgroundColor: Colors.blueGrey[900]?.withOpacity(0),
              elevation: 0,
              title: Text(
                'EXPLORE',
                style: TextStyle(
                  color: Colors.blueGrey.shade100,
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 3,
                ),
              ),
            )
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
                    height: 52,
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
    return SizedBox(
      height: 130,
      child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: Constants.mainPadding / 2),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            brandBox('Mc Donald\'S', 0),
            brandBox('Mc Donald\'S', 0),
            brandBox('Mc Donald\'S', 0),
          ])),
    );
  }

  Widget brandBox(String title, int index) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.symmetric(
          horizontal: Constants.mainPadding / 2, vertical: 12),
      padding: const EdgeInsets.all(4),
      width: MediaQuery.of(context).size.width / 4,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: CustomColor.primaryColor.withOpacity(0.2),
            blurRadius: 8.0,
          ),
        ],
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
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
              const Text('Mc Donald\'S'),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(Constants.SVG_DISH),
                  const Text(
                    'Burger',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: CustomColor.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.location_on,
                    color: CustomColor.activeColor,
                    size: 12,
                  ),
                  const Text(
                    '1.2km',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: CustomColor.textSecondaryColor,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
                  const SizedBox(
                    width: 10.0,
                  ),
                  const Icon(
                    Icons.access_time,
                    size: 12,
                  ),
                  const Text(
                    '10min',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.0,
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
    ));
  }

  Widget _bestOffers() {
    Widget widget = SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: Stack(children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          shadowColor: CustomColor.primaryColor.withOpacity(0.2),
          elevation: 8,
          margin: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.network(
                  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
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
                          style: const TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'demo.restaurant.com',
                          style: const TextStyle(
                              fontSize: 10.0,
                              color: CustomColor.textSecondaryColor),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: CustomColor.activeColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Text(
                            '4.5',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                          const Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 12,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
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
                          style: const TextStyle(
                              fontSize: 14.0,
                              color: CustomColor.activeColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'UPTO \$100',
                          style: const TextStyle(
                              fontSize: 10.0,
                              color: CustomColor.textSecondaryColor),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.location_on,
                            color: CustomColor.activeColor,
                            size: 10,
                          ),
                          Text(
                            '1.2km',
                            style: TextStyle(
                                fontSize: 10.0,
                                color: CustomColor.textSecondaryColor),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Icon(
                            Icons.access_time,
                            size: 10,
                            color: CustomColor.textSecondaryColor,
                          ),
                          Text(
                            '10min',
                            style: TextStyle(
                                fontSize: 10.0,
                                color: CustomColor.textSecondaryColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Constants.mainPadding),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(child: widget),
        Expanded(child: widget),
        Expanded(child: widget),
        Expanded(child: widget),
      ]),
    );
  }

  Widget _foods() {
    Widget widget = SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: Stack(children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          shadowColor: CustomColor.primaryColor.withOpacity(0.2),
          elevation: 8,
          margin: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image.asset(
                      Constants.IMG_FOOD_BG,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    alignment: Alignment.center,
                    child: Container(
                      width: 200,
                      height: 200,
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
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Gyoza',
                      style: TextStyle(
                          color: CustomColor.primaryColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$100',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam bibendum ornare vulputate. Curabitur faucibus condimentum purus quis tristique.',
                  style: TextStyle(
                      fontSize: 10.0, color: CustomColor.textSecondaryColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: CustomColor.activeColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: const [
                          Text(
                            '4.5',
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
                    const Icon(
                      Icons.location_on,
                      color: CustomColor.activeColor,
                      size: 10,
                    ),
                    const Text(
                      '1.2km',
                      style: TextStyle(
                          fontSize: 10.0,
                          color: CustomColor.textSecondaryColor),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Icon(
                      Icons.access_time,
                      size: 10,
                      color: CustomColor.textSecondaryColor,
                    ),
                    const Text(
                      '10min',
                      style: TextStyle(
                          fontSize: 10.0,
                          color: CustomColor.textSecondaryColor),
                    ),
                  ],
                ),
              ),
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Constants.mainPadding),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(child: widget),
        Expanded(child: widget),
        Expanded(child: widget),
        Expanded(child: widget),
      ]),
    );
  }
}
