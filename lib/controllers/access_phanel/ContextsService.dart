import 'dart:convert';
import 'package:al_wasyeah/services/api_constants.dart';
import 'package:http/http.dart' as http;
import '../../models/access_phanel/zakat_property_wasyyah_model.dart';

class ContextsService {


  Future<ZakatPropertyWasiyyahModel> getContextsData(String requestKey) async {
    final url = Uri.parse("${ApiConstants.baseUrl}/getContextsData?requestKey=$requestKey");

    final response = await http.get(url);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);

      return ZakatPropertyWasiyyahModel.fromJson(data);
    } else {
      throw Exception("Failed to load contexts data. Status: ${response.statusCode}");
    }
  }
}

