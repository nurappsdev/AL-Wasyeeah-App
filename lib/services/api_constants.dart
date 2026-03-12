class ApiConstants {
  static String currentLang = 'en';

  static const String baseUrl = "https://api.wasiyyat.com/api/v1";
  static const String imageUrl = "$baseUrl/raw/";
  static const String fileDownloadUrl = "$baseUrl/raw-media-info/";
  static const String securityQuestionEndPoint = "/user/securityQuestionList";
  static const String nomineeEndPoint = "/user/get-nominees";
  static const String accessControlEndPoint = "/getUsersByRole?isWitness=";
  static const String accessFeatureEndPoint = "/getContexts";
  static const String accessSelectEndPoint = "/getUserContexts";
  static const String nomineetedYouPoint = "/get-nomineeByAnotherUser";
  static const String nomineeDeletePoint = "/user/remove-nominee";
  static const String witnessEndPoint = "/user/get-witness";
  static const String nisabEndPoint = "/user/getNisabRates";
  static const String witnessesYouEndPoint = "/get-witnessByAnotherUser";
  static const String wasyyahYouDataYouEndPoint = "/user/getWasiyyah";
  static const String witnessDeletePoint = "/user/remove-witness";
  static const String witnessAssignPoint = "/user/assign-witness";
  static const String nomineeAssignPoint = "/user/assign-nominee";
  static const String signUpEndPoint = "/user/register";
  static const String changePassAPI = "user/update/password";
  static const String signInEndPoint = "/user/login";
  static const String forgotEndPoint = "/user/forget-password";
  static String get zakatEndPoint => "/zakatCalculator?lang=$currentLang";
  static String salatTimeAPI(String lat, String long) =>
      "/mobile/getSalahTime?latitude=$lat&longitude=$long";
  static const String addNomineePoint = "/user/save-nominee";
  static const String addWitnessEndPoint = "/user/save-nominee";
  static const String addFeatureNomineeWitnessPoint =
      "/assignContext?isWitness=";
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
  static String get professionList =>
      "/lookup/professionList?lang=$currentLang";
  static String countryList = "/lookup/countryList";
  static String genderList = "/lookup/gender";
  static String bankList = "/lookup/bankList";
  static String branchList = "/lookup/branchList";
  static String get wealthList => "/lookup/wealthList?lang=$currentLang";
  static String getProfile = "/user/getProfileData";
  static String documentTypeList = "/lookup/documentTypeList";
  static String inappnotificationList = '/get-notification';
  static String profileUpdate = "/lookup/saveProfileData";
  static String get relevantList => "/relevantList?lang=$currentLang";
  static String get propertyDistributionCalculationResult =>
      "/propertyDistributeResult?lang=$currentLang";
  static String inappNOtificationAcceptRejectRequest = "/accept-reject-request";
}
