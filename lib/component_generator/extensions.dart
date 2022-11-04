import 'package:dart_style/dart_style.dart';
import 'package:recase/recase.dart';

import 'model_structure.dart';

/// [String] extensions.
extension StringExtension on String {
  /// Recase string to snake case.
  String get toSnakeCase => ReCase(this).snakeCase;

  /// Recase string to sentence case.
  String get toSentenceCase => ReCase(this).sentenceCase;

  /// Recase string to sentence lower case.
  String get toSentenceLowerCase => ReCase(this).sentenceCase.toLowerCase();

  /// Formats string to dart code.
  String get dartFormat => DartFormatter(pageWidth: 80).format(this);
}

/// List of [ModelStructure] extensions.
extension ModelStructureSort on List<ModelStructure> {
  /// Sorts a list of [ModelStructure]s.
  void sortModelStructures() {
    final List<ModelStructure> requiredModels =
        where((ModelStructure element) => element.isRequired).toList();

    final List<ModelStructure> nounRequiredModels =
        where((ModelStructure element) => !element.isRequired).toList();

    requiredModels.sort(
      (ModelStructure first, ModelStructure second) =>
          first.name.compareTo(second.name),
    );

    nounRequiredModels.sort(
      (ModelStructure first, ModelStructure second) =>
          first.name.compareTo(second.name),
    );

    this
      ..clear()
      ..addAll(requiredModels)
      ..addAll(nounRequiredModels);
  }
}
