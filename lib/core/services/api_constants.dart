class ApiConstants {
  static String currentLang = 'en';

  static const String baseUrl = "https://api.wasiyyat.com/api/v1";
  static const String imageUrl = "$baseUrl/raw/";
  static const String fileDownloadUrl = "$baseUrl/raw-media-info/";
  static const String securityQuestion = "/user/securityQuestionList";
  // witness
  static const String yourWitness = "/user/get-witness";
  static const String witnessedByAnotherUser = "/get-witnessByAnotherUser";
  static String addYourWitness(String email) => "/user/assign-witness?email=$email";
  static const String saveWitness = "/user/save-nominee";
  static String deleteWitness(String requestKey) => "/user/remove-witness?requestKey=$requestKey";
  static String searchWitness(String email) => "/user/search-witness-nominee?email=$email&isWitness=true";

  // nominess
  static const String yourNominee = "/user/get-nominees";
  static const String nomineedByAnotherUser = "/get-nomineeByAnotherUser";
  static String addYourNominee(String email) => "/user/assign-nominee?email=$email";
  static const String saveNominee = "/user/save-nominee";
  static String deleteNominee(String requestKey) => "/user/remove-nominee?requestKey=$requestKey";
  static String searchNominee(String email) => "/user/search-witness-nominee?email=$email&isWitness=false";

  static const String accessControl = "/getUsersByRole?isWitness=";
  static const String accessFeature = "/getContexts";
  static const String accessSelect = "/getUserContexts";
  static const String accessControlPanelData = "/getContextsData";
  static const String nisab = "/user/getNisabRates";

  static const String wasyyahYouDataYou = "/user/getWasiyyah";
  static const String saveWasiyyah = "/user/saveWasiyyah";
  static const String changeOrder = "/user/changeOrder";

  static const String signUpEndPoint = "/user/register";
  static const String changePassAPI = "user/update/password";
  static const String signInEndPoint = "/user/login";
  static const String forgotEndPoint = "/user/forget-password";
  static String get zakatEndPoint => "/zakatCalculator?lang=$currentLang";
  static String salatTimeEndPoint(String lat, String long) => "/mobile/getSalahTime?latitude=$lat&longitude=$long";

  static const String addFeatureNomineeWitnessPoint = "/assignContext?isWitness=";
  static const String getUserEndPoint = "/auth/session";
  static const String forgotPassEndPoint = "/auth/forgot";
  static String updateProfileEndPoint(String id) => "/users/$id";
  static String setPasswordEndPoint(String id) => "/users/$id";
  static const String resetPassEndPoint = "/user/reset-password";
  static const String userMoreInformationEndPoint = "/user/information";
  static const String allMyPmojiEndPoint = "/sticker/my-sticker";
  static const String passCartIdiEndPoint = "/cart/add-to-cart";
  static const String getCartEndPoint = "/cart/my-cart";
  static const String changePassEndPoint = "/user/change-password";
  static String maritalList = "/lookup/maritalList";
  static String professionList = "/lookup/professionList?lang=$currentLang";
  static String countryList = "/lookup/countryList";
  static String genderList = "/lookup/gender";
  static String bankList = "/lookup/bankList";
  static String branchList = "/lookup/branchList";
  static String wealthList = "/lookup/wealthList?lang=$currentLang";
  static String getProfile = "/user/getProfileData";
  static String documentTypeList(String wealthId) => "/lookup/documentTypeList?lang=$currentLang&wealthId=$wealthId";
  static String inappnotificationList = '/get-notification';
  static String profileUpdate = "/lookup/saveProfileData";
  static String relevantList = "/relevantList?lang=$currentLang";
  static String propertyDistributionCalculationResult = "/propertyDistributeResult?lang=$currentLang";
  static String getPropertyDistributionCalculationResult = "/getPropertyDistributeResult";
  static String savePropertyDistributionCalculationResult = "/savePropertyDistributeResult";
  static String inappNOtificationAcceptRejectRequest = "/accept-reject-request";
  static const String getMenus = "/user/menu/getMenus";
  // contact us
  static const String contactUsEndPoint = "/contactUsEmailSend";
}
