import 'package:flutter_app_architecture/structure/data/base_mapper.dart';

import '../../show_user_information_component.dart';

/// Show user information repository.
class ShowUserInformationRepository
    implements BaseShowUserInformationRepository {
  ShowUserInformationRepository(this.mapper);

  @override
  final BaseMapper<ShowUserInformationEntity, ShowUserInformationModel> mapper;

  @override
  Future<ShowUserInformationEntity> fetchUserInformation() async {
    await Future<void>.delayed(const Duration(seconds: 2));

    return mapper.toEntity(
      ShowUserInformationModel.fromJson(
        <String, dynamic>{'name': 'John Doe', 'birthdate': '1985-11-11'},
      ),
    );
  }
}
