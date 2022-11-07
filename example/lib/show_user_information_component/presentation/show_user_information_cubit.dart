import 'package:flutter_app_architecture/components.dart';

import '../show_user_information_component.dart';

/// Show user information cubit.
class ShowUserInformationCubit
    extends BaseCubit<ShowUserInformationEntity, ShowUserInformationModel> {
  /// Initializes [ShowUserInformationCubit].
  ShowUserInformationCubit({
    required BaseState<ShowUserInformationEntity> initialState,
    ShowUserInformationService? service,
  }) : super(service: service, initialState: initialState);

  Future<void> fetchUserInformation() =>
      updateState((service as ShowUserInformationService).fetchUserInformation);
}
