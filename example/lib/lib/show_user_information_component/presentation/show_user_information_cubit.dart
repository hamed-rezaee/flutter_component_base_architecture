import 'dart:math';

import 'package:flutter_app_architecture/components.dart';

import '../domain/show_user_information_repository.dart';
import '../domain/show_user_information_service.dart';

class ShowUserInformationCubit extends BaseCubit<ShowUserInformationEntity> {
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
          error: 'RANDOM FAILURE!!!',
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
