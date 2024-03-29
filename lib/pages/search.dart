import 'package:bestlocaleats/models/app_model.dart';
import 'package:bestlocaleats/utils/colors.dart';
import 'package:bestlocaleats/utils/constants.dart';
import 'package:bestlocaleats/utils/globals.dart' as global;
import 'package:bestlocaleats/widgets/top_bar.dart';
import 'package:bestlocaleats/widgets/drawer.dart';
import 'package:bestlocaleats/widgets/bottom_bar.dart';
import 'package:bestlocaleats/widgets/responsive.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  static List<Map<String, dynamic>> restaurants = [];
  static List<Map<String, dynamic>> results = [];

  void _search(String value) {
    results.clear();
    for (var element in restaurants) {
      if (element[Constants.RESTAURANT_BUSINESSNAME]
          .toString()
          .toLowerCase()
          .contains(value.toLowerCase())) {
        results.add(element);
      }
    }
    setState(() {});
  }

  void _getList() {
    switch (global.listTarget) {
      case 'brand':
        AppModel().getTopBrands(
          all: true,
          onSuccess: (List<Map<String, dynamic>> param) {
            restaurants = param;
            _search(_searchController.text);
          },
        );
        break;
      case 'daily':
        AppModel().getBestOffers(
          count: 0,
          onSuccess: (List<Map<String, dynamic>> param) {
            restaurants = param;
            _search(_searchController.text);
          },
          onError: (p0) {},
        );
        break;
      case 'offer':
        AppModel().getBestOffers(
          count: 0,
          onSuccess: (List<Map<String, dynamic>> param) {
            restaurants = param;
            _search(_searchController.text);
          },
          onError: (p0) {},
        );
        break;
      default:
        AppModel().getList(
          onSuccess: (List<Map<String, dynamic>> param) {
            restaurants = param;
            _search(_searchController.text);
          },
        );
        break;
    }
  }

  String _getDistance(List<dynamic> geolocation) {
    double distance = Geolocator.distanceBetween(
        global.latitude, global.longitude, geolocation[0], geolocation[1]);
    distance = distance / 1609.344;
    return distance.toStringAsFixed(1);
  }

  @override
  void initState() {
    super.initState();
    _searchController.text = global.searchText;
    _getList();
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
              child: TopBarContents(1, topbarstatus, 'search', (param) {
                _getList();
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
                    controller: _searchController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText:
                            'Search for your favorite foods & restaurants',
                        prefixIcon: Icon(Icons.search,
                            color: CustomColor.textSecondaryColor, size: 24)),
                    onFieldSubmitted: (value) {
                      _search(value);
                    },
                  ),
                ],
              )),
          const SizedBox(height: 10),
          SizedBox(
              width: screenSize.width,
              height: screenSize.height,
              child: _searchView()),
          const BottomBar(),
        ]),
      ),
    );
  }

  Widget _searchView() {
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

    List<Widget> lists = results.map((item) {
      return Container(
        width: cardWidth,
        margin:
            const EdgeInsets.symmetric(horizontal: Constants.mainPadding / 2),
        child: Stack(children: [
          InkWell(
            onTap: () {
              global.restaurantID = item[Constants.RESTAURANT_ID].toString();
              context.go('/about');
            },
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
                        (item[Constants.RESTAURANT_IMAGE] != null)
                            ? item[Constants.RESTAURANT_IMAGE].toString()
                            : 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
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
                              (item[Constants.RESTAURANT_BUSINESSNAME]
                                          .toString()
                                          .length <
                                      20)
                                  ? item[Constants.RESTAURANT_BUSINESSNAME]
                                      .toString()
                                  : '${item[Constants.RESTAURANT_BUSINESSNAME].toString().substring(0, 18)}..',
                              style: TextStyle(
                                  fontSize: sizes[0],
                                  fontWeight: FontWeight.bold),
                            ),
                            if (item[Constants.RESTAURANT_URL] != null)
                              Text(
                                (item[Constants.RESTAURANT_URL]
                                            .toString()
                                            .length <
                                        28)
                                    ? item[Constants.RESTAURANT_URL].toString()
                                    : '${item[Constants.RESTAURANT_URL].toString().substring(0, 25)}..',
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
                                '${_getDistance(item[Constants.RESTAURANT_GEOLOCATION])}mi',
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
                  )))
        ]),
      );
    }).toList();

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

    if (lists.isEmpty) {
      return const Center(
          child: Text(
              'No stores available in your area. Please come back soon to try again.',
              style: TextStyle(color: CustomColor.textPrimaryColor)));
    } else {
      return ListView(children: rowList);
    }
  }
}
