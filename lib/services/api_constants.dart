
class ApiConstants{
  static const String baseUrl = "http://192.168.10.187:9000";
  static const String imageBaseUrl = "http://192.168.10.187:9000";


  static const String allSearchBusinessEndPoint = "/businesses?limit=5000";
  static  String allPostCodeEndPoint(String postCode) => "/suburbs?limit=50&postcode=$postCode";
  static String singleBusinessEndPoint(String id) => "/businesses/$id";
  static String singlePortfolioEndPoint(String page, String id) => "/portfolios?page=$page&businessId=$id";
  static String serviceWiseBusinessEndPoint(String serviceId, lat, longs) => "/businesses/?serviceId=$serviceId&limit=50&latitude=$lat&longitude=$longs";
  static const String allServiceEndPoint = "/services?limit=5000";
  static const String userCallEndPoint = "/communications";
  static const String userMessageEndPoint = "/messages";
  static const String signUpEndPoint = "/auth/register";
  static const String signInEndPoint = "/auth/login";
  static const String getUserEndPoint = "/auth/session";
  static const String getAboutAndPrivacyTermsEndPoint = "/app-data";
  static String reviews(String id) => "/reviews?businessId=$id";








  static const String verifyEmailEndPoint = "/user/verify-otp";
  static  String getResendOTPEndPoint(String userId) => "/auth/otp?userId=$userId";
  static const String forgotPassEndPoint = "/auth/forgot";
  static  String updateProfileEndPoint(String id) => "/users/$id";
  static  String setPasswordEndPoint(String id) => "/users/$id";



  static const String resetPassEndPoint = "/user/reset-password";




  static const String userMoreInformationEndPoint = "/user/information";
  static const String allMyPmojiEndPoint = "/sticker/my-sticker";
  static const String passCartIdiEndPoint = "/cart/add-to-cart";
  static const String getCartEndPoint = "/cart/my-cart";

  static const String changePassEndPoint = "/user/change-password";
  static const String promoCodePassEndPoint = "/promo-code/use-promo";
  static const String notificationEndPoint = "/notification/my-notification";
  static String singleGalleryDeleteEndPoint(String id) => "/portfolios/$id";
  static String singleJobsDeleteEndPoint(String id) => "/jobs/$id";
  static  String galleryEndPoint(String page, String id) => "/portfolios?page=$page&businessId=$id";
  static  String providerNotiEndPoint(String page,) => "/communications?page=$page";
  static  String customerJobsEndPoint(String page,) => "/jobs?page=$page";
  static  String providerBitsEndPoint(String page,) => "/bits?page=$page";
  static  String providerJobsEndPoint(String page,String businessId) => "/jobs?page=$page&businessId=$businessId";
  static  String providerJobsApplicationEndPoint(String page,String jobId) => "/job-applications?page=$page&jobId=$jobId";

}