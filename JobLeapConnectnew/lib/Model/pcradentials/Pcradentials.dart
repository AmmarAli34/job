/// userName : "company5"
/// email : "company5@gmail.com"
/// phoneNumber : "03000000005"
/// city : "Sargodha"
/// category : "Driver"

class Pcradentials {
  Pcradentials({
      String? userName, 
      String? email, 
      String? phoneNumber, 
      String? city, 
      String? category,}){
    _userName = userName;
    _email = email;
    _phoneNumber = phoneNumber;
    _city = city;
    _category = category;
}

  Pcradentials.fromJson(dynamic json) {
    _userName = json['userName'];
    _email = json['email'];
    _phoneNumber = json['phoneNumber'];
    _city = json['city'];
    _category = json['category'];
  }
  String? _userName;
  String? _email;
  String? _phoneNumber;
  String? _city;
  String? _category;
Pcradentials copyWith({  String? userName,
  String? email,
  String? phoneNumber,
  String? city,
  String? category,
}) => Pcradentials(  userName: userName ?? _userName,
  email: email ?? _email,
  phoneNumber: phoneNumber ?? _phoneNumber,
  city: city ?? _city,
  category: category ?? _category,
);
  String? get userName => _userName;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  String? get city => _city;
  String? get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userName'] = _userName;
    map['email'] = _email;
    map['phoneNumber'] = _phoneNumber;
    map['city'] = _city;
    map['category'] = _category;
    return map;
  }

}