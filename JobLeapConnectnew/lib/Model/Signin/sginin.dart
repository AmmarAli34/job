/// message : "Signin successful"
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NmZjZGM4MmU4YzkwMDNhYmRkZDQ1ZGYiLCJwaG9uZU51bWJlciI6IjAzMDAwMDAwMDAyIiwiaWF0IjoxNzMwMTAzMzAyfQ.CIjF2XqqDZrioLIKLudBgqp-ctipjgEDQbBeZul7w9s"

class Sginin {
  Sginin({
      String? message, 
      String? token,}){
    _message = message;
    _token = token;
}

  Sginin.fromJson(dynamic json) {
    _message = json['message'];
    _token = json['token'];
  }
  String? _message;
  String? _token;
Sginin copyWith({  String? message,
  String? token,
}) => Sginin(  message: message ?? _message,
  token: token ?? _token,
);
  String? get message => _message;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['token'] = _token;
    return map;
  }

}