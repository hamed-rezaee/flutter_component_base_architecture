import 'package:flutter_app_architecture/components.dart';

import '../show_user_information_component.dart';

/// Show user information mapper.
class ShowUserInformationMapper
    implements BaseMapper<ShowUserInformationEntity, ShowUserInformationModel> {
  @override
  ShowUserInformationModel fromEntity(ShowUserInformationEntity entity) =>
      ShowUserInformationModel(
        name: entity.name,
        birthdate: entity.birthdate?.toString(),
      );

  @override
  ShowUserInformationEntity toEntity(ShowUserInformationModel model) =>
      ShowUserInformationEntity(
        name: model.name,
        birthdate:
            model.birthdate == null ? null : DateTime.parse(model.birthdate!),
      );
}
