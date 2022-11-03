import 'package:equatable/equatable.dart';

import 'package:flutter_app_architecture/components.dart';

/// Base class for all component states.
class BaseState<Entity extends BaseEntity> with EquatableMixin {
  /// Initializes [BaseState].
  BaseState({required this.status, this.data, this.error});

  /// Status of state.
  BaseStateStatus status;

  /// Data of state.
  Entity? data;

  /// Error of state.
  String? error;

  @override
  List<Object?> get props => <Object?>[data, status, error];

  @override
  bool? get stringify => true;
}
