import 'package:bestlocaleats/utils/colors.dart';
import 'package:bestlocaleats/utils/constants.dart';
import 'package:bestlocaleats/utils/globals.dart' as global;
import 'package:bestlocaleats/widgets/top_bar.dart';
import 'package:bestlocaleats/widgets/drawer.dart';
import 'package:bestlocaleats/widgets/bottom_bar.dart';
import 'package:bestlocaleats/widgets/responsive.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const String policyTitle = "Privacy Policy";
const List<Map<String, dynamic>> policyList = [
  {
    "title": "1.	Scope",
    "description":
        "We care about your online privacy. This Privacy Policy (the “Policy”) describes our practices with respect to collection, use, disclosure and protection of your information when you visit https://FOOTIENATION.com/ (the “Site”) and FOOTIENATION (the “App”). The Site and the App are collectively referred to herein as the “Platform.”\n\n"
            "Note that this Policy is only valid on our Platform, not any third party networks, even if they are referenced on our Platform. It is your responsibility to familiarize yourself and comply with any relevant third party networks.\n\n"
            "If you visit our Platform, that signifies your legal acceptance of the Policy. You must exit the Platform if you do not agree with any provision(s) of this Privacy Policy. We reserve the right to change this Policy at any time at our sole discretion. The effective date of the last update is at the top of this page, so visit it occasionally to see if there are any changes."
  },
  {
    "title": "2.	Collection of User Data",
    "description": "Here are the types of information regarding the Platform users we may collect:\n\n"
        "a.    Personal information such as name, email, mailing address, phone number collected through user registration or other forms.\n\n"
        "b.	   Payment Information:\n\n"
        "    •    Stripe.\n"
        "    •    PayPal.\n\n"
        "c.	   Communications: if you contact us for any reason, we will receive whatever information you voluntarily provide (e.g., your feedback, ratings and reviews).\n\n"
        "d.	   Your Devices: device identifiers, phone manufacturer and carrier, browser, IP address, operating system version, mobile advertising identifiers, application installations.\n\n"
        "e.	   Platform Interaction: we see what content our Platform users access, when and how they interact with the Platform content/pages."
  },
  {
    "title": "3.	Use of Data",
    "description": "We use the collected data for the following purposes:\n\n"
        "a.	   To provide the services and/or information that you have asked for.\n\n"
        "b.	   To respond to a court order, regulatory request or legal process.\n\n"
        "c.	   To enforce our rights, carry out our obligations, prevent fraud, facilitate disputes between users.\n\n"
        "d.	   To accomplish any other purpose for which the information was provided.\n\n"
        "e.	   To aggregate, anonymize, and potentially license or sell this data to third parties, ensuring that individual users cannot be personally identified."
  },
  {
    "title": "4.	Disclosure of Data",
    "description": "In addition to sharing your data as described above, we may disclose the collected personal information as follows:\n\n"
        "a.	   In case there is a sale, merger or other transfer in the ownership of our Platform, the successor will receive personal information about our Platform users along with the assets transferred.\n\n"
        "b.	   If we decide that disclosure is appropriate to protect the property, safety, rights of the Platform, its users or the public.\n\n"
        "c.	   Aggregated, anonymized information that does not identify any particular user can be disclosed without restriction.\n\n"
        "d.	   We may license or sell aggregated, anonymized data that does not identify any individual user. Before any such transaction, we will conduct due diligence on potential buyers to ensure they have a legitimate purpose for the data and are compliant with data protection regulations."
  },
  {
    "title": "5.	Cookie Policy",
    "description": "Cookies are small bits of text data placed on your device when you visit sites. Cookies record data about your activity, such as which pages you view and what you click on. Cookies assist our Platform to recognize your device when you return. For example, cookies can help us to remember your preferences, username, analyze the performance of our Platform and recommend content that may be most relevant to your interests.\n\n"
        "    Here are the reasons we may use cookies:\n\n"
        "a.	   Analytics. This type of cookies shows us which pages users view, which links are popular, etc. These cookies only provide anonymized information that does not identify anybody personally. This information is then bundled with the similar information from the other users, so that we can analyze the general usage patterns.\n\n"
        "b.	   Essential cookies. These are necessary to provide the services that you have asked for. Without these essential cookies, our Platform would not be able to operate. They are necessary to enable users to navigate through the Platform and use its main features. E.g., essential cookies identify registered users so that they can access member-only areas of the site. Essential cookies keep users logged in. If a subscriber disables essential cookies, that subscriber won’t be able to get to all of the content that a subscription entitles them to. These cookies don't collect information that could be utilized for the purposes of marketing or figuring out what places on the internet you have visited.\n\n"
        "c.	   To improve your browsing experience. This type of cookies enables the site to remember users’ preferences and settings, such as geographic region or language. They can also be used to restrict the number of times an ad is shown, to remember which forms you have already filled in, so that you don’t have to do it again.\n\n"
        "d.	   To implement tracking technology on our Platform. This tracking does not use your personal information; it uses deidentified data (i.e., data that cannot be tied specifically to you). We will not combine this data with your other personal information without your prior express permission.\n\n"
        "There is a way to turn off cookies by going to your browser’s Help or Settings menu. However, keep in mind that disabling cookies may limit your use of the Platform and/or delay or affect the way in which it operates."
  },
  {
    "title": "6.	Push Notifications",
    "description":
        "Restaurants that purchase advertising with us may send you push notifications to promote daily specials, events, and other announcements. These messages will be sent directly from the restaurant, not from FOOTIENATION. You can opt-out of receiving a restaurant's push notifications by adjusting the settings within their profile page on our mobile app.\n\n"
            "We will provide opt-out instructions at the bottom of any push notification messages as required by the CAN-SPAM Act. Please note that opting out of a specific restaurant's notifications does not opt you out of all push notifications. You will continue receiving notifications from other restaurants unless you individually opt out of their messages.\n\n"
            "Restaurants must agree to comply with the CAN-SPAM Act and other applicable laws when sending push notifications through our platform. We reserve the right to terminate any restaurant's messaging capabilities if they violate anti-spam regulations."
  },
  {
    "title": "7.	Data Security",
    "description":
        "Only our administrators are allowed to access our Platform’s password-protected server where your personal information is stored.  We utilize SSL. However, any transmission of information over the Internet has its inherent risks, so we cannot guarantee the absolute security of your personal information. Transmit personal information over the Internet at your own risk. We shall not be liable for circumvention of security measures or privacy settings on the Platform. It is your responsibility to keep your login credentials, if any, confidential."
  },
  {
    "title": "8.	Children’s Privacy",
    "description":
        "We do not knowingly collect any personal information about children under the age of 13. Our Platform is not directed to children under the age of 13. If we become aware that a child under 13 has provided any personal info, it will be erased from our database as soon as reasonably possible, except when we need to keep that information for legal purposes or to notify a parent or guardian. However, portions of this data may remain in back-up archives or web logs even after we erase it from our databases. If a parent or guardian believes that a child has sent us personal information, send us an e-mail."
  },
  {
    "title": "9.	Users’ Rights, CCPA",
    "description": "a.    We will not share your personal information with third parties for their direct marketing purposes to the extent it is forbidden by law. If our practices change, we will do so in accordance with applicable laws and will notify you in advance. California law requires that operators of online services disclose how they respond to a Do Not Track signal. Some browsers have incorporated “Do Not Track” features. Most of these features, when turned on, send a signal or preference to the online service that a user visits, indicating that the user does not wish to be tracked.  At this time we do not respond to Do Not Track signal.\n\n"
        "b.	   You can request disclosure of your information collected by us by writing to the email at the end of this Policy. We will then provide the requested information, its sources and purposes of use, in a portable and easily accessible format within 45 days of the request.\n\n"
        "c.	   You have the right to request deletion of your personal information from our systems by submitting a request to the email at the end of this Policy.\n\n"
        "d.	   You have the right to nondiscrimination for exercising your rights. That means you cannot be denied goods or services, charged different prices, or provided different quality of goods/services for asserting your legal rights.\n\n"
        "e.	   You have the right to opt-out of the sale of your personal information. If you exercise this right, we will refrain from selling your personal information unless you subsequently provide express authorization for the sale of your personal information."
  },
  {
    "title": "10.	International Transfer",
    "description":
        "We process your personal information in the Unites States.  This is where it will be transferred to in case you are located somewhere else. By submitting any personal information to us, you agree to its transfer to and processing in the Unites States."
  },
  {
    "title": "11.	EU Users’ Rights",
    "description": "This section of our Privacy Policy applies to the users of our Platform in the European Union. We would like to inform you about your GDPR rights and how we safeguard them.\n\n"
        "a.	   Your GDPR rights to be informed, to access, rectify, erase or restrict the processing of your personal information. You have the right to obtain free information about what personal data we have obtained about you, where it is stored, for how long, for what purposes it is used, to whom it was disclosed. You have the right to have us, without undue delay, rectify of inaccurate personal data concerning you. That means you can request we change your personal data in our records, or have your incomplete personal data completed. You have the “right to be forgotten,” i.e. to have us delete your personal information, without undue delay, if the data is no longer necessary in relation to the purposes for which it was collected. However, GDPR gives us the right to refuse erasure if we can demonstrate compelling legitimate grounds for keeping your information.\n\n"
        "b.	   GDPR gives you the right to restrict processing if any of the following applies:\n\n"
        "    i.  If you contest the accuracy of your personal data, we will restrict processing it for a period enabling us to verify its accuracy.\n"
        "    ii.  The processing is unlawful and you oppose its erasure and request instead the restriction of its use.\n"
        "    iii.  We no longer need your personal data for the purposes of the processing, but you require us to restrict processing for the establishment, exercise or defense of legal claims.\n"
        "    iv.  You have objected to processing pursuant to Article 21(1) of the GDPR pending the verification whether our legitimate grounds override yours.\n\n"
        "c.	   Right to data portability. Upon request, we will provide you your personal data in our possession, in a structured, commonly used and machine-readable format. You have the right to transmit that data to another controller if doing so does not adversely affect the rights and freedoms of others.\n\n"
        "d.	   Right to object. You can object, on grounds relating your particular situation, at any time, to processing of your personal information, if based on point (e) or (f) of Article 6(1) of the GDPR.  We will then have to stop processing, unless we can demonstrate compelling legitimate grounds for the processing. If you object to the processing for direct marketing purposes, we will have to stop processing for these purposes.\n\n"
        "e.	   Right to withdraw consent. GDPR grants you the right to withdraw your earlier given consent, if any, to processing of your personal data at any time.\n\n"
        "f.	   Rights related to automated decision making. As a responsible business, we do not rely on any automated decision making, such as profiling."
  },
  {
    "title": "12.	Accessing and Correcting Your Personal Information",
    "description":
        "You can view and edit some of your account information yourself after logging in. If you terminate account, we may retain some information for as long as necessary to evaluate Platform usage, troubleshoot issues, resolve disputes and collect any fees owed.  If you have any questions or wish to ask to access, modify or delete any of your personal data on our Platform, please contact us. Note that we can deny your request if we think it would violate any law or cause the information to be incorrect.\n\n"
            "______@_______.com"
  }
];

class PolicyPage extends StatefulWidget {
  const PolicyPage({super.key});

  @override
  State<PolicyPage> createState() => _PolicyPageState();
}

class _PolicyPageState extends State<PolicyPage> {
  @override
  Widget build(BuildContext context) {
    int topbarstatus = 1;
    if (global.userID.isNotEmpty) topbarstatus = 2;
    Size screenSize = MediaQuery.of(context).size;

    List<Widget> list = [
      Padding(
          padding: EdgeInsets.only(
              top: ResponsiveWidget.isSmallScreen(context) ? 80 : 100)),
      Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Constants.mainPadding, vertical: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              policyTitle,
              style: TextStyle(
                  color: CustomColor.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 38),
            )
          ],
        ),
      ),
    ];
    for (var element in policyList) {
      list.add(Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.mainPadding, vertical: 5),
          child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                element['title'],
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ))));
      list.add(Padding(
          padding: (element['title'].toString().isNotEmpty)
              ? const EdgeInsets.symmetric(horizontal: Constants.mainPadding)
              : const EdgeInsets.only(
                  left: Constants.mainPadding * 2,
                  right: Constants.mainPadding),
          child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                element['description'],
                style: const TextStyle(fontSize: 18),
              ))));
      list.add(const Padding(
          padding: EdgeInsets.symmetric(horizontal: Constants.mainPadding),
          child: SizedBox(height: 30)));
    }
    list.add(
        const Padding(padding: EdgeInsets.only(top: 40), child: BottomBar()));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              // for smaller screen sizes
              backgroundColor: Colors.black.withOpacity(1),
              elevation: 0,
              title: InkWell(
                onHover: (value) {},
                onTap: () {
                  context.go('/');
                },
                child: Image.asset(
                  Constants.IMG_LOGO,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ))
          : PreferredSize(
              // for larger & medium screen sizes
              preferredSize: Size(screenSize.width, 1000),
              child: TopBarContents(1, topbarstatus),
            ),
      drawer: const MobileDrawer(),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(children: list),
      ),
    );
  }
}
