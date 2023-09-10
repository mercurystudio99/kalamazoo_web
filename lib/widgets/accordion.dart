import 'package:bestlocaleats/utils/colors.dart';
import 'package:flutter/material.dart';

class Accordion extends StatefulWidget {
  final String title;
  final String content;

  const Accordion({Key? key, required this.title, required this.content})
      : super(key: key);
  @override
  State<Accordion> createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  // Show or hide the content
  bool _showContent = false;
  final List _isHovering = [
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(children: [
        // The title
        ListTile(
          title: Text(
            widget.title,
            style: const TextStyle(
                color: CustomColor.textPrimaryColor,
                fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
            icon: Icon(_showContent
                ? Icons.keyboard_arrow_down
                : Icons.keyboard_arrow_right),
            onPressed: () {
              setState(() {
                _showContent = !_showContent;
              });
            },
          ),
        ),
        // Show or hide the content based on the state
        _showContent
            ? Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: InkWell(
                              onHover: (value) {
                                setState(() {
                                  value
                                      ? _isHovering[0] = true
                                      : _isHovering[0] = false;
                                });
                              },
                              onTap: () {},
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(widget.content,
                                      style: TextStyle(
                                        color: _isHovering[0]
                                            ? CustomColor.activeColor
                                            : CustomColor.textPrimaryColor,
                                      ))))),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: InkWell(
                              onHover: (value) {
                                setState(() {
                                  value
                                      ? _isHovering[1] = true
                                      : _isHovering[1] = false;
                                });
                              },
                              onTap: () {},
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(widget.content,
                                      style: TextStyle(
                                        color: _isHovering[1]
                                            ? CustomColor.activeColor
                                            : CustomColor.textPrimaryColor,
                                      ))))),
                    ]),
              )
            : Container()
      ]),
    );
  }
}
