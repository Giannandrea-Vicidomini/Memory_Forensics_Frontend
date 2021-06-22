import 'package:first_app/Models/GrepMatch.dart';

class GrepResponse {
  bool isBlank;

  Map<String, GrepMatch> matches = Map();

  GrepResponse.blank() {
    this.isBlank = true;
  }

  GrepResponse.fromJson(Map<String,dynamic> body) {
    if(body != null) {
      this.isBlank = false;

      body.forEach((keyword, matches) { 
        matches.forEach((match, value) { 
          if (!this.matches.keys.contains(keyword)) {
            this.matches[keyword] = GrepMatch(keyword);
          }
          this.matches[keyword].addKeywordMatch(match, value);
        });
      });
    } else {
      this.isBlank = true;
    }
  }
}