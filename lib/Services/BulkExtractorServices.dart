import 'dart:convert';
import 'package:first_app/Models/BulkExtractorResponse.dart';
import 'package:first_app/Models/SqueezeRequest.dart';
import 'package:http/http.dart' as http;

class BulkExtractorServices {
  static String url = "http://localhost:5000/be";

  static Future<BulkExtractorResponse> be(SqueezeRequest request) async{
    List<String> kwArray = request.keywordsArray;
    List<String> ipArray = request.ipArray;
    Map<String, List<String>> requestBody = Map();

    for (int i=0; i < kwArray.length; i++) {
      if(kwArray[i].startsWith(r"$")) {
        kwArray[i] = kwArray[i].substring(1);
      }
    }

    for (int i=0; i < ipArray.length; i++) {
      if(ipArray[i].startsWith(r"$")) {
        ipArray[i] = ipArray[i].substring(1);
      }
    }

    if(ipArray.isEmpty)
      requestBody["packets"] = [""];
    else 
      requestBody["packets"] = ipArray.sublist(0,ipArray.length);
    requestBody["domain_histogram.txt"] = kwArray.sublist(0, kwArray.length);
    requestBody["email_domain_histogram.txt"] = kwArray.sublist(0, kwArray.length);
    requestBody["email_histogram.txt"] = kwArray.sublist(0, kwArray.length);
    requestBody["ip_histogram.txt"] = kwArray.sublist(0, kwArray.length);
    requestBody["url_histogram.txt"] = kwArray.sublist(0, kwArray.length);
    requestBody["url_services.txt"] = kwArray.sublist(0, kwArray.length);
    requestBody["rfc822.txt"] = kwArray.sublist(0, kwArray.length);

    final res = await http.post(
      url,
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody)
    );

    if(res.statusCode == 200) {
      return BulkExtractorResponse.fromJson(jsonDecode(res.body));
    } else {
      return BulkExtractorResponse.blank();
    }
  }
}
