import 'extensions.dart';

/// Model structure class.
class ModelStructure {
  /// Initializes [ModelStructure].
  ModelStructure({
    required this.name,
    required this.type,
    required this.isNullable,
    required this.isRequired,
  });

  /// Model name.
  final String name;

  /// Model type.
  final Type type;

  /// indicates model is nullable or not.
  final bool isNullable;

  /// indicates model is required or not.
  final bool isRequired;

  /// Gets constructor definition.
  String get getConstructorDefinition =>
      '${isRequired ? 'required' : ''} this.$name,';

  /// Gets field definition.
  String get getFieldDefinition => 'final $type${isNullable ? '?' : ''} $name;';

  /// Gets from json definition.
  String get getFromJsonDefinition => '$name: json[\'${name.toSnakeCase}\'],';

  /// Gets to json definition.
  String get getToJsonDefinition => 'json[\'${name.toSnakeCase}\'] = $name;';
}
