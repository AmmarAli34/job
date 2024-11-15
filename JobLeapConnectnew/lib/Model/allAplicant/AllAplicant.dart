/// _id : "66fcdc82e8c9003abddd45df"
/// userName : "applicant2"
/// cnic : "38402-0000000-2"
/// password : "$2b$10$MWoA0CXmmf.sobYxgAju4e9CK6IkGCO3z5ZOhWe/isQseQfg1.lOW"
/// phoneNumber : "03000000002"
/// city : "Sargodha"
/// category : "Driver"
/// jobs : ["66fcdd07e8c9003abddd45e9"]
/// securityStatement : "mothername"
/// date : "2024-10-02T05:39:14.741Z"
/// __v : 0

class AllAplicant {
  AllAplicant({
      String? id, 
      String? userName, 
      String? cnic, 
      String? password, 
      String? phoneNumber, 
      String? city, 
      String? category, 
      List<String>? jobs, 
      String? securityStatement, 
      String? date, 
      num? v,}){
    _id = id;
    _userName = userName;
    _cnic = cnic;
    _password = password;
    _phoneNumber = phoneNumber;
    _city = city;
    _category = category;
    _jobs = jobs;
    _securityStatement = securityStatement;
    _date = date;
    _v = v;
}

  AllAplicant.fromJson(dynamic json) {
    _id = json['_id'];
    _userName = json['userName'];
    _cnic = json['cnic'];
    _password = json['password'];
    _phoneNumber = json['phoneNumber'];
    _city = json['city'];
    _category = json['category'];
    _jobs = json['jobs'] != null ? json['jobs'].cast<String>() : [];
    _securityStatement = json['securityStatement'];
    _date = json['date'];
    _v = json['__v'];
  }
  String? _id;
  String? _userName;
  String? _cnic;
  String? _password;
  String? _phoneNumber;
  String? _city;
  String? _category;
  List<String>? _jobs;
  String? _securityStatement;
  String? _date;
  num? _v;
AllAplicant copyWith({  String? id,
  String? userName,
  String? cnic,
  String? password,
  String? phoneNumber,
  String? city,
  String? category,
  List<String>? jobs,
  String? securityStatement,
  String? date,
  num? v,
}) => AllAplicant(  id: id ?? _id,
  userName: userName ?? _userName,
  cnic: cnic ?? _cnic,
  password: password ?? _password,
  phoneNumber: phoneNumber ?? _phoneNumber,
  city: city ?? _city,
  category: category ?? _category,
  jobs: jobs ?? _jobs,
  securityStatement: securityStatement ?? _securityStatement,
  date: date ?? _date,
  v: v ?? _v,
);
  String? get id => _id;
  String? get userName => _userName;
  String? get cnic => _cnic;
  String? get password => _password;
  String? get phoneNumber => _phoneNumber;
  String? get city => _city;
  String? get category => _category;
  List<String>? get jobs => _jobs;
  String? get securityStatement => _securityStatement;
  String? get date => _date;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['userName'] = _userName;
    map['cnic'] = _cnic;
    map['password'] = _password;
    map['phoneNumber'] = _phoneNumber;
    map['city'] = _city;
    map['category'] = _category;
    map['jobs'] = _jobs;
    map['securityStatement'] = _securityStatement;
    map['date'] = _date;
    map['__v'] = _v;
    return map;
  }

}