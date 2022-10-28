import '../show_user_information_component.dart';

/// Show user information model.
class ShowUserInformationModel {
  /// Initializes [ShowUserInformationModel].
  ShowUserInformationModel({
    required this.name,
    this.birthdate,
  });

  /// Creates an instance from JSON.
  factory ShowUserInformationModel.fromJson(Map<String, dynamic> json) =>
      ShowUserInformationModel(
        name: json['name'],
        birthdate: json['birthdate'],
      );

  /// Creates an instance from [ShowUserInformationEntity].
  factory ShowUserInformationModel.fromEntity(
          ShowUserInformationEntity entity) =>
      ShowUserInformationModel(
        name: entity.name,
        birthdate: entity.birthdate?.toString(),
      );

  /// Name.
  final String name;

  /// Birthdate.
  final String? birthdate;

  //// Converts an instance to JSON.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};

    json['name'] = name;
    json['birthdate'] = birthdate;

    return json;
  }

  /// Converts an instance to [ShowUserInformationEntity].
  ShowUserInformationEntity toEntity() => ShowUserInformationEntity(
        name: name,
        birthdate: birthdate == null ? null : DateTime.parse(birthdate!),
      );
}
