import 'package:equatable/equatable.dart';

class CompanyEntity extends Equatable {
  final int? id;
  final String? logoPath;
  final String? name;

  const CompanyEntity({
    this.id,
    this.logoPath,
    this.name,
  });

  @override
  List<Object?> get props => [
        id,
        logoPath,
        name,
      ];
}
