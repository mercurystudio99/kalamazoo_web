import 'package:bestlocaleats/utils/constants.dart';
import 'package:bestlocaleats/utils/router.dart';
import 'package:bestlocaleats/widgets/top_bar.dart';
import 'package:bestlocaleats/widgets/responsive.dart';

import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  final List _isHovering = [
    false, // 0: logo
  ];

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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: const TopBarContents(0, 0),
      ),
      body: const SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Center(
              child: Text('404 Error!',
                  style:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold)))),
    );
  }

  Widget _mobile() {
    return Scaffold(
      appBar: AppBar(
          leading: Container(),
          backgroundColor: Colors.black,
          elevation: 0,
          title: InkWell(
            onHover: (value) {
              setState(() {
                value ? _isHovering[0] = true : _isHovering[0] = false;
              });
            },
            onTap: () {
              NavigationRouter.switchToHomePage(context);
            },
            child: Image.asset(
              Constants.IMG_LOGO,
              width: 100,
              fit: BoxFit.cover,
            ),
          )),
      body: const SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Constants.mainPadding, vertical: 20),
            child: Center(
                child: Text('404 Error!',
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)))),
      ),
    );
  }
}
