import '../../show_user_information_component.dart';

class ShowUserInformationRepository extends BaseShowUserInformationRepository {
  @override
  Future<ShowUserInformationModel> fetchUserInformation() async {
    await Future<void>.delayed(const Duration(seconds: 2));

    return ShowUserInformationModel.fromJson(
      <String, dynamic>{'name': 'John Doe', 'birthdate': '1985-11-11'},
    );
  }
}
