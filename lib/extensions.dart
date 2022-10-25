import 'package:dart_style/dart_style.dart';
import 'package:recase/recase.dart';

/// String extensions.
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
