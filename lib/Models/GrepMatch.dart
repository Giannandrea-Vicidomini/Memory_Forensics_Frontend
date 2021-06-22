class GrepMatch {
  String keyword;
  Map<String, int> matches;
  int occurrences;

  GrepMatch(String kw) {
    this.keyword = kw;
    matches = Map();
    occurrences = 0;
  }

  void addKeywordMatch(String match, int value) {
    matches[match] = value;
    occurrences += value;
  }
}