class Crew {
  bool? adult;
  int? gender;
  int? id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  String? creditId;
  String? department;
  String? job;

  Crew(
      { adult,
       gender,
       id,
       knownForDepartment,
       name,
       originalName,
       popularity,
       profilePath,
       creditId,
       department,
       job});

  Crew.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    originalName = json['original_name'];
    popularity = json['popularity'].toDouble();
    profilePath = json['profile_path'];
    creditId = json['credit_id'];
    department = json['department'];
    job = json['job'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] =  adult;
    data['gender'] =  gender;
    data['id'] =  id;
    data['known_for_department'] =  knownForDepartment;
    data['name'] =  name;
    data['original_name'] =  originalName;
    data['popularity'] =  popularity;
    data['profile_path'] =  profilePath;
    data['credit_id'] =  creditId;
    data['department'] =  department;
    data['job'] =  job;
    return data;
  }
}
