
class AppConstants{

  ///=======================Prefs Helper data===============================>
  static const String type = "role";
  // static String roleMock = 'roleMock';
  static String bearerToken = 'token';
  static String email = 'email';
  static String isLogged = 'true';
   static String userId = 'userId';
  static String userIdTest = '';
  static String businessID = '';
  static String firstname = 'firstName';
  static String lastname = 'lastName';
  static String image = '';
  static String phone = '';
  // static String promoCode = '';
  static String stribeUrl = '';

  static RegExp emailValidate = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static bool validatePassword(String value) {
    RegExp regex = RegExp(r'^(?=.*[0-9])(?=.*[a-zA-Z]).{8,}$');
    return regex.hasMatch(value);
  }


  static const String publishAbleKey = "pk_test_51OVVcyFiDaJ8bQBjyv4imMqxSbWPo07q81rTzpcw7yUIlXiUBfFThslht2LC8uD5Ec5MuiW1SPyrasy8N6v3MfyJ00d1bz549n";
  static const String secretKey = "sk_test_51OVVcyFiDaJ8bQBjNbxRzrInTwKZ0OX5zQ22QjOwJ5fBJEN4CJx1SkPmwCiDqmvO6UWOYuB5xMvV2SAjszbpCIDk009t0O7BqT";

}
enum Status { loading, completed, error, internetError }