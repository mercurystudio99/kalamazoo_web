// ignore_for_file: constant_identifier_names

class Constants {
  static const int startHour = 8;
  static const int startMinute = 0;
  static const int endHour = 21;
  static const int endMinute = 0;

  static const String monday = "Monday";
  static const String tuesday = "Tuesday";
  static const String wednesday = "Wednesday";
  static const String thursday = "Thursday";
  static const String friday = "Friday";
  static const String saturday = "Saturday";
  static const String sunday = "Sunday";

  static const String logo = "BESTLOCALEATS";
  static const double mainPadding = 32;
  static const String owner = "owner";
  static const String customer = "customer";

  static const String C_APPINFO = "AppInfo";
  static const String C_USERS = "Users";
  static const String C_RESTAURANTS = "Restaurants";
  static const String C_WINERIES = "Wineries";
  static const String C_BREWERIES = "Breweries";
  static const String C_AMENITIES = "Amenities";
  static const String C_TOPMENU = "TopMenus";
  static const String C_CATEGORIES = "Categories";
  static const String C_DAILYSPECIAL = "DailySpecial";
  static const String C_EVENTS = "Events";
  static const String C_C_MENU = "Menu";

  static const String USER_ID = "user_id";
  static const String USER_PROFILE_PHOTO = "user_photo_link";
  static const String USER_FULLNAME = "user_fullname";
  static const String USER_BUSINESSNAME = "user_businessname";
  static const String USER_GENDER = "user_gender";
  static const String USER_BIRTH_DAY = "user_birth_day";
  static const String USER_BIRTH_MONTH = "user_birth_month";
  static const String USER_BIRTH_YEAR = "user_birth_year";
  static const String USER_PHONE_NUMBER = "user_phone_number";
  static const String USER_EMAIL = "user_email";
  static const String USER_PASS = "user_pass";
  static const String USER_LOCATION = "user_location";
  static const String USER_FAVOURITIES = "user_favourites";
  static const String USER_AMENITIES = "user_amenities";
  static const String USER_ROLE = "user_role";
  static const String USER_STATUS = "user_status";
  static const String USER_IS_VERIFIED = "user_is_verified";
  static const String USER_REG_DATE = "user_reg_date";
  static const String USER_LAST_LOGIN = "user_last_login";
  static const String USER_RESTAURANT_ID = "user_restaurant_id";
  static const String USER_RESTAURANT_SERVICE = "user_restaurant_service";
  static const String USER_SUBSCRIPTION_DATE = "user_subscription_date";
  static const String USER_SUBSCRIPTION_COUNT = "user_subscription_count";
  static const String USER_SUBSCRIPTION_TYPE = "user_subscription_type";
  static const String USER_FCM_TOKEN = "user_fcm_token";

  static const String RESTAURANT_ID = "id";
  static const String RESTAURANT_ADDRESS = "address";
  static const String RESTAURANT_BRAND = "brand";
  static const String RESTAURANT_BUSINESSNAME = "businessName";
  static const String RESTAURANT_CITY = "city";
  static const String RESTAURANT_EMAIL = "email";
  static const String RESTAURANT_GEOLOCATION = "geolocation";
  static const String RESTAURANT_PHONE = "phone";
  static const String RESTAURANT_IMAGE = "imageLink";
  static const String RESTAURANT_STATE = "state";
  static const String RESTAURANT_URL = "url";
  static const String RESTAURANT_ZIP = "zip";
  static const String RESTAURANT_RATING = "rating";
  static const String RESTAURANT_SCHEDULE = "schedule";
  static const String RESTAURANT_SCHEDULE_DAY = "day";
  static const String RESTAURANT_SCHEDULE_STARTHOUR = "startHour";
  static const String RESTAURANT_SCHEDULE_STARTMINUTE = "startMinute";
  static const String RESTAURANT_SCHEDULE_ENDHOUR = "endHour";
  static const String RESTAURANT_SCHEDULE_ENDMINUTE = "endMinute";
  static const String RESTAURANT_SCHEDULE_ISWORKINGDAY = "isWorkingDay";
  static const String RESTAURANT_AMENITIES = "amenities";
  static const String RESTAURANT_DISCOUNT = "discount";
  static const String RESTAURANT_MINCOST = "mincost";
  static const String RESTAURANT_CATEGORY = "category";

  static const String MENU_ID = "id";
  static const String MENU_NAME = "name";
  static const String MENU_PRICE = "price";
  static const String MENU_DESCRIPTION = "description";
  static const String MENU_PHOTO = "photoLink";
  static const String MENU_CATEGORY = "category";

  static const String AMENITY_ID = "id";
  static const String AMENITY_NAME = "name";
  static const String AMENITY_LOGO = "logo";
  static const String AMENITY_TYPE = "type";

  static const String TOPMENU_ID = "id";
  static const String TOPMENU_NAME = "name";
  static const String TOPMENU_IMAGE = "imgName";

  static const String CATEGORY_ID = "id";
  static const String CATEGORY_NAME = "name";

  static const String DAILYSPECIAL_ID = "id";
  static const String DAILYSPECIAL_IMAGE_LINK = "image_link";
  static const String DAILYSPECIAL_DESC = "description";
  static const String DAILYSPECIAL_ACTIVE = "active";
  static const String DAILYSPECIAL_BUSINESS_ID = "business_id";
  static const String DAILYSPECIAL_BUSINESS_TYPE = "business_type";

  static const String EVENT_ID = "id";
  static const String EVENT_TITLE = "title";
  static const String EVENT_DESC = "description";
  static const String EVENT_YEAR = "year";
  static const String EVENT_MONTH = "month";
  static const String EVENT_DATE = "date";
  static const String EVENT_MILLISECONDS = "milliseconds";

  // images
  static const String imagePath = "assets/images/";
  static const String IMG_AMENITIES = "${imagePath}amenities/amenities.png";
  static const String IMG_CUSTOMER = "${imagePath}user.png";
  static const String IMG_OWNER = "${imagePath}shopkeeper.png";
  static const String IMG_LOGO = "${imagePath}logo.png";
  static const String IMG_APPLE = "${imagePath}apple.png";
  static const String IMG_GOOGLE = "${imagePath}google.png";
  static const String IMG_FACEBOOK = "${imagePath}facebook.png";
  static const String IMG_APPLE1 = "${imagePath}apple1.png";
  static const String IMG_GOOGLE1 = "${imagePath}google1.png";
  static const String IMG_FACEBOOK1 = "${imagePath}facebook1.png";
  static const String IMG_START = "${imagePath}start.png";
  static const String IMG_ARROW = "${imagePath}arrow.png";
  static const String IMG_MOBILE = "${imagePath}mobile.png";
  static const String IMG_PLAYSTORE = "${imagePath}playstore.png";
  static const String IMG_SLIDER_HAMBURGER = "${imagePath}slider_hamburger.png";
  static const String IMG_ELLIPSE1 = "${imagePath}ellipse1.png";
  static const String IMG_ABOUT_BANNER = "${imagePath}about_banner.png";
  static const String IMG_ABOUT = "${imagePath}about.png";
  static const String IMG_GROUP = "${imagePath}group.png";
  static const String IMG_DISH = "${imagePath}dish.png";
  static const String SVG_DISH = "${imagePath}dish.svg";
  static const String IMG_CONTACT_BG = "${imagePath}contact_background.png";
  static const String IMG_FOOD_BG = "${imagePath}food_background.png";
  static const String IMG_CONTACT = "${imagePath}contact.png";
  static const String IMG_PROFILE_BG = "${imagePath}profile_background.png";
  static const String IMG_CROWN = "${imagePath}crown.png";
  static const String IMG_SUBSCRIPTION_BG = "${imagePath}subscription.png";
  static const String IMG_NOTIFICATION_BG =
      "${imagePath}notification_background.png";
  static const String IMG_BRAND1 = "${imagePath}brand1.png";
}
