import 'package:flutter_app_architecture/components.dart';

import '../show_user_information_component.dart';

/// Show user information service.
class ShowUserInformationService
    implements
        BaseService<ShowUserInformationEntity, ShowUserInformationModel> {
  /// Initializes [ShowUserInformationService].
  const ShowUserInformationService(this.repository);

  @override
  final BaseShowUserInformationRepository repository;

  Future<ShowUserInformationEntity> fetchUserInformation() async =>
      repository.fetchUserInformation();
}
