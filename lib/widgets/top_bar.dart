import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:bestlocaleats/utils/constants.dart';
import 'package:bestlocaleats/utils/colors.dart';
import 'package:bestlocaleats/utils/globals.dart' as global;
import 'package:bestlocaleats/key.dart';
import 'package:go_router/go_router.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

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
    false, // 6: subscription
    false, // 7: location
    false, // 8: close X
  ];

  static String location = '';
  static List<Map<String, dynamic>> locations = [];

  Future<void> _showLocationDialog(BuildContext context) async {
    await showGeneralDialog<void>(
        context: context,
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (bc, ania, anis) => StatefulBuilder(
            builder: (context, setState) => Dialog(
                backgroundColor: Colors.transparent,
                child: SizedBox.expand(
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Padding(
                      padding: const EdgeInsets.all(Constants.mainPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onHover: (value) {
                                    setState(() {
                                      value
                                          ? _isHovering[8] = true
                                          : _isHovering[8] = false;
                                    });
                                  },
                                  onTap: () {
                                    locations.clear();
                                    Navigator.of(context).pop();
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: _isHovering[8]
                                        ? Colors.white
                                        : Colors.grey,
                                  ),
                                )
                              ]),
                          const SizedBox(height: 10),
                          TextField(
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                                border: OutlineInputBorder(),
                                hintText: 'Search',
                                prefixIconConstraints: BoxConstraints(
                                  minWidth: 50,
                                  minHeight: 2,
                                ),
                                prefixIcon:
                                    Icon(Icons.search_outlined, size: 24),
                              ),
                              onSubmitted: (value) async {
                                getLocationsFromAPI(value);
                              }),
                          if (locations.isNotEmpty) _listing(context)
                        ],
                      ),
                    ),
                  ),
                ))));
  }

  Future<void> getLocationsFromAPI(String keyword) async {
    var url =
        'https://proxy.cors.sh/https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$keyword&language=en&types=geocode&key=$kGoogleApiKey';

    try {
      Map<String, String> requestHeaders = {
        "x-requested-with": "XMLHttpRequest",
        'x-cors-api-key': 'temp_7cba4ae4f44b4fb09c829d32c07bdf66'
      };
      final response = await http.get(Uri.parse(url), headers: requestHeaders);
      if (response.statusCode == 200) {
        final List<dynamic> list = json.decode(response.body)["predictions"];
        if (list.isNotEmpty) {
          for (var item in list) {
            locations.add({
              'description': item['description'],
              'place_id': item['place_id']
            });
          }
          setState(() {});
        }
      } else {
        // Handle API error
      }
    } catch (error) {
      // Handle error
    }
  }

  Future<bool> getDetailFromAPI(String placeId) async {
    var detailsUrl =
        'https://proxy.cors.sh/https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$kGoogleApiKey';
    try {
      Map<String, String> requestHeaders = {
        "x-requested-with": "XMLHttpRequest",
        'x-cors-api-key': 'temp_7cba4ae4f44b4fb09c829d32c07bdf66'
      };
      final response =
          await http.get(Uri.parse(detailsUrl), headers: requestHeaders);
      if (response.statusCode == 200) {
        final Map<String, dynamic> details =
            json.decode(response.body)["result"];

        // Extract city and postal code
        for (var component in details["address_components"]) {
          var types = component["types"];
          if (types.contains("locality")) {
            global.searchCity = component["long_name"];
            global.searchPriority = Constants.RESTAURANT_CITY;
          } else if (types.contains("postal_code")) {
            global.searchZip = component["long_name"];
            global.searchPriority = Constants.RESTAURANT_ZIP;
          }
        }
        global.searchFullAddress = details["formatted_address"];
        setState(() {
          location = details["formatted_address"];
        });
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    location = global.searchFullAddress;
  }

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
                    context.go('/');
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
                    context.go('/');
                  },
                  child: Image.asset(
                    Constants.IMG_LOGO,
                  ),
                ),
                if (screenSize.width > 1040)
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: screenSize.width / 8),
                        const Icon(Icons.location_on,
                            color: CustomColor.activeColor, size: 20),
                        InkWell(
                          onHover: (value) {
                            setState(() {
                              value
                                  ? _isHovering[7] = true
                                  : _isHovering[7] = false;
                            });
                          },
                          onTap: () async {
                            _showLocationDialog(context);
                            setState(() {});
                          },
                          child: Text(
                            location.length < 24
                                ? location
                                : '${location.substring(0, 22)}..',
                            style: TextStyle(
                              color: _isHovering[7]
                                  ? CustomColor.activeColor
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                InkWell(
                  onHover: (value) {
                    setState(() {
                      value ? _isHovering[1] = true : _isHovering[1] = false;
                    });
                  },
                  onTap: () {
                    context.go('/');
                  },
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
                    context.go('/all');
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
                  onTap: () {
                    context.go('/contact');
                  },
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
                        context.go('/login');
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
                        context.go('/choose');
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
                  onTap: () {
                    context.go('/');
                  },
                  child: Image.asset(
                    Constants.IMG_LOGO,
                  ),
                ),
                if (screenSize.width > 1140)
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: screenSize.width / 8),
                        const Icon(Icons.location_on,
                            color: CustomColor.activeColor, size: 20),
                        InkWell(
                          onHover: (value) {
                            setState(() {
                              value
                                  ? _isHovering[7] = true
                                  : _isHovering[7] = false;
                            });
                          },
                          onTap: () async {
                            _showLocationDialog(context);
                            setState(() {});
                          },
                          child: Text(
                            location.length < 24
                                ? location
                                : '${location.substring(0, 22)}..',
                            style: TextStyle(
                              color: _isHovering[7]
                                  ? CustomColor.activeColor
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                InkWell(
                  onHover: (value) {
                    setState(() {
                      value ? _isHovering[1] = true : _isHovering[1] = false;
                    });
                  },
                  onTap: () {
                    context.go('/');
                  },
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
                    context.go('/all');
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
                  onTap: () {
                    context.go('/contact');
                  },
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
                if (global.userRole == Constants.owner)
                  const SizedBox(width: 20),
                if (global.userRole == Constants.owner)
                  InkWell(
                    onHover: (value) {
                      setState(() {
                        value ? _isHovering[6] = true : _isHovering[6] = false;
                      });
                    },
                    onTap: () {
                      context.go('/subscription');
                    },
                    child: Text(
                      'Subscription',
                      style: TextStyle(
                        color: _isHovering[6]
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
                    onTap: () {
                      context.go('/favorite');
                    },
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
                  onTap: () {
                    context.go('/notification');
                  },
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
                      onPressed: () {
                        (global.userRole == Constants.customer)
                            ? context.go('/profile')
                            : context.go('/profile2');
                      },
                      child: Row(
                        children: [
                          const SizedBox(width: 2),
                          global.userAvatar.isEmpty
                              ? Image.asset(
                                  Constants.IMG_APPLE,
                                )
                              : Image.network(global.userAvatar),
                          const SizedBox(width: 2),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  global.userName,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  (global.userEmail.length < 18)
                                      ? global.userEmail
                                      : '${global.userEmail.substring(0, 15)}..',
                                  style: const TextStyle(
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

  Widget _listing(BuildContext context) {
    List<Widget> lists = locations.map((item) {
      return SizedBox(
          child: ListTile(
        tileColor: Colors.white,
        leading: const Icon(Icons.location_on, color: Colors.white),
        title: Text(
          item['description'],
          style: const TextStyle(color: Colors.white),
        ),
        onTap: () async {
          var success = getDetailFromAPI(item['place_id']);
          if (await success) {
            locations.clear();
            Navigator.of(context).pop();
          }
        },
      ));
    }).toList();

    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: lists),
    );
  }
}
