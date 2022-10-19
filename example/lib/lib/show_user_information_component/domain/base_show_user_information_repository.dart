import 'package:flutter_app_architecture/components.dart';

import '../show_user_information_component.dart';

abstract class BaseShowUserInformationRepository extends BaseRepository {
  Future<ShowUserInformationEntity> fetchUserInformation();
}
