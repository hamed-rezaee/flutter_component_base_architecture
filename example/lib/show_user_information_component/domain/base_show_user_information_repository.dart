import 'package:flutter_app_architecture/components.dart';

import '../show_user_information_component.dart';

/// Base show user information repository.
abstract class BaseShowUserInformationRepository
    implements
        BaseRepository<ShowUserInformationEntity, ShowUserInformationModel> {
  BaseShowUserInformationRepository(this.mapper);

  @override
  final BaseMapper<ShowUserInformationEntity, ShowUserInformationModel> mapper;

  Future<ShowUserInformationEntity> fetchUserInformation();
}
