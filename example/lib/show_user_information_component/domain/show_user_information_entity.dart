import 'package:flutter_app_architecture/components.dart';

class ShowUserInformationEntity extends BaseEntity {
  ShowUserInformationEntity(this.name, this.birthdate);

  final String name;
  final DateTime birthdate;

  @override
  String toString() => '$name($birthdate)';
}
