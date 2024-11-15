/// _id : "66fcdc82e8c9003abddd45df"
/// aboutMe : "it expert and mathametation"
/// workExperience : "16 years"
/// education : "masters in sciences computer science"
/// skills : "computer expert, software engginear "
/// __v : 0

class ApplicantDetail {
  ApplicantDetail({
      String? id, 
      String? aboutMe, 
      String? workExperience, 
      String? education, 
      String? skills, 
      num? v,}){
    _id = id;
    _aboutMe = aboutMe;
    _workExperience = workExperience;
    _education = education;
    _skills = skills;
    _v = v;
}

  ApplicantDetail.fromJson(dynamic json) {
    _id = json['_id'];
    _aboutMe = json['aboutMe'];
    _workExperience = json['workExperience'];
    _education = json['education'];
    _skills = json['skills'];
    _v = json['__v'];
  }
  String? _id;
  String? _aboutMe;
  String? _workExperience;
  String? _education;
  String? _skills;
  num? _v;
ApplicantDetail copyWith({  String? id,
  String? aboutMe,
  String? workExperience,
  String? education,
  String? skills,
  num? v,
}) => ApplicantDetail(  id: id ?? _id,
  aboutMe: aboutMe ?? _aboutMe,
  workExperience: workExperience ?? _workExperience,
  education: education ?? _education,
  skills: skills ?? _skills,
  v: v ?? _v,
);
  String? get id => _id;
  String? get aboutMe => _aboutMe;
  String? get workExperience => _workExperience;
  String? get education => _education;
  String? get skills => _skills;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['aboutMe'] = _aboutMe;
    map['workExperience'] = _workExperience;
    map['education'] = _education;
    map['skills'] = _skills;
    map['__v'] = _v;
    return map;
  }

}