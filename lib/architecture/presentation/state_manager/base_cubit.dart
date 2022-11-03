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
}
