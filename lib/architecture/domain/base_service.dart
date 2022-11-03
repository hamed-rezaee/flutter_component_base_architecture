import 'package:flutter_app_architecture/components.dart';

/// Base class for all component services.
abstract class BaseService<Entity extends BaseEntity, Model extends BaseModel> {
  /// Initializes [BaseService].
  BaseService(this.repository);

  /// [BaseRepository] instance.
  final BaseRepository<Entity, Model> repository;
}
