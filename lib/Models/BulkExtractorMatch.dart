class BulkExtractorMatch {
  String keyword;
  Map<String, int> matches;
  int occurrences;

  BulkExtractorMatch(String kw) {
    this.keyword = kw;
    matches = Map();
    occurrences = 0;
  }

  void addKeywordMatch(Map match) {
    String key = match["match"];
    int value = match["occurrences"];
    matches[key] = value;
    occurrences += value;
  }

  void addPacketsMatch(Map match) {
    match.forEach((key, value) { 
      if(!matches.keys.contains(key)) {
        matches[key] = value;
      } else {
        matches[key] += value;
      }
      occurrences += value;
    });
  }
}