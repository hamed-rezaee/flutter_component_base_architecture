import 'package:flutter_app_architecture/components.dart';

/// Base class for all component mappers.
abstract class BaseMapper<Entity extends BaseEntity, Model extends BaseModel> {
  /// Creates a [Model] instance from a [Entity].
  Model fromEntity(Entity entity);

  /// Creates a [Entity] instance from a [Model].
  Entity toEntity(Model model);
}
