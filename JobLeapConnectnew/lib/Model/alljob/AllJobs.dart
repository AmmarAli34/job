/// _id : "66fcdd07e8c9003abddd45e9"
/// companyName : "company3"
/// phoneNumber : "03000000003"
/// city : "Sargodha"
/// jobTitle : "Waiter"
/// jobExplanation : "we want sencere security guard having minimum experience of 2 years"
/// date : "2024-10-02T05:41:27.639Z"
/// price : 22000
/// __v : 0

class AllJobs {
  AllJobs({
      String? id, 
      String? companyName, 
      String? phoneNumber, 
      String? city, 
      String? jobTitle, 
      String? jobExplanation, 
      String? date, 
      num? price, 
      num? v,}){
    _id = id;
    _companyName = companyName;
    _phoneNumber = phoneNumber;
    _city = city;
    _jobTitle = jobTitle;
    _jobExplanation = jobExplanation;
    _date = date;
    _price = price;
    _v = v;
}

  AllJobs.fromJson(dynamic json) {
    _id = json['_id'];
    _companyName = json['companyName'];
    _phoneNumber = json['phoneNumber'];
    _city = json['city'];
    _jobTitle = json['jobTitle'];
    _jobExplanation = json['jobExplanation'];
    _date = json['date'];
    _price = json['price'];
    _v = json['__v'];
  }
  String? _id;
  String? _companyName;
  String? _phoneNumber;
  String? _city;
  String? _jobTitle;
  String? _jobExplanation;
  String? _date;
  num? _price;
  num? _v;
AllJobs copyWith({  String? id,
  String? companyName,
  String? phoneNumber,
  String? city,
  String? jobTitle,
  String? jobExplanation,
  String? date,
  num? price,
  num? v,
}) => AllJobs(  id: id ?? _id,
  companyName: companyName ?? _companyName,
  phoneNumber: phoneNumber ?? _phoneNumber,
  city: city ?? _city,
  jobTitle: jobTitle ?? _jobTitle,
  jobExplanation: jobExplanation ?? _jobExplanation,
  date: date ?? _date,
  price: price ?? _price,
  v: v ?? _v,
);
  String? get id => _id;
  String? get companyName => _companyName;
  String? get phoneNumber => _phoneNumber;
  String? get city => _city;
  String? get jobTitle => _jobTitle;
  String? get jobExplanation => _jobExplanation;
  String? get date => _date;
  num? get price => _price;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['companyName'] = _companyName;
    map['phoneNumber'] = _phoneNumber;
    map['city'] = _city;
    map['jobTitle'] = _jobTitle;
    map['jobExplanation'] = _jobExplanation;
    map['date'] = _date;
    map['price'] = _price;
    map['__v'] = _v;
    return map;
  }

}