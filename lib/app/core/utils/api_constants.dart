class ApiConstants {
  static String currentLang = 'en';

  static const String baseUrl = "https://api.wasiyyat.com/api/v1";
  static const String imageUrl = "$baseUrl/raw/";
  static const String fileDownloadUrl = "$baseUrl/raw-media-info/";
  static String get securityQuestion =>
      "/user/securityQuestionList?lang=$currentLang";

  // sign up
  static const String signUpEndPoint = "/user/register";
  // change password
  static const String changePassAPI = "user/update/password";
  // sign in
  static const String signInEndPoint = "/user/login";
  // send otp
  static const String sendOtpEndPoint = "/user/forget-password";
  static const forgetSecurityQuestion = "/user/forgetSecurityQuestion";
  // check otp
  static const String checkOtpEndPoint = "$sendOtpEndPoint/checkOtp";
  // witness
  static const String yourWitness = "/user/get-witness";
  static const String witnessedByAnotherUser = "/get-witnessByAnotherUser";
  static String addYourWitness(String email) =>
      "/user/assign-witness?email=$email";
  static const String saveWitness = "/user/save-nominee";
  static String deleteWitness(String requestKey) =>
      "/user/remove-witness?requestKey=$requestKey";
  static String searchWitness(String email) =>
      "/user/search-witness-nominee?email=$email&isWitness=true";

  // nominess
  static const String yourNominee = "/user/get-nominees";
  static const String nomineedByAnotherUser = "/get-nomineeByAnotherUser";
  static String addYourNominee(String email) =>
      "/user/assign-nominee?email=$email";
  static const String saveNominee = "/user/save-nominee";
  static String deleteNominee(String requestKey) =>
      "/user/remove-nominee?requestKey=$requestKey";
  static String searchNominee(String email) =>
      "/user/search-witness-nominee?email=$email&isWitness=false";
  static const String accessControl = "/getUsersByRole?isWitness=";
  static const String accessFeature = "/getContexts";
  static const String accessSelect = "/getUserContexts";
  static const String accessControlPanelData = "/getContextsData";
  static const String nisab = "/user/getNisabRates";

  static const String wasyyahYouDataYou = "/user/getWasiyyah";
  static const String saveWasiyyah = "/user/saveWasiyyah";
  static const String changeOrder = "/user/changeOrder";

  static String get zakatEndPoint => "/zakatCalculator?lang=$currentLang";
  static String salatTimeEndPoint(String lat, String long) =>
      "/mobile/getSalahTime?latitude=$lat&longitude=$long";

  static const String addFeatureNomineeWitnessPoint =
      "/assignContext?isWitness=";
  static const String getUserEndPoint = "/auth/session";
  static String get maritalList => "/lookup/maritalList?lang=$currentLang";
  static String get professionList => "/lookup/professionList?lang=$currentLang";
  static String get countryList => "/lookup/countryList?lang=$currentLang";
  static String get genderList => "/lookup/gender?lang=$currentLang";
  static String get bankList => "/lookup/bankList?lang=$currentLang";
  static String get branchList => "/lookup/branchList?lang=$currentLang";
  static String get wealthList => "/lookup/wealthList?lang=$currentLang";
  static String get getProfile => "/user/getProfileData?lang=$currentLang";
  static String get deleteAccount => "/user/delete-user?lang=$currentLang";
  static String documentTypeList(String wealthId) =>
      "/lookup/documentTypeList?lang=$currentLang&wealthId=$wealthId";
  static String get inappnotificationList => '/get-notification?lang=$currentLang';
  static String get profileUpdate => "/lookup/saveProfileData?lang=$currentLang";
  static String get relevantList => "/relevantList?lang=$currentLang";
  static String get propertyDistributionCalculationResult =>
      "/propertyDistributeResult?lang=$currentLang";
  static String get getPropertyDistributionCalculationResult =>
      "/getPropertyDistributeResult?lang=$currentLang";
  static String get getCertificateInfo =>
      "/user/getCertificateInfo?lang=$currentLang";
  static String get savePropertyDistributionCalculationResult =>
      "/savePropertyDistributeResult?lang=$currentLang";
  static String inappNOtificationAcceptRejectRequest = "/accept-reject-request";
  static String get getMenus => "/user/menu/getMenus?lang=$currentLang";
  // contact us
  static String get contactUsEndPoint => "/contactUsEmailSend?lang=$currentLang";
}
