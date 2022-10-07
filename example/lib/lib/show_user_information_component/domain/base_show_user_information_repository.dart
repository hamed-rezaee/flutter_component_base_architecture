import 'package:flutter_app_architecture/components.dart';

import '../data/show_user_information_model.dart';

abstract class BaseShowUserInformationRepository extends BaseRepository {
  Future<ShowUserInformationModel> fetchUserInformation();
}
