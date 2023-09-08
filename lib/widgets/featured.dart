import 'package:bestlocaleats/utils/colors.dart';
import 'package:bestlocaleats/utils/constants.dart';
import 'package:bestlocaleats/widgets/responsive.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeaturedSection extends StatefulWidget {
  const FeaturedSection({super.key});

  @override
  State<FeaturedSection> createState() => _FeaturedSectionState();
}

class _FeaturedSectionState extends State<FeaturedSection> {
  Map<String, dynamic> item = {
    "title": "Featured",
    "image": "assets/images/burger.png",
    "bio": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    "eventCaption": "More"
  };

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
        width: screenSize.width,
        height: 350,
        color: const Color(0xFFFFF9E5),
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 300,
                height: 300,
                decoration: const BoxDecoration(
                  color: CustomColor.activeColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.zero,
                      topRight: Radius.elliptical(30, 100),
                      bottomLeft: Radius.elliptical(100, 20),
                      bottomRight: Radius.circular(250)),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: CustomColor.activeColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(90),
                      topRight: Radius.elliptical(50, 20),
                      bottomLeft: Radius.elliptical(10, 50),
                      bottomRight: Radius.zero),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(5),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset(item["image"],
                      width: 300, height: 300, fit: BoxFit.contain),
                  const SizedBox(width: 30),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 50),
                        Text(item["title"].toString().toUpperCase(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25)),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: item["bio"],
                              style: GoogleFonts.poppins(
                                  color: CustomColor.textPrimaryColor,
                                  fontSize: 18),
                            )
                          ]),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: SizedBox(
                                height: 40, //height of button
                                width: 120, //width of button
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0, //elevation of button
                                      backgroundColor: CustomColor.primaryColor,
                                      shape: RoundedRectangleBorder(
                                          //to set border radius to button
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      padding: const EdgeInsets.all(
                                          5) //content padding inside button
                                      ),
                                  onPressed: () {},
                                  child: Text(
                                    item["eventCaption"]
                                        .toString()
                                        .toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ))),
                      ])
                ]))
          ],
        ));
  }
}
