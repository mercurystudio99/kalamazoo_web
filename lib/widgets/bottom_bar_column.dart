import 'package:flutter/material.dart';
import 'package:bestlocaleats/utils/colors.dart';
import 'package:bestlocaleats/utils/router.dart';

class BottomBarColumn extends StatefulWidget {
  final String heading;
  final String s1;
  final String s2;
  final String s3;
  final String s4;

  const BottomBarColumn(this.heading, this.s1, this.s2, this.s3, this.s4,
      {super.key});

  @override
  State<BottomBarColumn> createState() => _BottomBarColumnState();
}

class _BottomBarColumnState extends State<BottomBarColumn> {
  final List _isHovering = [
    false, // 0: home
    false, // 1: all restaurant
    false, // 2: contact us
    false, // 3: favorite
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.heading,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        InkWell(
          onHover: (value) {
            setState(() {
              value ? _isHovering[0] = true : _isHovering[0] = false;
            });
          },
          onTap: () {
            NavigationRouter.switchToHomePage(context);
          },
          child: Text(
            widget.s1,
            style: TextStyle(
                color: _isHovering[0] ? CustomColor.activeColor : Colors.white,
                fontSize: 14,
                letterSpacing: 1),
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onHover: (value) {
            setState(() {
              value ? _isHovering[1] = true : _isHovering[1] = false;
            });
          },
          onTap: () {
            NavigationRouter.switchToAllRestaurantPage(context);
          },
          child: Text(
            widget.s2,
            style: TextStyle(
                color: _isHovering[1] ? CustomColor.activeColor : Colors.white,
                fontSize: 14,
                letterSpacing: 1),
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onHover: (value) {
            setState(() {
              value ? _isHovering[2] = true : _isHovering[2] = false;
            });
          },
          onTap: () {
            NavigationRouter.switchToContactPage(context);
          },
          child: Text(
            widget.s3,
            style: TextStyle(
                color: _isHovering[2] ? CustomColor.activeColor : Colors.white,
                fontSize: 14,
                letterSpacing: 1),
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onHover: (value) {
            setState(() {
              value ? _isHovering[3] = true : _isHovering[3] = false;
            });
          },
          onTap: () {
            NavigationRouter.switchToFavoritePage(context);
          },
          child: Text(
            widget.s4,
            style: TextStyle(
                color: _isHovering[3] ? CustomColor.activeColor : Colors.white,
                fontSize: 14,
                letterSpacing: 1),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
