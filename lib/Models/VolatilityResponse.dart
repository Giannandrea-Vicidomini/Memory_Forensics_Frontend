class VolatilityResponse {
  Map _data = Map();
  bool isEmpty;
  bool isBlank;
  bool isUnsupported;
  
  VolatilityResponse.empty(){
    this.isEmpty = true;
    this.isBlank = false;
    this.isUnsupported = false;
  }

  VolatilityResponse.blank(){
    this.isEmpty = false;
    this.isUnsupported = false;
    this.isBlank = true;
  }

  VolatilityResponse.unsupported(){
    this.isEmpty = false;
    this.isBlank = false;
    this.isUnsupported = true;
  }

  VolatilityResponse.fromJson(Map<String,dynamic> json) {
    this.isEmpty = false;
    this.isUnsupported = false;
    if(json != null){
      this.isBlank = false;
      this._data = json["data"];
    } else {
      this.isBlank = true;
    }
  }

  Map get datas {
    return _data;
  }

  void setValue(key,value) {
    if(this.isEmpty) {
      this.isEmpty = false;
    }
    _data[key] = value;
  }

  static VolatilityResponse parsePslistKeywords(VolatilityResponse pslist, List<String> keywordsArray) {
    VolatilityResponse parsedPslist = VolatilityResponse.empty();

    if(keywordsArray.isNotEmpty){
      pslist.datas.forEach((key, value) {
        keywordsArray.forEach((element) {
          String val = value["ImageFileName"].toString().toLowerCase();
          if(element.compareTo("") != 0){
            if(element.startsWith(r"$")){
              String kw = element.substring(1);
              
              if(val.compareTo(kw.toLowerCase()) == 0){
                parsedPslist.setValue(key, value);
              }
            } else {
              if(val.contains(element.toLowerCase())){
                parsedPslist.setValue(key, value);
              }
            }
          }
        });
      });
      return parsedPslist;
    } else {
      return VolatilityResponse.empty();
    }
  }

  static VolatilityResponse parseNetscanArguments(VolatilityResponse netscan, List<String> keywordsArray, List<String> ipArray) {
    VolatilityResponse parsedNetscan = VolatilityResponse.empty();
    if(keywordsArray.isNotEmpty){
      netscan.datas.forEach((key, value) {

        String owner = value["Owner"].toString().toLowerCase();
        String foreignAddr = value["ForeignAddr"].toString().toLowerCase();
        String localAddr = value["LocalAddr"].toString().toLowerCase();
        String proto = value["Proto"].toString().toLowerCase();
        
        keywordsArray.forEach((element) {
          
          if(element.compareTo("") != 0){
            if(element.startsWith(r"$")){
              String kw = element.substring(1);
              
              if(owner.compareTo(kw.toLowerCase()) == 0 || proto.compareTo(kw.toLowerCase()) == 0 ){
                parsedNetscan.setValue(key, value);
              }
            } else {
              if(owner.contains(element.toLowerCase()) || proto.contains(element.toLowerCase())){
                parsedNetscan.setValue(key, value);
              }
            }
          }
        });

        ipArray.forEach((element) {
          if(element.compareTo("") != 0){
            if(element.startsWith(r"$")){
              String ip = element.substring(1);
              
              if(foreignAddr.compareTo(ip.toLowerCase()) == 0 || localAddr.compareTo(ip.toLowerCase()) == 0){
                parsedNetscan.setValue(key, value);
              }
            } else {
              if(foreignAddr.contains(element.toLowerCase()) || localAddr.contains(element.toLowerCase())){
                parsedNetscan.setValue(key, value);
              }
            }
          }
        });
      });
      return parsedNetscan;
    } else {
      return VolatilityResponse.empty();
    }
  }

  static VolatilityResponse parseFilescanArguments(VolatilityResponse filescan, List<String> keywordsArray) {
    VolatilityResponse parsedFilescan = VolatilityResponse.empty();
    
    if(keywordsArray.isNotEmpty){
      filescan.datas.forEach((key, value) {
        List<String> splittedPath = value["Name"].toString().split("\\");
        String fileName = splittedPath.last.toLowerCase();

        keywordsArray.forEach((element) {
          if(element.compareTo("") != 0){
            if(element.startsWith(r"$")){
              String kw = element.substring(1);
              
              if(fileName.compareTo(kw.toLowerCase()) == 0){
                parsedFilescan.setValue(key, value);
              }
            } else {
              if(fileName.contains(element.toLowerCase())){
                parsedFilescan.setValue(key, value);
              }
            }
          }
        });
      });
      return parsedFilescan;  
    } else {
      return VolatilityResponse.empty();
    }
  }

  static VolatilityResponse parseTimelinerKeywords(VolatilityResponse timeliner, List<String> keywordsArray) {
    VolatilityResponse parsedTimeliner = VolatilityResponse.empty();

    if(keywordsArray.isNotEmpty){
      timeliner.datas.forEach((key, value) {
        String description = value["Description"].toString().toLowerCase();

        keywordsArray.forEach((element) {
          if(element.compareTo("") != 0){
            if(description.contains(element.toLowerCase())){
              parsedTimeliner.setValue(key, value);
            }
          }
        });
      });
      return parsedTimeliner;  
    } else {
      return VolatilityResponse.empty();
    }
  }
}