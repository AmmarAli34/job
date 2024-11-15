/// _id : "670dfce69c77a8e8237f3d00"
/// aboutMe : ""
/// __v : 0
/// workExperience : ""
/// education : ""
/// skills : ""

class ApplicantProfile {
  ApplicantProfile({
      String? id, 
      String? aboutMe, 
      num? v, 
      String? workExperience, 
      String? education, 
      String? skills,}){
    _id = id;
    _aboutMe = aboutMe;
    _v = v;
    _workExperience = workExperience;
    _education = education;
    _skills = skills;
}

  ApplicantProfile.fromJson(dynamic json) {
    _id = json['_id'];
    _aboutMe = json['aboutMe'];
    _v = json['__v'];
    _workExperience = json['workExperience'];
    _education = json['education'];
    _skills = json['skills'];
  }
  String? _id;
  String? _aboutMe;
  num? _v;
  String? _workExperience;
  String? _education;
  String? _skills;
ApplicantProfile copyWith({  String? id,
  String? aboutMe,
  num? v,
  String? workExperience,
  String? education,
  String? skills,
}) => ApplicantProfile(  id: id ?? _id,
  aboutMe: aboutMe ?? _aboutMe,
  v: v ?? _v,
  workExperience: workExperience ?? _workExperience,
  education: education ?? _education,
  skills: skills ?? _skills,
);
  String? get id => _id;
  String? get aboutMe => _aboutMe;
  num? get v => _v;
  String? get workExperience => _workExperience;
  String? get education => _education;
  String? get skills => _skills;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['aboutMe'] = _aboutMe;
    map['__v'] = _v;
    map['workExperience'] = _workExperience;
    map['education'] = _education;
    map['skills'] = _skills;
    return map;
  }

}