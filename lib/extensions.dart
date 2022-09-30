import 'package:recase/recase.dart';

extension StringExtension on String {
  String get toCamelCase => ReCase(this).camelCase;
}
