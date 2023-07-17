import 'package:bestlocaleats/utils/constants.dart';
import 'package:flutter/material.dart';

class LogosSection extends StatefulWidget {
  const LogosSection({super.key});

  @override
  State<LogosSection> createState() => _LogosSectionState();
}

class _LogosSectionState extends State<LogosSection> {
  final List _isHovering = [
    false,
  ];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Constants.mainPadding, vertical: 100),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          InkWell(
              onHover: (value) {
                setState(() {
                  value ? _isHovering[0] = true : _isHovering[0] = false;
                });
              },
              onTap: () {},
              child: Image.asset(Constants.IMG_BRAND1,
                  width: (screenSize.width - Constants.mainPadding * 2) / 6)),
          InkWell(
              onHover: (value) {
                setState(() {
                  value ? _isHovering[0] = true : _isHovering[0] = false;
                });
              },
              onTap: () {},
              child: Image.asset(Constants.IMG_BRAND1,
                  width: (screenSize.width - Constants.mainPadding * 2) / 6)),
          InkWell(
              onHover: (value) {
                setState(() {
                  value ? _isHovering[0] = true : _isHovering[0] = false;
                });
              },
              onTap: () {},
              child: Image.asset(Constants.IMG_BRAND1,
                  width: (screenSize.width - Constants.mainPadding * 2) / 6)),
          InkWell(
              onHover: (value) {
                setState(() {
                  value ? _isHovering[0] = true : _isHovering[0] = false;
                });
              },
              onTap: () {},
              child: Image.asset(Constants.IMG_BRAND1,
                  width: (screenSize.width - Constants.mainPadding * 2) / 6)),
          InkWell(
              onHover: (value) {
                setState(() {
                  value ? _isHovering[0] = true : _isHovering[0] = false;
                });
              },
              onTap: () {},
              child: Image.asset(Constants.IMG_BRAND1,
                  width: (screenSize.width - Constants.mainPadding * 2) / 6)),
          InkWell(
              onHover: (value) {
                setState(() {
                  value ? _isHovering[0] = true : _isHovering[0] = false;
                });
              },
              onTap: () {},
              child: Image.asset(Constants.IMG_BRAND1,
                  width: (screenSize.width - Constants.mainPadding * 2) / 6)),
        ]));
  }
}
