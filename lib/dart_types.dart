/// Dart types map.
final Map<String, Type> dartTypes = <String, Type>{
  'bool': bool,
  'num': num,
  'int': int,
  'double': double,
  'string': String,
  'list': List,
  'set': Set,
  'date time': DateTime,
  'object': Object,
  'dynamic': dynamic,
};

/// Extension on Map<String, Type>.
extension MapExtension on Map<String, Type> {
  /// Prints keys of a Map<String, Type>.
  String get printKeys => keys.fold(
        '',
        (String previousValue, String element) =>
            '$previousValue${previousValue == '' ? '' : ' | '}$element',
      );
}
