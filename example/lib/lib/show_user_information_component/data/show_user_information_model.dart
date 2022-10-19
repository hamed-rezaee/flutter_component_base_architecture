import '../show_user_information_component.dart';

class ShowUserInformationModel {
  ShowUserInformationModel(this.name, this.birthdate);

  factory ShowUserInformationModel.fromJson(Map<String, dynamic> json) =>
      ShowUserInformationModel(json['name'], json['birthdate']);

  ShowUserInformationEntity getEntity() =>
      ShowUserInformationEntity(name, DateTime.parse(birthdate));

  final String name;
  final String birthdate;
}
