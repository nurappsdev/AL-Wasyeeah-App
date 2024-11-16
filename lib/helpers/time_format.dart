
import 'package:intl/intl.dart';


class TimeFormatHelper {
  static String formatDate(DateTime date) {
    return DateFormat('dd MMM, yyyy').format(date);
  }

  static String dateMountFormat(DateTime date) {
    return DateFormat('dd\n MMM ').format(date);
  }

  static String timeFormat(DateTime date) {
    return DateFormat('hh:mm a').format(date);
  }


  static timeWithAMPM(String time){
    DateTime parsedTime = DateFormat('HH:mm:ss').parse(time);
    String formattedTime = DateFormat('h:mm a').format(parsedTime);
    return formattedTime;
  }

// static Future<void> isFutureDate(String input) async {
//   try {
//     DateTime date = DateTime.parse(input);
//     DateTime now = DateTime.now();
//     await PrefsHelper.setBool(AppConstants.isFutureDate, date.isAfter(now));
//   } catch (e) {
//     PrefsHelper.setBool(AppConstants.isFutureDate, false);
//   }
// }
//


}
