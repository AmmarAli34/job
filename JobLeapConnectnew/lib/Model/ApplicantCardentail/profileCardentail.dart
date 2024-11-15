/// userName : "abcg"
/// cnic : "38403-0008884-3"
/// phoneNumber : "03000000035"
/// city : "Sargodha"
/// category : "Chef"

class ProfileCardentail {
  ProfileCardentail({
      String? userName, 
      String? cnic, 
      String? phoneNumber, 
      String? city, 
      String? category,}){
    _userName = userName;
    _cnic = cnic;
    _phoneNumber = phoneNumber;
    _city = city;
    _category = category;
}

  ProfileCardentail.fromJson(dynamic json) {
    _userName = json['userName'];
    _cnic = json['cnic'];
    _phoneNumber = json['phoneNumber'];
    _city = json['city'];
    _category = json['category'];
  }
  String? _userName;
  String? _cnic;
  String? _phoneNumber;
  String? _city;
  String? _category;
ProfileCardentail copyWith({  String? userName,
  String? cnic,
  String? phoneNumber,
  String? city,
  String? category,
}) => ProfileCardentail(  userName: userName ?? _userName,
  cnic: cnic ?? _cnic,
  phoneNumber: phoneNumber ?? _phoneNumber,
  city: city ?? _city,
  category: category ?? _category,
);
  String? get userName => _userName;
  String? get cnic => _cnic;
  String? get phoneNumber => _phoneNumber;
  String? get city => _city;
  String? get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userName'] = _userName;
    map['cnic'] = _cnic;
    map['phoneNumber'] = _phoneNumber;
    map['city'] = _city;
    map['category'] = _category;
    return map;
  }

}