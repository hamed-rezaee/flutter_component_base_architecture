import 'package:example/lib/show_user_information_component/data/show_user_information_model.dart';
import 'package:flutter_app_architecture/components.dart';

class ShowUserInformationEntity extends BaseEntity {
  ShowUserInformationEntity(this.name, this.birthdate);

  factory ShowUserInformationEntity.getEntity(ShowUserInformationModel model) =>
      ShowUserInformationEntity(model.name, DateTime.parse(model.birthdate));

  final String name;
  final DateTime birthdate;

  @override
  String toString() => '$name($birthdate)';
}
