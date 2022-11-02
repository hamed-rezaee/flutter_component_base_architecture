import 'package:equatable/equatable.dart';

import 'package:flutter_app_architecture/components.dart';

/// Show user information entity.
class ShowUserInformationEntity with EquatableMixin implements BaseEntity {
  /// Initializes [ShowUserInformationEntity].
  ShowUserInformationEntity({
    required this.name,
    this.birthdate,
  });

  /// Name.
  final String name;

  /// Birthdate.
  final DateTime? birthdate;

  @override
  List<Object?> get props => <Object?>[birthdate, name];

  @override
  bool get stringify => true;
}
