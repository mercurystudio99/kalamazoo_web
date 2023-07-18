import 'package:bestlocaleats/utils/colors.dart';
import 'package:bestlocaleats/utils/constants.dart';
import 'package:bestlocaleats/widgets/top_bar.dart';
import 'package:bestlocaleats/widgets/drawer.dart';
import 'package:bestlocaleats/widgets/bottom_bar.dart';
import 'package:bestlocaleats/widgets/responsive.dart';
import 'package:bestlocaleats/widgets/logos.dart';
import 'package:bestlocaleats/widgets/download.dart';
import 'package:bestlocaleats/widgets/contact.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:google_fonts/google_fonts.dart';

const numberOfItems = 8;
const minItemHeight = 200.0;
const maxItemHeight = 350.0;
const scrollDuration = Duration(seconds: 2);

const randomMax = 10000;

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
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    Constants.IMG_SLIDER_HAMBURGER,
                    fit: BoxFit.cover,
                    width: 220,
                    height: 220,
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
  late List<Color> itemColors;

  /// The alignment to be used next time the user scrolls or jumps to an item.
  double alignment = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    final heightGenerator = Random(328902348);
    final colorGenerator = Random(42490823);
    itemHeights = List<double>.generate(
        numberOfItems,
        (int _) =>
            heightGenerator.nextDouble() * (maxItemHeight - minItemHeight) +
            minItemHeight);
    itemColors = List<Color>.generate(numberOfItems,
        (int _) => Color(colorGenerator.nextInt(randomMax)).withOpacity(1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition == 0 ? 0 : 1;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
              // for smaller screen sizes
              backgroundColor: Colors.blueGrey[900]?.withOpacity(_opacity),
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
              child: TopBarContents(_opacity, 1),
            ),
      drawer: MobileDrawer(),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: ClampingScrollPhysics(),
        child: Column(children: [
          Stack(
            children: [
              Container(
                child: SizedBox(
                  width: screenSize.width / 2,
                  child: Image.asset(
                    Constants.IMG_ELLIPSE1,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Row(children: [
                Expanded(
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
                                        fontSize: 60,
                                        color: CustomColor.activeColor),
                                  ),
                                  TextSpan(
                                      text: 'favorite foods & restaurants',
                                      style: GoogleFonts.oleoScriptSwashCaps(
                                          fontSize: 60, color: Colors.white)),
                                ]),
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  child: Text(
                                    'Explore Top-Rated Attractions, Activities And More',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  )),
                              Stack(
                                children: [
                                  Container(
                                    height: 52,
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
                                  ),
                                ],
                              ),
                            ]))),
                Expanded(
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
                          pageViewKey:
                              const PageStorageKey<String>('carousel_slider'),
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
            height: 200,
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
          const ContactSection(),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.mainPadding, vertical: 40),
            child: Row(children: [
              const Text('Top Brands Near You', style: TextStyle(fontSize: 24)),
              const Spacer(),
              InkWell(
                  onHover: (value) {},
                  onTap: () {},
                  child: const Text('See All',
                      style: TextStyle(color: CustomColor.activeColor))),
              InkWell(
                  onHover: (value) {},
                  onTap: () {},
                  child: const Icon(Icons.arrow_forward,
                      size: 20, color: CustomColor.activeColor)),
            ]),
          ),
          _topBrands(),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.mainPadding, vertical: 40),
            child: Row(children: [
              const Text('Best offers for you', style: TextStyle(fontSize: 24)),
              const Spacer(),
              InkWell(
                  onHover: (value) {},
                  onTap: () {},
                  child: const Text('See All',
                      style: TextStyle(color: CustomColor.activeColor))),
              InkWell(
                  onHover: (value) {},
                  onTap: () {},
                  child: const Icon(Icons.arrow_forward,
                      size: 20, color: CustomColor.activeColor)),
            ]),
          ),
          _bestOffers(),
          const SizedBox(height: 40),
          const DownloadSection(),
          const LogosSection(),
          const BottomBar(),
        ]),
      ),
    );
  }

  Widget list(Orientation orientation) => ScrollablePositionedList.builder(
        itemCount: numberOfItems,
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
            horizontal: Constants.mainPadding, vertical: 40),
        child: Row(children: [
          const Text('Categories', style: TextStyle(fontSize: 24)),
          const Spacer(),
          scrollItemButton(0, true),
          scrollItemButton(1, false),
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

  Widget scrollItemButton(int value, bool next) => TextButton(
        key: ValueKey<String>('Scroll$value'),
        onPressed: () => scrollTo(value),
        style: _scrollButtonStyle(horizonalPadding: 10),
        child: next
            ? const Icon(Icons.arrow_back,
                size: 20, color: CustomColor.activeColor)
            : const Icon(Icons.arrow_forward,
                size: 20, color: CustomColor.activeColor),
      );

  void scrollTo(int index) => itemScrollController.scrollTo(
      index: index,
      duration: scrollDuration,
      curve: Curves.easeInOutCubic,
      alignment: alignment);

  Widget item(int i, Orientation orientation) {
    return SizedBox(
      height: orientation == Orientation.portrait ? itemHeights[i] : null,
      width: orientation == Orientation.landscape ? itemHeights[i] : null,
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.mainPadding / 2, vertical: 20),
          child: SizedBox(
              width: 140,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    side: const BorderSide(width: 2, color: Colors.black),
                    backgroundColor: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    shadowColor: CustomColor.primaryColor.withOpacity(0.5),
                    padding: const EdgeInsets.all(5)),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 2),
                    Image.asset(
                      Constants.IMG_COFFEECUP,
                      width: 25,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Coffee',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: CustomColor.textSecondaryColor),
                    )
                  ],
                ),
              )),
        ),
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
}
