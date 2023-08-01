import 'package:bestlocaleats/widgets/responsive.dart';
import 'package:bestlocaleats/widgets/bottom_bar_column.dart';
import 'package:bestlocaleats/utils/constants.dart';
import 'package:bestlocaleats/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isSmallScreen(context)) {
      return _mobile();
    } else {
      return _desktop();
    }
  }

  Widget _desktop() {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Constants.mainPadding, vertical: 70),
      color: CustomColor.primaryColor,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onHover: (value) {},
                    onTap: () {
                      context.go('/');
                    },
                    child: Image.asset(
                      Constants.IMG_LOGO,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                            text:
                                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                            style: TextStyle(color: Colors.white)),
                      ]),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Image.asset(Constants.IMG_FACEBOOK, width: 40),
                    const SizedBox(width: 30),
                    Image.asset(Constants.IMG_APPLE, width: 40),
                    const SizedBox(width: 30),
                    Image.asset(Constants.IMG_GOOGLE, width: 40),
                    const SizedBox(width: 30),
                  ]),
                ],
              )),
              const Expanded(
                  child: BottomBarColumn(
                'Our Menu',
                'Home',
                'All restaurant',
                'Contact us',
                'Favorites',
              )),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Newsletter',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                            text:
                                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                            style: TextStyle(color: Colors.white)),
                      ]),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: SizedBox(
                        width: screenSize.width * 0.25,
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email_outlined,
                                color: Colors.white),
                            suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: InkWell(
                                    onHover: (value) {},
                                    onTap: () {},
                                    child: Image.asset(
                                      Constants.IMG_ARROW,
                                      width: 60,
                                    ))),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            filled: true,
                            fillColor: Colors.transparent,
                            hintText: 'Your Mail Address',
                            hintStyle: const TextStyle(
                                color: CustomColor.textSecondaryColor),
                          ),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                            text: 'T: 0123456789',
                            style: TextStyle(color: Colors.white)),
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                            text: 'E: bestlocaleats@gmail.com',
                            style: TextStyle(color: Colors.white)),
                      ]),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ],
      ),
    );
  }

  Widget _mobile() {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Constants.mainPadding, vertical: 70),
      color: CustomColor.primaryColor,
      child: Column(
        children: [
          SizedBox(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onHover: (value) {},
                onTap: () {
                  context.go('/');
                },
                child: Image.asset(
                  Constants.IMG_LOGO,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: RichText(
                  text: const TextSpan(children: [
                    TextSpan(
                        text:
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                        style: TextStyle(color: Colors.white)),
                  ]),
                ),
              ),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(Constants.IMG_FACEBOOK, width: 40),
                const SizedBox(width: 30),
                Image.asset(Constants.IMG_APPLE, width: 40),
                const SizedBox(width: 30),
                Image.asset(Constants.IMG_GOOGLE, width: 40),
                const SizedBox(width: 30),
              ]),
            ],
          )),
          const SizedBox(height: 50),
          const SizedBox(
              child: BottomBarColumn(
            'Our Menu',
            'Home',
            'All restaurant',
            'Contact us',
            'Favorites',
          )),
          const SizedBox(height: 50),
          SizedBox(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Newsletter',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: RichText(
                  text: const TextSpan(children: [
                    TextSpan(
                        text:
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                        style: TextStyle(color: Colors.white)),
                  ]),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: SizedBox(
                    width: screenSize.width * 0.7,
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email_outlined,
                            color: Colors.white),
                        suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: InkWell(
                                onHover: (value) {},
                                onTap: () {},
                                child: Image.asset(
                                  Constants.IMG_ARROW,
                                  width: 60,
                                ))),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: 'Your Mail Address',
                        hintStyle: const TextStyle(
                            color: CustomColor.textSecondaryColor),
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: RichText(
                  text: const TextSpan(children: [
                    TextSpan(
                        text: 'T: 0123456789',
                        style: TextStyle(color: Colors.white)),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: RichText(
                  text: const TextSpan(children: [
                    TextSpan(
                        text: 'E: bestlocaleats@gmail.com',
                        style: TextStyle(color: Colors.white)),
                  ]),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
