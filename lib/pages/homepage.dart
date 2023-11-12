import 'package:bestlocaleats/utils/colors.dart';
import 'package:bestlocaleats/utils/constants.dart';
import 'package:bestlocaleats/utils/globals.dart' as global;
import 'package:bestlocaleats/widgets/top_bar.dart';
import 'package:bestlocaleats/widgets/drawer.dart';
import 'package:bestlocaleats/widgets/bottom_bar.dart';
import 'package:bestlocaleats/widgets/responsive.dart';
import 'package:bestlocaleats/widgets/logos.dart';
import 'package:bestlocaleats/widgets/download.dart';
import 'package:bestlocaleats/widgets/featured.dart';
import 'package:bestlocaleats/models/app_model.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';

const minItemHeight = 200.0;
const maxItemHeight = 350.0;
const scrollDuration = Duration(seconds: 2);

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          margin: const EdgeInsets.fromLTRB(10, 80, 10, 0),
          padding: const EdgeInsets.all(10),
          color: Colors.white,
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    Constants.IMG_SLIDER_HAMBURGER,
                    fit: BoxFit.cover,
                  ),
                ],
              )),
        ))
    .toList();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int carouselIndicatorCurrent = 0;
  late ScrollController _scrollController;
  static double _scrollPosition = 0;
  static double _opacity = 0;

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  /// Controller to scroll or jump to a particular item.
  final ItemScrollController itemScrollController = ItemScrollController();

  /// Controller to scroll a certain number of pixels relative to the current
  /// scroll offset.
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();

  /// Listener that reports the position of items when the list is scrolled.
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  late List<double> itemHeights;

  late int categoryItemIndex = 0;
  late String _selectedTopMenu = '';

  List<Map<String, dynamic>> bestOfferList = [];
  List<Map<String, dynamic>> topBrands = [];
  List<Map<String, dynamic>> topMenuList = [];
  List<Map<String, dynamic>> categoryList = [];

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  void _getTopMenu() {
    AppModel().getTopMenu(
      onSuccess: (List<Map<String, dynamic>> param) {
        topMenuList = param;
        setState(() {});
      },
      onEmpty: () {},
    );
  }

  void _getList() {
    AppModel().getListByTopMenu(
      topMenu: _selectedTopMenu,
      onSuccess: (List<Map<String, dynamic>> param) {
        categoryList.clear();
        categoryList = param;
        setState(() {});
      },
      onEmpty: () {
        categoryList.clear();
        setState(() {});
      },
    );
  }

  void _getBestOffers() {
    AppModel().getBestOffers(
        count: 4,
        onSuccess: (List<Map<String, dynamic>> param) {
          bestOfferList = param;
          setState(() {});
        },
        onError: (String text) {});
  }

  void _getTopBrand() {
    AppModel().getTopBrands(
        all: false,
        onSuccess: (List<Map<String, dynamic>> param) {
          topBrands = param;
          setState(() {});
        });
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    global.latitude = position.latitude;
    global.longitude = position.longitude;
    // List<Placemark> placemarks =
    //     await placemarkFromCoordinates(position.latitude, position.longitude);
    // String output = 'No results found.';
    // if (placemarks.isNotEmpty) {
    //   output = placemarks[0].toString();
    // }
  }

  String _getDistance(List<dynamic> geolocation) {
    double distance = Geolocator.distanceBetween(
        global.latitude, global.longitude, geolocation[0], geolocation[1]);
    distance = distance / 1609.344;
    return distance.toStringAsFixed(1);
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    final heightGenerator = Random(328902348);
    itemHeights = List<double>.generate(
        topMenuList.length,
        (int _) =>
            heightGenerator.nextDouble() * (maxItemHeight - minItemHeight) +
            minItemHeight);
    super.initState();
    _getBestOffers();
    _getTopBrand();
    _getTopMenu();
    _getCurrentPosition();
  }

  @override
  void dispose() {
    topBrands.clear();
    bestOfferList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int topbarstatus = 1;
    if (global.userID.isNotEmpty) topbarstatus = 2;
    Size screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition == 0 ? 0 : 1;
    double bannerTitleSize = 0;
    if (screenSize.width > 0) bannerTitleSize = 30;
    if (screenSize.width > 800) bannerTitleSize = 40;
    if (screenSize.width > 1040) bannerTitleSize = 50;
    if (screenSize.width > 1210) bannerTitleSize = 60;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
              iconTheme: IconThemeData(
                  color: _opacity == 0 ? Colors.black : Colors.white),
              // for smaller screen sizes
              backgroundColor: Colors.black.withOpacity(_opacity),
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
              child: TopBarContents(_opacity, topbarstatus, 'home', (param) {
                if (param == 'geolocation') {
                  if (_selectedTopMenu.isEmpty) {
                    _getBestOffers();
                    _getTopBrand();
                  } else {
                    _getList();
                  }
                } else {
                  _selectedTopMenu = '';
                  _scrollController.animateTo(0,
                      duration: const Duration(seconds: 1), curve: Curves.ease);
                  setState(() {});
                }
              }),
            ),
      drawer: const MobileDrawer(),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        child: Column(children: [
          Stack(
            children: [
              if (!ResponsiveWidget.isSmallScreen(context))
                SizedBox(
                  width: screenSize.width / 2,
                  child: Image.asset(
                    Constants.IMG_ELLIPSE1,
                    fit: BoxFit.cover,
                  ),
                ),
              Row(children: [
                if (!ResponsiveWidget.isSmallScreen(context))
                  SizedBox(
                    width: screenSize.width / 2,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Constants.mainPadding, vertical: 80),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: 'Search for your ',
                                    style: GoogleFonts.oleoScriptSwashCaps(
                                        fontSize: bannerTitleSize,
                                        color: CustomColor.activeColor),
                                  ),
                                  TextSpan(
                                      text: 'favorite foods & restaurants',
                                      style: GoogleFonts.oleoScriptSwashCaps(
                                          fontSize: bannerTitleSize,
                                          color: Colors.white)),
                                ]),
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 18),
                                  child: Text(
                                    'Explore Top-Rated Attractions, Activities And More',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  )),
                              Stack(
                                children: [
                                  Container(
                                    height: 56,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: CustomColor.primaryColor
                                                .withOpacity(0.2),
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
                                            color:
                                                CustomColor.textSecondaryColor,
                                            size: 24)),
                                    onFieldSubmitted: (value) {
                                      global.searchText = value;
                                      context.go('/search');
                                    },
                                  ),
                                ],
                              ),
                            ])),
                  ),
                SizedBox(
                    width: ResponsiveWidget.isSmallScreen(context)
                        ? screenSize.width
                        : screenSize.width / 2,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: CarouselSlider(
                          items: imageSliders,
                          options: CarouselOptions(
                              aspectRatio: 2.0,
                              enlargeCenterPage: true,
                              enableInfiniteScroll: false,
                              initialPage: 0,
                              autoPlay: true,
                              pageViewKey: const PageStorageKey<String>(
                                  'carousel_slider'),
                              onPageChanged: (index, reason) {
                                setState(() {
                                  carouselIndicatorCurrent = index;
                                });
                              }),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imgList.asMap().entries.map((entry) {
                          return Container(
                            width: 10,
                            height: 10,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                color: (carouselIndicatorCurrent == entry.key
                                    ? Colors.black
                                    : CustomColor.textSecondaryColor
                                        .withOpacity(0.5))),
                          );
                        }).toList(),
                      ),
                    ]))
              ]),
            ],
          ),
          SizedBox(
            width: screenSize.width,
            height: 120,
            child: OrientationBuilder(
              builder: (context, orientation) => Column(
                children: <Widget>[
                  scrollControlButtons,
                  Expanded(
                    child: list(orientation),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
          if (_selectedTopMenu.isEmpty) const FeaturedSection(),
          if (_selectedTopMenu.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.mainPadding, vertical: 40),
              child: Row(children: [
                const Text('Top Brands Near You',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const Spacer(),
                InkWell(
                    onHover: (value) {},
                    onTap: () {
                      global.listTarget = "brand";
                      context.go('/search');
                    },
                    child: const Text('See All',
                        style: TextStyle(color: CustomColor.activeColor))),
                InkWell(
                    onHover: (value) {},
                    onTap: () {
                      global.listTarget = "brand";
                      context.go('/search');
                    },
                    child: const Icon(Icons.arrow_forward,
                        size: 20, color: CustomColor.activeColor)),
              ]),
            ),
          if (_selectedTopMenu.isEmpty) _topBrands(),
          if (_selectedTopMenu.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.mainPadding, vertical: 40),
              child: Row(children: [
                const Text('Daily Special',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const Spacer(),
                InkWell(
                    onHover: (value) {},
                    onTap: () {
                      global.listTarget = "daily";
                      context.go('/search');
                    },
                    child: const Text('See All',
                        style: TextStyle(color: CustomColor.activeColor))),
                InkWell(
                    onHover: (value) {},
                    onTap: () {
                      global.listTarget = "daily";
                      context.go('/search');
                    },
                    child: const Icon(Icons.arrow_forward,
                        size: 20, color: CustomColor.activeColor)),
              ]),
            ),
          if (_selectedTopMenu.isEmpty) _dailySpecial(),
          if (_selectedTopMenu.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.mainPadding, vertical: 40),
              child: Row(children: [
                const Text('Best offers for you',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const Spacer(),
                InkWell(
                    onHover: (value) {},
                    onTap: () {
                      global.listTarget = "offer";
                      context.go('/search');
                    },
                    child: const Text('See All',
                        style: TextStyle(color: CustomColor.activeColor))),
                InkWell(
                    onHover: (value) {},
                    onTap: () {
                      global.listTarget = "offer";
                      context.go('/search');
                    },
                    child: const Icon(Icons.arrow_forward,
                        size: 20, color: CustomColor.activeColor)),
              ]),
            ),
          if (_selectedTopMenu.isEmpty) _bestOffers(),
          if (_selectedTopMenu.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.mainPadding, vertical: 40),
              child: Row(children: const [
                Text('Results',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ]),
            ),
          if (_selectedTopMenu.isNotEmpty) _list(),
          const SizedBox(height: 40),
          const DownloadSection(),
          const LogosSection(),
          const BottomBar(),
        ]),
      ),
    );
  }

  Widget list(Orientation orientation) => ScrollablePositionedList.builder(
        itemCount: topMenuList.length,
        itemBuilder: (context, index) => item(index, orientation),
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        scrollOffsetController: scrollOffsetController,
        reverse: false,
        scrollDirection: orientation == Orientation.portrait
            ? Axis.vertical
            : Axis.horizontal,
      );

  Widget get scrollControlButtons => Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Constants.mainPadding, vertical: 10),
        child: Row(children: [
          const Text('Categories',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const Spacer(),
          scrollItemButton(categoryItemIndex - 1, true),
          scrollItemButton(categoryItemIndex + 1, false),
        ]),
      );

  ButtonStyle _scrollButtonStyle({required double horizonalPadding}) =>
      ButtonStyle(
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(horizontal: horizonalPadding, vertical: 0),
        ),
        minimumSize: MaterialStateProperty.all(Size.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      );

  Widget scrollItemButton(int value, bool back) => TextButton(
        key: ValueKey<String>('Scroll$value'),
        onPressed: () {
          if (back && value < 0) return;
          if (!back && value > topMenuList.length - 1) return;
          if (back && value > 0) {
            setState(() {
              categoryItemIndex = categoryItemIndex - 1;
            });
          }
          if (!back && value < topMenuList.length - 1) {
            setState(() {
              categoryItemIndex = categoryItemIndex + 1;
            });
          }
          scrollTo(value);
        },
        style: _scrollButtonStyle(horizonalPadding: 10),
        child: back
            ? const Icon(Icons.arrow_back,
                size: 20, color: CustomColor.activeColor)
            : const Icon(Icons.arrow_forward,
                size: 20, color: CustomColor.activeColor),
      );

  void scrollTo(int index) => itemScrollController.scrollTo(
      index: index,
      duration: scrollDuration,
      curve: Curves.easeInOutCubic,
      alignment: 0);

  Widget item(int i, Orientation orientation) {
    double itemWidth = 0;
    Size screenSize = MediaQuery.of(context).size;
    if (screenSize.width > 0) itemWidth = screenSize.width / 2;
    if (screenSize.width > 500) itemWidth = screenSize.width / 3;
    if (screenSize.width > 700) itemWidth = screenSize.width / 4;
    if (screenSize.width > 900) itemWidth = screenSize.width / 5;
    if (screenSize.width > 1100) itemWidth = screenSize.width / 6;
    return SizedBox(
      height: orientation == Orientation.portrait ? itemHeights[i] : null,
      width: orientation == Orientation.landscape ? itemWidth : null,
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.mainPadding, vertical: 10),
          child: SizedBox(
              height: 50,
              child: ElevatedButton(
                style: _selectedTopMenu == topMenuList[i][Constants.TOPMENU_ID]
                    ? ElevatedButton.styleFrom(
                        side: const BorderSide(
                            width: 2, color: CustomColor.primaryColor),
                        backgroundColor: CustomColor.primaryColor,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        shadowColor: CustomColor.primaryColor.withOpacity(0.5),
                        padding: const EdgeInsets.all(5))
                    : ElevatedButton.styleFrom(
                        side: const BorderSide(width: 2, color: Colors.black),
                        backgroundColor: Colors.white,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        shadowColor: CustomColor.primaryColor.withOpacity(0.5),
                        padding: const EdgeInsets.all(5)),
                onPressed: () {
                  setState(() {
                    _selectedTopMenu = topMenuList[i][Constants.TOPMENU_ID];
                  });
                  _getList();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 2),
                    Image.asset(
                      '${Constants.imagePath}topmenu/${topMenuList[i][Constants.TOPMENU_IMAGE]}.png',
                      width: 25,
                    ),
                    const SizedBox(width: 8),
                    Container(
                        width: 1,
                        height: 36,
                        color: _selectedTopMenu ==
                                topMenuList[i][Constants.TOPMENU_ID]
                            ? Colors.white
                            : Colors.black),
                    const SizedBox(width: 8),
                    Text(
                      (topMenuList[i][Constants.TOPMENU_NAME]
                                  .toString()
                                  .length <
                              8)
                          ? topMenuList[i][Constants.TOPMENU_NAME].toString()
                          : '${topMenuList[i][Constants.TOPMENU_NAME].toString().substring(0, 5)}..',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _selectedTopMenu ==
                                  topMenuList[i][Constants.TOPMENU_ID]
                              ? Colors.white
                              : CustomColor.textSecondaryColor),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget _topBrands() {
    double cardWidth = 0;
    if (MediaQuery.of(context).size.width < 800) {
      cardWidth = 400;
    } else if (MediaQuery.of(context).size.width < 1100) {
      cardWidth =
          (MediaQuery.of(context).size.width - Constants.mainPadding * 3) / 2;
    } else {
      cardWidth =
          (MediaQuery.of(context).size.width - Constants.mainPadding * 4) / 3;
    }

    List<Widget> widgetList = [];
    for (var element in topBrands) {
      widgetList.add(brandBox(element, cardWidth));
    }
    List<Widget> displayList;
    if (MediaQuery.of(context).size.width < 800) {
      displayList = widgetList.sublist(0, widgetList.length - 2);
    } else if (MediaQuery.of(context).size.width < 1100) {
      displayList = widgetList.sublist(0, widgetList.length - 1);
    } else {
      displayList = widgetList.sublist(0, widgetList.length);
    }

    return SizedBox(
      height: 130,
      child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: Constants.mainPadding / 2),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: displayList)),
    );
  }

  Widget brandBox(Map<String, dynamic> brand, double cardWidth) {
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
            global.restaurantID = brand[Constants.RESTAURANT_ID].toString();
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
                    brand[Constants.RESTAURANT_IMAGE] ??
                        'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
                    fit: BoxFit.cover),
              ),
              const SizedBox(width: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    brand[Constants.RESTAURANT_BUSINESSNAME].toString().length <
                            15
                        ? brand[Constants.RESTAURANT_BUSINESSNAME]
                        : '${brand[Constants.RESTAURANT_BUSINESSNAME].toString().substring(0, 12)}..',
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
                        '${_getDistance(brand[Constants.RESTAURANT_GEOLOCATION])}mi',
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
                          restaurantID: brand[Constants.RESTAURANT_ID],
                          onSuccess: () {
                            setState(() {});
                          });
                    }
                  },
                  icon: Icon(
                    global.userFavourites
                            .contains(brand[Constants.RESTAURANT_ID])
                        ? Icons.bookmark
                        : Icons.bookmark_outline,
                    color: CustomColor.activeColor,
                  ))
            ],
          ),
        ));
  }

  Widget _dailySpecial() {
    double cardWidth = 0;
    if (MediaQuery.of(context).size.width < 600) {
      cardWidth = 300;
    } else if (MediaQuery.of(context).size.width < 900) {
      cardWidth =
          (MediaQuery.of(context).size.width - Constants.mainPadding * 3) / 2;
    } else if (MediaQuery.of(context).size.width < 1200) {
      cardWidth =
          (MediaQuery.of(context).size.width - Constants.mainPadding * 4) / 3;
    } else {
      cardWidth =
          (MediaQuery.of(context).size.width - Constants.mainPadding * 5) / 4;
    }

    List<Widget> widgetList = [];
    for (var element in bestOfferList) {
      Widget widget = Container(
          width: cardWidth,
          margin:
              const EdgeInsets.symmetric(horizontal: Constants.mainPadding / 2),
          child: InkWell(
            hoverColor: Colors.transparent,
            onTap: () {
              global.restaurantID = element[Constants.RESTAURANT_ID].toString();
              context.go('/about');
            },
            onHover: (value) {},
            child: Stack(children: [
              Card(
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
                            children: const [
                              Text(
                                '50% OFF',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: CustomColor.activeColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'UPTO \$100',
                                style: TextStyle(
                                    fontSize: 18.0,
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
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                const Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 14,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                          style: TextStyle(
                              fontSize: 16,
                              color: CustomColor.textSecondaryColor),
                        )),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              const Positioned(
                  right: 10,
                  top: 10,
                  child: Icon(
                    Icons.bookmark_outline,
                    color: CustomColor.activeColor,
                  ))
            ]),
          ));
      widgetList.add(widget);
    }

    if (widgetList.isEmpty) {
      return const SizedBox(width: 1);
    } else {
      List<Widget> displayList;
      if (MediaQuery.of(context).size.width < 600) {
        displayList = widgetList.sublist(0, widgetList.length - 3);
      } else if (MediaQuery.of(context).size.width < 900) {
        displayList = widgetList.sublist(0, widgetList.length - 2);
      } else if (MediaQuery.of(context).size.width < 1200) {
        displayList = widgetList.sublist(0, widgetList.length - 1);
      } else {
        displayList = widgetList.sublist(0, widgetList.length);
      }
      return Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: Constants.mainPadding / 2),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center, children: displayList),
      );
    }
  }

  Widget _bestOffers() {
    double cardWidth = 0;
    if (MediaQuery.of(context).size.width < 600) {
      cardWidth = 300;
    } else if (MediaQuery.of(context).size.width < 900) {
      cardWidth =
          (MediaQuery.of(context).size.width - Constants.mainPadding * 3) / 2;
    } else if (MediaQuery.of(context).size.width < 1200) {
      cardWidth =
          (MediaQuery.of(context).size.width - Constants.mainPadding * 4) / 3;
    } else {
      cardWidth =
          (MediaQuery.of(context).size.width - Constants.mainPadding * 5) / 4;
    }

    List<Widget> widgetList = [];
    for (var element in bestOfferList) {
      Widget widget = Container(
          width: cardWidth,
          margin:
              const EdgeInsets.symmetric(horizontal: Constants.mainPadding / 2),
          child: InkWell(
            hoverColor: Colors.transparent,
            onTap: () {
              global.restaurantID = element[Constants.RESTAURANT_ID].toString();
              context.go('/about');
            },
            onHover: (value) {},
            child: Stack(children: [
              Card(
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
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              if (element[Constants.RESTAURANT_ADDRESS] != null)
                                Text(
                                  element[Constants.RESTAURANT_ADDRESS]
                                              .toString()
                                              .length <
                                          20
                                      ? element[Constants.RESTAURANT_ADDRESS]
                                      : '${element[Constants.RESTAURANT_ADDRESS].toString().substring(0, 18)}..',
                                  style: const TextStyle(
                                      fontSize: 14.0,
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
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                const Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 14,
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
                            children: const [
                              Text(
                                '50% OFF',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: CustomColor.activeColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'UPTO \$100',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: CustomColor.textSecondaryColor),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: CustomColor.activeColor,
                                  size: 14,
                                ),
                                Text(
                                  '${_getDistance(element[Constants.RESTAURANT_GEOLOCATION])}mi',
                                  style: const TextStyle(
                                      fontSize: 14.0,
                                      color: CustomColor.textSecondaryColor),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Icon(
                                  Icons.access_time,
                                  size: 14,
                                  color: CustomColor.textSecondaryColor,
                                ),
                                const Text(
                                  '10min',
                                  style: TextStyle(
                                      fontSize: 14.0,
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
      widgetList.add(widget);
    }

    if (widgetList.isEmpty) {
      return const SizedBox(width: 1);
    } else {
      List<Widget> displayList;
      if (MediaQuery.of(context).size.width < 600) {
        displayList = widgetList.sublist(0, widgetList.length - 3);
      } else if (MediaQuery.of(context).size.width < 900) {
        displayList = widgetList.sublist(0, widgetList.length - 2);
      } else if (MediaQuery.of(context).size.width < 1200) {
        displayList = widgetList.sublist(0, widgetList.length - 1);
      } else {
        displayList = widgetList.sublist(0, widgetList.length);
      }
      return Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: Constants.mainPadding / 2),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center, children: displayList),
      );
    }
  }

  Widget _list() {
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

    if (categoryList.isEmpty) {
      return Column(children: const [
        Text(
          'No stores available in your area. Please come back soon to try again.',
          style: TextStyle(color: CustomColor.textSecondaryColor),
        )
      ]);
    } else {
      List<Widget> widgetList = [];
      for (var element in categoryList) {
        Widget widget = Container(
            width: cardWidth,
            margin: const EdgeInsets.symmetric(
                horizontal: Constants.mainPadding / 2),
            child: InkWell(
              hoverColor: Colors.transparent,
              onTap: () {
                global.restaurantID =
                    element[Constants.RESTAURANT_ID].toString();
                context.go('/about');
              },
              onHover: (value) {},
              child: Stack(children: [
                Card(
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
                          fit: BoxFit.cover,
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
                                  element[Constants.RESTAURANT_BUSINESSNAME]
                                              .toString()
                                              .length <
                                          18
                                      ? element[
                                          Constants.RESTAURANT_BUSINESSNAME]
                                      : '${element[Constants.RESTAURANT_BUSINESSNAME].toString().substring(0, 12)}..',
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
                                    '4.5',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: sizes[2]),
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
                                    '${_getDistance(element[Constants.RESTAURANT_GEOLOCATION])}mi',
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
        widgetList.add(widget);
      }

      int colCount = 0;
      List<Widget> rowList = [];
      if (screenSize.width >= 1300) {
        colCount = 4;
      } else if (screenSize.width >= 800 && screenSize.width < 1300) {
        colCount = 3;
      } else if (screenSize.width >= 600 && screenSize.width < 800) {
        colCount = 2;
      } else {
        colCount = 0;
        for (var i = 0; i < widgetList.length; i++) {
          rowList.add(Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.mainPadding / 2, vertical: 14),
            child: widgetList[i],
          ));
        }
      }

      if (colCount > 0) {
        int rowCount = widgetList.length ~/ colCount;
        for (int i = 0; i < rowCount + 1; i++) {
          if (widgetList.length > colCount * (i + 1)) {
            rowList.add(Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.mainPadding / 2, vertical: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:
                      widgetList.sublist(colCount * i, colCount * (i + 1))),
            ));
          } else {
            rowList.add(Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.mainPadding / 2, vertical: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:
                      widgetList.sublist(colCount * i, widgetList.length)),
            ));
          }
        }
      }

      return Column(children: rowList);
    }
  }
}
