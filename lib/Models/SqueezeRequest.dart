class SqueezeRequest {
  List<String> keywordsArray;
  List<String> ipArray;
  String os;

  SqueezeRequest();
  SqueezeRequest.empty();

  set selectedOS (String os) {
    this.os = os;
  }
  
  String get selectedOS {
    return this.os;
  }
  
  set keywords (List<String> kw) {
    this.keywordsArray = kw;
  }
  
  List<String> get keywords {
    return this.keywordsArray;
  }

  void setKeywordsFromString(String kw){
    this.keywordsArray = kw.split(";");
    this.keywordsArray.remove("");
  }

  set ip (List<String> ip) {
    this.ipArray = ip;
  }
  
  List<String> get ip {
    return this.ipArray;
  }

  void setIpFromString(String ipString){
    this.ipArray = ipString.split(";");
    this.ipArray.remove("");
  }
}