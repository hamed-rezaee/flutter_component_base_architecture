import 'package:recase/recase.dart';

extension StringExtension on String {
  String get toSnakeCase => ReCase(this).snakeCase;
}
