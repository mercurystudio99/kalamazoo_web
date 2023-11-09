library globals;

import 'package:bestlocaleats/utils/constants.dart';

String userID = "";
String userName = "";
String userEmail = "";
String userAvatar = "";
String userPass = "";
String userRole = "";
String userSubscription = "";
List<dynamic> userFavourites = [];
List<dynamic> ownerAmenities = [];
String ownerBusinessID = "";
String ownerBusinessType = "";

String restaurantType = Constants.C_RESTAURANTS;
String restaurantID = "";
double restaurantRating = 0;
String menuCategory = "";
String menuID = "";
String listTarget = '';

String searchFullAddress = "Kalamazoo, MI, USA";
String searchCity = "Kalamazoo";
String searchZip = "";
String searchPriority = Constants.RESTAURANT_CITY;
String searchKeyword = '';
String searchText = "";
List<dynamic> searchAmenities = [];
int searchDistanceRange = 0;
String searchOpen = 'all';

double latitude = 0;
double longitude = 0;

List<Map<String, dynamic>> notifications = [];
