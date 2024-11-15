/// _id : "66fcdcafe8c9003abddd45e4"
/// overview : "it expert and mathametation"
/// description : "10 years"
/// employeesNo : "masters in sciences computer science"
/// establishDate : "established in 200000000"
/// __v : 0

class Pprofile {
  Pprofile({
      String? id, 
      String? overview, 
      String? description, 
      String? employeesNo, 
      String? establishDate, 
      num? v,}){
    _id = id;
    _overview = overview;
    _description = description;
    _employeesNo = employeesNo;
    _establishDate = establishDate;
    _v = v;
}

  Pprofile.fromJson(dynamic json) {
    _id = json['_id'];
    _overview = json['overview'];
    _description = json['description'];
    _employeesNo = json['employeesNo'];
    _establishDate = json['establishDate'];
    _v = json['__v'];
  }
  String? _id;
  String? _overview;
  String? _description;
  String? _employeesNo;
  String? _establishDate;
  num? _v;
Pprofile copyWith({  String? id,
  String? overview,
  String? description,
  String? employeesNo,
  String? establishDate,
  num? v,
}) => Pprofile(  id: id ?? _id,
  overview: overview ?? _overview,
  description: description ?? _description,
  employeesNo: employeesNo ?? _employeesNo,
  establishDate: establishDate ?? _establishDate,
  v: v ?? _v,
);
  String? get id => _id;
  String? get overview => _overview;
  String? get description => _description;
  String? get employeesNo => _employeesNo;
  String? get establishDate => _establishDate;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['overview'] = _overview;
    map['description'] = _description;
    map['employeesNo'] = _employeesNo;
    map['establishDate'] = _establishDate;
    map['__v'] = _v;
    return map;
  }

}