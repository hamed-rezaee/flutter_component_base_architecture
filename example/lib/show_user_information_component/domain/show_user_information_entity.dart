import 'package:flutter_app_architecture/components.dart';

/// Show user information entity.
class ShowUserInformationEntity implements BaseEntity {
  /// Initializes [ShowUserInformationEntity].
  const ShowUserInformationEntity({
    required this.name,
    this.birthdate,
  });

  /// Name.
  final String name;

  /// Birthdate.
  final DateTime? birthdate;

  @override
  List<Object?> get props => <Object?>[name, birthdate];

  @override
  bool? get stringify => false;

  @override
  String toString() => '$runtimeType(name: $name, birthdate: $birthdate)';
}
