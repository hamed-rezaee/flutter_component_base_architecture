import 'package:dart_style/dart_style.dart';
import 'package:recase/recase.dart';

extension StringExtension on String {
  String get toSnakeCase => ReCase(this).snakeCase;

  String get dartFormat {
    final DartFormatter formatter = DartFormatter(pageWidth: 80);

    return formatter.format(this);
  }
}
