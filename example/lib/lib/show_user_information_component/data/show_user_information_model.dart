class ShowUserInformationModel {
  ShowUserInformationModel(this.name, this.birthdate);

  factory ShowUserInformationModel.fromJson(Map<String, dynamic> json) =>
      ShowUserInformationModel(json['name'], json['birthdate']);

  final String name;
  final String birthdate;
}
