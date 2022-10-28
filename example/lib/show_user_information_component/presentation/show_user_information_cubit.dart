import 'dart:math';

import 'package:flutter_app_architecture/components.dart';

import '../show_user_information_component.dart';

/// Show user information cubit.
class ShowUserInformationCubit extends BaseCubit<ShowUserInformationEntity> {
  /// Initializes [ShowUserInformationCubit].
  ShowUserInformationCubit({ShowUserInformationService? service})
      : super(
          service: service,
          initialState: BaseState<ShowUserInformationEntity>(
            status: BaseStateStatus.initial,
          ),
        );

  Future<void> fetchUserInformation() async {
    emit(BaseState<ShowUserInformationEntity>(status: BaseStateStatus.loading));

    final ShowUserInformationEntity result =
        await (service as ShowUserInformationService).fetchUserInformation();

    final bool isFailed = Random().nextBool();

    if (isFailed) {
      emit(
        BaseState<ShowUserInformationEntity>(
          status: BaseStateStatus.failure,
          error: 'RANDOM ERROR :(',
        ),
      );
    } else {
      emit(
        BaseState<ShowUserInformationEntity>(
          status: BaseStateStatus.success,
          data: result,
        ),
      );
    }
  }
}
