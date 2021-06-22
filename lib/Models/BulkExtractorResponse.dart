import 'dart:convert';

import 'package:first_app/Models/BulkExtractorMatch.dart';

class BulkExtractorResponse {

  Map<String, BulkExtractorMatch> ipAddresses = Map();
  Map<String, BulkExtractorMatch> domains = Map();
  Map<String, BulkExtractorMatch> emails = Map();
  Map<String, BulkExtractorMatch> headers = Map();
  Map<String, BulkExtractorMatch> urls = Map();

  bool isBlank;

  BulkExtractorResponse.blank() {
    this.isBlank = true;
  }

  BulkExtractorResponse.fromJson(Map<String,dynamic> body) {
    if(body != null) {
      this.isBlank = false;
      
      body["keywords_matches"].forEach((keyword, matchesArray) {
        matchesArray.forEach((match) { 
          if (match["file"] == "ip_histogram.txt") { //matching indirizzi ip
            if (!ipAddresses.keys.contains(keyword)) {
              ipAddresses[keyword] = BulkExtractorMatch(keyword);
            }
            ipAddresses[keyword].addKeywordMatch(match);
          }
          else if (["domain_histogram.txt","email_domain_histogram"].contains(match["file"])) { //matching domini
            if (!domains.keys.contains(keyword)) {
              domains[keyword] = BulkExtractorMatch(keyword);
            }
            domains[keyword].addKeywordMatch(match);
          }
          else if (["email_histogram.txt","email_domain_histogram"].contains(match["file"])) { //matching email
            if (!emails.keys.contains(keyword)) {
              emails[keyword] = BulkExtractorMatch(keyword);
            }
            emails[keyword].addKeywordMatch(match);
          }
          else if (["rfc822.txt"].contains(match["file"])) { //matching headers
            if (!headers.keys.contains(keyword)) {
              headers[keyword] = BulkExtractorMatch(keyword);
            }
            headers[keyword].addKeywordMatch(match);
          }
          else if (["url_services.txt", "url_histogram.txt"].contains(match["file"])) { //matching urls
            if (!urls.keys.contains(keyword)) {
              urls[keyword] = BulkExtractorMatch(keyword);
            }
            urls[keyword].addKeywordMatch(match);
          }
        });
      });

      body["packets_matches"].forEach((keyword, matchMap) { 
        if (!ipAddresses.keys.contains(keyword)) {
          ipAddresses[keyword] = BulkExtractorMatch(keyword);
        }
        ipAddresses[keyword].addPacketsMatch(matchMap);
      });
    } else {
      this.isBlank = true;
    }
  }
}