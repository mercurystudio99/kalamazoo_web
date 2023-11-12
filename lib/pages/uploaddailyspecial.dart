import 'package:bestlocaleats/utils/colors.dart';
import 'package:bestlocaleats/utils/constants.dart';
import 'package:bestlocaleats/utils/globals.dart' as global;
import 'package:bestlocaleats/widgets/top_bar.dart';
import 'package:bestlocaleats/widgets/drawer.dart';
import 'package:bestlocaleats/widgets/bottom_bar.dart';
import 'package:bestlocaleats/widgets/responsive.dart';
import 'package:bestlocaleats/models/app_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

const String title = "Daily Special";

class UploadDailySpecialPage extends StatefulWidget {
  const UploadDailySpecialPage({super.key});

  @override
  State<UploadDailySpecialPage> createState() => _UploadDailySpecialPageState();
}

class _UploadDailySpecialPageState extends State<UploadDailySpecialPage> {
  PlatformFile? _imageFile;
  final _storage = FirebaseStorage.instance;
  final _formKey = GlobalKey<FormState>();
  final _descController = TextEditingController();

  Future getImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    if (result == null) return;
    setState(() {
      _imageFile = result.files.first;
    });
  }

  void _saveImage(
      {required VoidCallback onCallback,
      required Function(String) onError}) async {
    if (_imageFile != null) {
      Uint8List? fileBytes = _imageFile!.bytes;
      String filename =
          DateTime.now().millisecondsSinceEpoch.toString() + _imageFile!.name;
      var snapshot = await _storage
          .ref()
          .child('dailyspecial/$filename')
          .putData(fileBytes!);

      var url = await snapshot.ref.getDownloadURL();

      AppModel().postDailySpecial(
          imageLink: url.toString(),
          desc: _descController.text.trim(),
          onSuccess: () {
            onCallback();
          });
    } else {
      onError("Please upload an image.");
    }
  }

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
              title,
              style: TextStyle(
                  color: CustomColor.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 38),
            )
          ],
        ),
      ),
    ];
    list.add(Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(
                  child: Column(children: [
                Stack(children: [
                  _imageFile != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Constants.mainPadding * 2),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            child: Image.memory(
                              Uint8List.fromList(_imageFile!.bytes!),
                              width: 300,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Constants.mainPadding * 2),
                          child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              child: Container(
                                width: 300,
                                height: 150,
                                color: CustomColor.textSecondaryColor,
                              ))),
                ]),
                const SizedBox(height: 20),
                SizedBox(
                    height: 40,
                    width: 160,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColor.primaryColor,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          shadowColor:
                              CustomColor.primaryColor.withOpacity(0.5),
                          padding: const EdgeInsets.all(5)),
                      onPressed: () {
                        getImage();
                      },
                      child: const Text(
                        'Upload New',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            letterSpacing: 1),
                      ),
                    )),
                const SizedBox(height: 20),
                SizedBox(
                    height: 40,
                    width: 160,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: CustomColor.activeColor),
                              borderRadius: BorderRadius.circular(4)),
                          padding: const EdgeInsets.all(5)),
                      onPressed: () {
                        setState(() {
                          _imageFile = null;
                        });
                      },
                      child: const Text(
                        'Delete photo',
                        style: TextStyle(
                            color: CustomColor.activeColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            letterSpacing: 1),
                      ),
                    )),
              ])),
              const SizedBox(height: 20),
              const Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Constants.mainPadding * 2, vertical: 10),
                  child: Text(
                    'Description',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 8, horizontal: Constants.mainPadding * 2),
                child: Stack(
                  children: [
                    Container(
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                        boxShadow: [
                          BoxShadow(
                              color: CustomColor.primaryColor.withOpacity(0.2),
                              blurRadius: 5,
                              spreadRadius: 1,
                              offset: const Offset(0, 0)),
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: _descController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Type here...',
                      ),
                      validator: (desc) {
                        if (desc?.isEmpty ?? true) {
                          return "Please enter a description.";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: Constants.mainPadding * 2),
                child: SizedBox(
                    height: 40,
                    width: screenSize.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColor.primaryColor,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          shadowColor:
                              CustomColor.primaryColor.withOpacity(0.5),
                          padding: const EdgeInsets.all(5)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _saveImage(onCallback: () {
                            setState(() {
                              _imageFile = null;
                              _descController.text = '';
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Successfully sent.')),
                            );
                          }, onError: (String text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(text)),
                            );
                          });
                        }
                      },
                      child: const Text(
                        'Send',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            letterSpacing: 1),
                      ),
                    )),
              ),
            ]))));

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
              child: TopBarContents(1, topbarstatus, 'uploaddailyspecial',
                  (param) {
                debugPrint('---');
              }),
            ),
      drawer: const MobileDrawer(),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(children: list),
      ),
    );
  }
}
