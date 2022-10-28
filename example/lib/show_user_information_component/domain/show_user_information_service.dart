import 'package:flutter_app_architecture/components.dart';

import '../show_user_information_component.dart';

/// Show user information service.
class ShowUserInformationService
    extends BaseService<ShowUserInformationEntity> {
  /// Initializes [ShowUserInformationService].
  ShowUserInformationService(BaseShowUserInformationRepository repository)
      : super(repository);

  Future<ShowUserInformationEntity> fetchUserInformation() async =>
      (repository as BaseShowUserInformationRepository).fetchUserInformation();
}
