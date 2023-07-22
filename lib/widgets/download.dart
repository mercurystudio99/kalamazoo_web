import 'package:bestlocaleats/utils/constants.dart';
import 'package:bestlocaleats/utils/colors.dart';
import 'package:flutter/material.dart';

class DownloadSection extends StatefulWidget {
  const DownloadSection({super.key});

  @override
  State<DownloadSection> createState() => _DownloadSectionState();
}

class _DownloadSectionState extends State<DownloadSection> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double padding = (screenSize.width > 1000)
        ? Constants.mainPadding * 4
        : Constants.mainPadding * 2;
    return Stack(alignment: Alignment.bottomCenter, children: [
      SizedBox(width: screenSize.width, height: 530),
      Container(
        width: screenSize.width,
        color: CustomColor.primaryColor,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding, vertical: 80),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Download Mobile App',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      letterSpacing: 1,
                      color: Colors.white)),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: RichText(
                    text: const TextSpan(children: [
                      TextSpan(
                          text:
                              'Lorem Ipsum is simply dummy text of the printing and typesetting industry.\nLorem Ipsum has been the industry\'s standard dummy text ever\nLorem Ipsum is simply dummy text of the printing and typesetting industry.',
                          style: TextStyle(color: Colors.white)),
                    ]),
                  )),
              Row(children: [
                SizedBox(
                    width: 140,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          side: const BorderSide(width: 2, color: Colors.black),
                          backgroundColor: Colors.white,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          shadowColor:
                              CustomColor.primaryColor.withOpacity(0.5),
                          padding: const EdgeInsets.all(5)),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 2),
                          Image.asset(
                            Constants.IMG_APPLE1,
                          ),
                          const SizedBox(width: 8),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Available on',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                ),
                                Text(
                                  'App Store',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ])
                        ],
                      ),
                    )),
                const SizedBox(width: 25),
                SizedBox(
                    width: 140,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          side: const BorderSide(width: 2, color: Colors.black),
                          backgroundColor: Colors.white,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          shadowColor:
                              CustomColor.primaryColor.withOpacity(0.5),
                          padding: const EdgeInsets.all(5)),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 2),
                          Image.asset(
                            Constants.IMG_PLAYSTORE,
                            width: 25,
                          ),
                          const SizedBox(width: 8),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Get it on',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                ),
                                Text(
                                  'Google Play',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ])
                        ],
                      ),
                    )),
              ])
            ])),
      ),
      if (screenSize.width > 1000)
        Positioned(
            bottom: 20,
            right: Constants.mainPadding * 4,
            child: Image.asset(Constants.IMG_MOBILE))
    ]);
  }
}
