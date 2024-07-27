class GetBagResponse {
  String? bagNumber;
  String? baggerNumber;
  String? eventDateTime;
  String? feedHopperNumber;
  String? reasonCode;
  String? description;
  String? sourceOfMaterial;
  String? weight;
  String? line;

  GetBagResponse(
      {this.bagNumber,
        this.baggerNumber,
        this.eventDateTime,
        this.feedHopperNumber,
        this.reasonCode,
        this.description,
        this.sourceOfMaterial,
        this.weight,
        this.line});

  GetBagResponse.fromJson(Map<String, dynamic> json) {
    bagNumber = json['bagNumber'];
    baggerNumber = json['baggerNumber'];
    eventDateTime = json['eventDateTime'];
    feedHopperNumber = json['feedHopperNumber'];
    reasonCode = json['reasonCode'];
    description = json['description'];
    sourceOfMaterial = json['sourceOfMaterial'];
    weight = json['weight'];
    line = json['line'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bagNumber'] = this.bagNumber;
    data['baggerNumber'] = this.baggerNumber;
    data['eventDateTime'] = this.eventDateTime;
    data['feedHopperNumber'] = this.feedHopperNumber;
    data['reasonCode'] = this.reasonCode;
    data['description'] = this.description;
    data['sourceOfMaterial'] = this.sourceOfMaterial;
    data['weight'] = this.weight;
    data['line'] = this.line;
    return data;
  }
}

class GetBagResponseList {
  List<GetBagResponse>? bags;

  GetBagResponseList({this.bags});

  GetBagResponseList.fromJson(List<dynamic> json) {
    if (json != null) {
      bags = <GetBagResponse>[];
      json.forEach((v) {
        bags!.add(GetBagResponse.fromJson(v));
      });
    }
  }

  List<dynamic> toJson() {
    List<dynamic> data = <dynamic>[];
    if (this.bags != null) {
      data = this.bags!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
