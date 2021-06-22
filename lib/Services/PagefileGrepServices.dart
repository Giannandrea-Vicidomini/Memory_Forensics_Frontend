import 'dart:convert';
import 'package:first_app/Models/GrepResponse.dart';
import 'package:first_app/Models/SqueezeRequest.dart';
import 'package:http/http.dart' as http;

class PagefileGrepServices {
  static String url = "http://127.0.0.1:5000/pagefile/grep";

  static Future<GrepResponse> grep(SqueezeRequest request) async {

    Map<String,List<String>> requestBody = Map();
    requestBody["keywords"] = request.keywordsArray;
    
    final res = await http.post(
      url,
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody)
    );

    if(res.statusCode == 200) {
      return GrepResponse.fromJson(jsonDecode(res.body));
    } else {
      return GrepResponse.blank();
    }
  }
}