import 'package:flutter_app_architecture/components.dart';

/// Show user information model.
class ShowUserInformationModel implements BaseModel {
  /// Initializes [ShowUserInformationModel].
  const ShowUserInformationModel({
    required this.name,
    this.birthdate,
  });

  /// Creates an instance from JSON.
  factory ShowUserInformationModel.fromJson(Map<String, dynamic> json) =>
      ShowUserInformationModel(
        name: json['name'],
        birthdate: json['birthdate'],
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

  @override
  List<Object?> get props => <Object?>[name, birthdate];

  @override
  bool? get stringify => false;

  @override
  String toString() => '$runtimeType(name: $name, birthdate: $birthdate)';
}
