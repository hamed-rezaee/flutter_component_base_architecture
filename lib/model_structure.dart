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

  String getConstructorDefinition() =>
      '${isRequired ? 'required' : ''} this.$name,';

  String getFieldDefinition() => 'final $type${isNullable ? '?' : ''} $name;';

  static void sortModelStructures(List<ModelStructure> modelStructures) {
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
