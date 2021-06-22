import 'dart:convert';
import 'package:first_app/Models/VolatilityResponse.dart';
import 'package:http/http.dart' as http;

class VolatilityServices{

  static String url = "http://localhost:5000/volatility/";

  static Future<VolatilityResponse> psList(String os) async {
    final res = await http.get(url+os+"/pslist");

    if(res.statusCode == 200){
      return VolatilityResponse.fromJson(jsonDecode(res.body));
    }
    return VolatilityResponse.blank();
  }

  static Future<VolatilityResponse> psTree(String os) async {
    final res = await http.get(url+os+"/pstree");

    if(res.statusCode == 200){
      return VolatilityResponse.fromJson(jsonDecode(res.body));
    }
    return VolatilityResponse.blank();
  }

  static Future<VolatilityResponse> netScan(String os) async {
    if(os == "windows"){
      final res = await http.get(url+os+"/netscan");

      if(res.statusCode == 200){
        return VolatilityResponse.fromJson(jsonDecode(res.body));
      }
      return VolatilityResponse.blank();
    } else {
      return VolatilityResponse.unsupported();
    }
  }

  static Future<VolatilityResponse> fileScan(String os) async {
    if(os == "windows"){
      final res = await http.get(url+os+"/filescan");

      if(res.statusCode == 200){
        return VolatilityResponse.fromJson(jsonDecode(res.body));
      }
      return VolatilityResponse.blank();
    } else {
      return VolatilityResponse.unsupported();
    }
  }

  static Future<VolatilityResponse> timeliner(String os) async {
    final res = await http.get(url+os+"/timeliner");

    if(res.statusCode == 200){
      return VolatilityResponse.fromJson(jsonDecode(res.body));
    }
    return VolatilityResponse.blank();
  }
}