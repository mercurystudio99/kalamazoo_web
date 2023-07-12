import 'package:bestlocaleats/widgets/top_bar.dart';
import 'package:bestlocaleats/widgets/drawer.dart';
import 'package:bestlocaleats/widgets/bottom_bar.dart';
import 'package:bestlocaleats/widgets/responsive.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const double _opacity = 0;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
              // for smaller screen sizes
              backgroundColor: Colors.transparent,
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
              child: const TopBarContents(_opacity),
            ),
      drawer: MobileDrawer(),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(children: [
          Stack(
            children: [
              Container(
                // image below the top bar
                child: SizedBox(
                  height: screenSize.height * 0.45,
                  width: screenSize.width,
                  child: Image.asset(
                    'assets/images/cover.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                heightFactor: 1,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: screenSize.height * 0.40,
                    left: screenSize.width / 5,
                    right: screenSize.width / 5,
                  ),
                  child: Card(// floating quick access bar
                      // ...
                      ),
                ),
              )
            ],
          ),
          Container(
            width: screenSize.width,
            height: screenSize.height,
            color: Colors.blue.shade100,
          ),
          const BottomBar(),
        ]),
      ),
    );
  }
}
