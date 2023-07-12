import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List<dynamic> _isHovering = [false];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: Container(
          color: Colors.blue.withOpacity(0.5),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Text('EXPLORE'),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        onHover: (value) {
                          setState(() {
                            _isHovering[0] = value;
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Discover',
                              style: TextStyle(
                                color: _isHovering[0]
                                    ? Colors.blue.shade200
                                    : Colors.white,
                              ),
                            ),
                            SizedBox(height: 5),
                            // For showing an underline on hover
                            Visibility(
                              maintainAnimation: true,
                              maintainState: true,
                              maintainSize: true,
                              visible: _isHovering[0],
                              child: Container(
                                height: 2,
                                width: 20,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: screenSize.width / 20),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'Contact Us',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(
                  width: screenSize.width / 50,
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
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
    );
  }
}
