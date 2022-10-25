import 'package:dart_app_architecture_cli/extensions.dart';

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

  /// Gets from entity definition.
  String get getFromEntityDefinition => '$name: entity.$name,';

  /// Gets to json definition.
  String get getToJsonDefinition => 'json[\'${name.toSnakeCase}\'] = $name;';

  /// Gets to entity definition.
  String get getToEntityDefinition => '$name: $name,';

  /// Generates model constructor.
  static String generateConstructor({
    required String name,
    required List<ModelStructure> modelStructures,
  }) {
    _sortModelStructures(modelStructures);

    final StringBuffer body = StringBuffer();

    for (final ModelStructure modelStructure in modelStructures) {
      body.write(modelStructure.getConstructorDefinition);
    }

    return '''
      /// Initializes [${name}Model].
      ${name}Model({$body});
    ''';
  }

  /// Generates form json method.
  static String generateFromJson({
    required String name,
    required List<ModelStructure> modelStructures,
  }) {
    _sortModelStructures(modelStructures);

    final StringBuffer body = StringBuffer();

    for (final ModelStructure modelStructure in modelStructures) {
      body.write(modelStructure.getFromJsonDefinition);
    }

    return '''
      /// Creates an instance from JSON.
      factory ${name}Model.fromJson(Map<String, dynamic> json) =>
        ${name}Model($body);
    ''';
  }

  /// Generates form entity method.
  static String generateFromEntity({
    required String name,
    required List<ModelStructure> modelStructures,
  }) {
    _sortModelStructures(modelStructures);

    final StringBuffer body = StringBuffer();

    for (final ModelStructure modelStructure in modelStructures) {
      body.write(modelStructure.getFromEntityDefinition);
    }

    return '''
      /// Creates an instance from [${name}Entity].
      factory ${name}Model.fromEntity(${name}Entity entity) =>
        ${name}Model($body);
    ''';
  }

  /// Generates to json method.
  static String generateToJson({
    required String name,
    required List<ModelStructure> modelStructures,
  }) {
    _sortModelStructures(modelStructures);

    final StringBuffer body = StringBuffer();

    for (final ModelStructure modelStructure in modelStructures) {
      body.write(modelStructure.getToJsonDefinition);
    }

    return '''
      //// Converts an instance to JSON.
      Map<String, dynamic> toJson() {
        final Map<String, dynamic> json = <String, dynamic>{};

        $body

        return json;
      }
    ''';
  }

  /// Generates to entity method.
  static String generateToEntity({
    required String name,
    required List<ModelStructure> modelStructures,
  }) {
    _sortModelStructures(modelStructures);

    final StringBuffer body = StringBuffer();

    for (final ModelStructure modelStructure in modelStructures) {
      body.write(modelStructure.getToEntityDefinition);
    }

    return '''
      /// Converts an instance to [${name}Entity].
      ${name}Entity toEntity() =>
        ${name}Entity($body);
    ''';
  }

  /// Generates model fields.
  static String generateFields(List<ModelStructure> modelStructures) {
    _sortModelStructures(modelStructures);

    final StringBuffer body = StringBuffer();

    for (final ModelStructure modelStructure in modelStructures) {
      body
        ..write('/// ${modelStructure.name.toSentenceCase}.\n')
        ..write(modelStructure.getFieldDefinition);
    }

    return '$body';
  }

  static void _sortModelStructures(List<ModelStructure> modelStructures) {
    final List<ModelStructure> requiredModels = modelStructures
        .where((ModelStructure element) => element.isRequired)
        .toList();

    final List<ModelStructure> nounRequiredModels = modelStructures
        .where((ModelStructure element) => !element.isRequired)
        .toList();

    requiredModels.sort(
      (ModelStructure first, ModelStructure second) =>
          first.name.compareTo(second.name),
    );

    nounRequiredModels.sort(
      (ModelStructure first, ModelStructure second) =>
          first.name.compareTo(second.name),
    );

    modelStructures
      ..clear()
      ..addAll(requiredModels)
      ..addAll(nounRequiredModels);
  }
}

/// Dart types map.
final Map<String, Type> dartTypes = <String, Type>{
  'bool': bool,
  'int': int,
  'double': double,
  'string': String,
  'list': List,
  'set': Set,
};
