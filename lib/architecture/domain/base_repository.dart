import 'package:flutter_app_architecture/components.dart';

/// Base class for all component repositories.
abstract class BaseRepository<Entity extends BaseEntity,
    Model extends BaseModel> {
  /// Initializes [BaseRepository].
  BaseRepository(this.mapper);

  /// [BaseMapper] instance.
  final BaseMapper<Entity, Model> mapper;
}
