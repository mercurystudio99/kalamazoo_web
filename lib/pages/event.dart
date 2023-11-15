import 'package:bestlocaleats/utils/colors.dart';
import 'package:bestlocaleats/utils/constants.dart';
import 'package:bestlocaleats/utils/globals.dart' as global;
import 'package:bestlocaleats/widgets/top_bar.dart';
import 'package:bestlocaleats/widgets/drawer.dart';
import 'package:bestlocaleats/widgets/bottom_bar.dart';
import 'package:bestlocaleats/widgets/responsive.dart';
import 'package:bestlocaleats/models/app_model.dart';

import 'dart:collection';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cached_network_image/cached_network_image.dart';

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year);
final kLastDay = DateTime(2050);

final kEvents = LinkedHashMap<DateTime, List<Event>>(
    equals: isSameDay, hashCode: getHashCode);

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  List<String> banners = [];
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime(kToday.year, kToday.month, kToday.day);
  DateTime? _selectedDay;
  late final Map<DateTime, List<Event>> _kEventSource = {};
  int carouselIndicatorCurrent = 0;

  void _getBanners() {
    AppModel().getEventBanners(
      onSuccess: (List<String> param) {
        banners = param;
        setState(() {});
      },
    );
  }

  void _getEvents(DateTime day) {
    AppModel().getEventForMonth(
      year: day.year.toString(),
      month: day.month.toString(),
      onSuccess: (List<Map<String, dynamic>> param) {
        _kEventSource.clear();
        for (var element in param) {
          var date = DateTime.fromMillisecondsSinceEpoch(
              element[Constants.EVENT_MILLISECONDS],
              isUtc: true);
          if (_kEventSource[date] != null) {
            _kEventSource[date]?.add(Event(
                eventTitle: element[Constants.EVENT_TITLE],
                eventDesc: element[Constants.EVENT_DESC],
                r: getRandomInt(0, 255),
                g: getRandomInt(0, 255),
                b: getRandomInt(0, 255)));
          } else {
            _kEventSource[date] = [
              Event(
                eventTitle: element[Constants.EVENT_TITLE],
                eventDesc: element[Constants.EVENT_DESC],
                r: getRandomInt(0, 255),
                g: getRandomInt(0, 255),
                b: getRandomInt(0, 255),
              )
            ];
          }
          kEvents.addAll(_kEventSource);
        }
        setState(() {});
      },
    );
  }

  int getRandomInt(int min, int max) {
    final random = Random();
    int number = min + random.nextInt(max - min + 1);
    return number;
  }

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  void initState() {
    super.initState();
    _getBanners();
    _getEvents(_focusedDay);
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    kEvents.clear();
    banners.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int topbarstatus = 1;
    if (global.userID.isNotEmpty) topbarstatus = 2;
    Size screenSize = MediaQuery.of(context).size;

    final List<Widget> bannerList = banners
        .map((item) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Center(
                      child: CachedNetworkImage(
                    imageUrl: item,
                    width: screenSize.width / 3 - Constants.mainPadding * 2,
                    height: 200,
                    fit: BoxFit.fitHeight,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ))),
            ))
        .toList();

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
              child: TopBarContents(1, topbarstatus, 'event', (param) {
                debugPrint('---');
              }),
            ),
      drawer: const MobileDrawer(),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(children: [
          SizedBox(
            width: double.infinity,
            height: 500,
            child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15),
                children: bannerList),
          ),
          TableCalendar<Event>(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            availableCalendarFormats: const {CalendarFormat.month: 'Month'},
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: _calendarFormat,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            headerStyle: HeaderStyle(
              headerMargin:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              titleCentered: true,
              titleTextStyle: const TextStyle(
                  color: CustomColor.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              leftChevronIcon:
                  const Icon(Icons.chevron_left, color: Colors.black45),
              rightChevronIcon:
                  const Icon(Icons.chevron_right, color: Colors.black45),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: CustomColor.primaryColor.withOpacity(0.15),
                    blurRadius: 30.0,
                  ),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
            ),
            calendarStyle: CalendarStyle(
              outsideDaysVisible: true,
              tablePadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              todayDecoration: BoxDecoration(
                  color: CustomColor.primaryColor.withOpacity(0.5),
                  shape: BoxShape.circle),
              selectedDecoration: const BoxDecoration(
                  color: CustomColor.primaryColor, shape: BoxShape.circle),
            ),
            onDaySelected: _onDaySelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
              _getEvents(_focusedDay);
            },
            calendarBuilders: CalendarBuilders(
              singleMarkerBuilder: (context, date, event) {
                Color color = Color.fromRGBO(event.r, event.g, event.b, 1);
                return Container(
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: color),
                  width: 7.0,
                  height: 7.0,
                  margin: const EdgeInsets.symmetric(horizontal: 1.5),
                );
              },
            ),
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            height: 200,
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    var splitted = value[index].toString().split('&@&');
                    return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: Constants.mainPadding,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(
                                int.parse(splitted[2]),
                                int.parse(splitted[3]),
                                int.parse(splitted[4]),
                                0.1)),
                        child: Row(children: [
                          Container(
                              width: 5,
                              height: 50,
                              color: Color.fromRGBO(
                                  int.parse(splitted[2]),
                                  int.parse(splitted[3]),
                                  int.parse(splitted[4]),
                                  1)),
                          const SizedBox(width: 20),
                          Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(splitted[0],
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                int.parse(splitted[2]),
                                                int.parse(splitted[3]),
                                                int.parse(splitted[4]),
                                                1))),
                                    Text(
                                      splitted[1],
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              int.parse(splitted[2]),
                                              int.parse(splitted[3]),
                                              int.parse(splitted[4]),
                                              1),
                                          fontWeight: FontWeight.bold),
                                    )
                                  ]))
                        ]));
                  },
                );
              },
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 40), child: BottomBar())
        ]),
      ),
    );
  }
}

class Event {
  final String eventTitle;
  final String eventDesc;
  final int r;
  final int g;
  final int b;

  Event({
    required this.eventTitle,
    required this.eventDesc,
    required this.r,
    required this.g,
    required this.b,
  });

  @override
  String toString() => '$eventTitle&@&$eventDesc&@&$r&@&$g&@&$b';
}
