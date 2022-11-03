import 'package:flutter_app_architecture/components.dart';

import '../show_user_information_component.dart';

/// Base show user information repository.
abstract class BaseShowUserInformationRepository
    implements
        BaseRepository<ShowUserInformationEntity, ShowUserInformationModel> {
  /// Initializes [BaseShowUserInformationRepository].
  BaseShowUserInformationRepository(this.mapper);

  @override
  final ShowUserInformationMapper mapper;

  Future<ShowUserInformationEntity> fetchUserInformation();
}
