import 'package:flutter_app_architecture/components.dart';

import '../show_user_information_component.dart';

class ShowUserInformationService
    extends BaseService<ShowUserInformationEntity> {
  ShowUserInformationService(BaseShowUserInformationRepository repository)
      : super(repository);

  Future<ShowUserInformationEntity> fetchUserInformation() async =>
      ShowUserInformationEntity.map(
        await (repository as BaseShowUserInformationRepository)
            .fetchUserInformation(),
      );
}
