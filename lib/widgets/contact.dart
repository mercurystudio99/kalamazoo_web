import 'package:bestlocaleats/utils/colors.dart';
import 'package:bestlocaleats/utils/constants.dart';
import 'package:flutter/material.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
        width: screenSize.width,
        height: 260,
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Image.asset(Constants.IMG_CONTACT_BG,
              width: screenSize.width * 0.6, height: 260, fit: BoxFit.cover),
          Expanded(
              child: Container(
                  color: CustomColor.activeColor,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                          Constants.mainPadding * 2,
                          30,
                          Constants.mainPadding,
                          30),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Text('Nonla Burger',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30)),
                            ),
                            Row(children: [
                              Container(
                                alignment: const Alignment(0, 0),
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: const Icon(
                                  Icons.phone_in_talk_outlined,
                                  color: CustomColor.textSecondaryColor,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Phone',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      '12345789',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w100,
                                          fontSize: 12.0,
                                          color:
                                              CustomColor.textSecondaryColor),
                                    ),
                                  ]),
                              const Spacer(),
                              Container(
                                alignment: const Alignment(0, 0),
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: const Icon(
                                  Icons.email_outlined,
                                  color: CustomColor.textSecondaryColor,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'E-mail',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'royaldine247@gmail.com',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w100,
                                          fontSize: 12.0,
                                          color:
                                              CustomColor.textSecondaryColor),
                                    ),
                                  ]),
                            ]),
                            const SizedBox(height: 20),
                            Row(children: [
                              Container(
                                alignment: const Alignment(0, 0),
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: const Icon(
                                  Icons.location_on_outlined,
                                  color: CustomColor.textSecondaryColor,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Location',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Kalamazoo, Michigan, USA',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w100,
                                          fontSize: 12.0,
                                          color:
                                              CustomColor.textSecondaryColor),
                                    ),
                                  ]),
                              const SizedBox(width: 40),
                              SizedBox(
                                  width: 80,
                                  height: 30,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              CustomColor.primaryColor,
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          shadowColor: CustomColor.primaryColor
                                              .withOpacity(0.5),
                                          padding: const EdgeInsets.all(5)),
                                      onPressed: () {},
                                      child: const Text('Open Map',
                                          style:
                                              TextStyle(color: Colors.white)))),
                            ]),
                          ]))))
        ]));
  }
}
