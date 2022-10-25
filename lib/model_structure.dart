class ModelStructure {
  ModelStructure({
    required this.name,
    required this.type,
    required this.isNullable,
    required this.isRequired,
  });

  final String name;
  final Type type;
  final bool isNullable;
  final bool isRequired;

  String get getConstructorDefinition =>
      '${isRequired ? 'required' : ''} this.$name,';

  String get getFieldDefinition => 'final $type${isNullable ? '?' : ''} $name;';

  static String generateConstructor({
    required String name,
    required List<ModelStructure> modelStructures,
  }) {
    _sortModelStructures(modelStructures);

    final StringBuffer body = StringBuffer();

    for (final ModelStructure modelStructure in modelStructures) {
      body.write(modelStructure.getConstructorDefinition);
    }

    return '${name}Model({$body});';
  }

  static String generateFields(List<ModelStructure> modelStructures) {
    _sortModelStructures(modelStructures);

    final StringBuffer body = StringBuffer();

    for (final ModelStructure modelStructure in modelStructures) {
      body.write(modelStructure.getFieldDefinition);
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

final Map<String, Type> dartTypes = <String, Type>{
  'bool': bool,
  'int': int,
  'double': double,
  'string': String,
  'list': List,
  'set': Set,
};
