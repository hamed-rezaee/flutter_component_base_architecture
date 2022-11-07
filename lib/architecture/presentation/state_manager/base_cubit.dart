import 'dart:developer' as dev;

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app_architecture/components.dart';

/// Base class for all component cubits.
abstract class BaseCubit<Entity extends BaseEntity, Model extends BaseModel>
    extends Cubit<BaseState<Entity>> {
  /// Initializes [BaseCubit].
  BaseCubit({
    required BaseState<Entity> initialState,
    this.service,
  }) : super(initialState);

  /// [BaseService] instance.
  final BaseService<Entity, Model>? service;

  /// Handles states of UI based on process status.
  Future<Entity?> updateState(Future<Entity> Function() process) async {
    emit(BaseState<Entity>(status: BaseStateStatus.loading));

    try {
      final Entity result = await process();

      emit(BaseState<Entity>(status: BaseStateStatus.success, data: result));

      return result;
    } on Exception catch (error) {
      emit(
        BaseState<Entity>(
          status: BaseStateStatus.failure,
          data: state.data,
          error: error,
        ),
      );

      dev.log('$runtimeType error: $error');

      rethrow;
    }
  }
}
