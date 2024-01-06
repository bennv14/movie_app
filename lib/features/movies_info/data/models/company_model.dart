import 'package:movie_app/features/movies_info/domain/entities/company_entity.dart';

class CompanyModel extends CompanyEntity {
  const CompanyModel({
    int? id,
    String? logoPath,
    String? name,
  }) : super(
          id: id,
          logoPath: logoPath,
          name: name,
        );

  CompanyModel.fromJson(Map<String, dynamic> json) {
    CompanyModel(
      id: json['id'],
      logoPath: json['logoPath'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['logo_path'] = logoPath;
    data['name'] = name;
    return data;
  }
}
