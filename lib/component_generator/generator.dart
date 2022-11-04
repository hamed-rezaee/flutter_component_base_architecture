import 'extensions.dart';
import 'model_structure.dart';

/// Gets file path.
String getFilePath({
  required String path,
  required String name,
  required String type,
  bool isBase = false,
}) =>
    '$path/${isBase ? 'base_' : ''}${name.toSnakeCase}_$type.dart';

/// Gets component imports structure.
String getImportsStructure(String name) => '''
    export 'data/repositories/${name.toSnakeCase}_repository.dart';
    export 'data/${name.toSnakeCase}_mapper.dart';
    export 'data/${name.toSnakeCase}_model.dart';
    export 'domain/base_${name.toSnakeCase}_repository.dart';
    export 'domain/${name.toSnakeCase}_entity.dart';
    export 'domain/${name.toSnakeCase}_service.dart';
    export 'presentation/${name.toSnakeCase}_cubit.dart';
    export 'presentation/${name.toSnakeCase}_widget.dart';
  ''';

/// Gets model structure.
String getModelStructure({
  required String name,
  required List<ModelStructure> modelStructures,
}) =>
    '''
      import 'package:flutter_app_architecture/components.dart';

      /// ${name.toSentenceCase} model.
      class ${name}Model implements BaseModel {
        ${_generateConstructor(name: name, modelStructures: modelStructures)}

        ${_generateFromJson(name: name, modelStructures: modelStructures)}

        ${_generateFields(modelStructures)}

        ${_generateToJson(name: name, modelStructures: modelStructures)}

        ${_getEquatableMixinMethods(modelStructures)}
      }
    ''';

/// Gets base repository structure.
String getBaseRepositoryStructure({
  required String name,
  required String postfix,
}) =>
    '''
      import 'package:flutter_app_architecture/components.dart';

      import '../${name.toSnakeCase}_$postfix.dart';

      /// Base ${name.toSentenceLowerCase} repository.
      abstract class Base${name}Repository implements BaseRepository<${name}Entity, ${name}Model> {
        /// Initializes [Base${name}Repository].
        Base${name}Repository(this.mapper);

        @override
        final ${name}Mapper mapper;
      }
  ''';

/// Gets repository structure.
String getRepositoryStructure({
  required String name,
  required String postfix,
}) =>
    '''
      import '../../${name.toSnakeCase}_$postfix.dart';

      /// ${name.toSentenceCase} repository.
      class ${name}Repository implements Base${name}Repository {
        /// Initializes [${name}Repository].
        ${name}Repository(this.mapper);

        @override
        final ${name}Mapper mapper;
      }
    ''';

/// Gets mapper structure.
String getMapperStructure({
  required String name,
  required String postfix,
}) =>
    '''
      import 'package:flutter_app_architecture/components.dart';

      import '../${name.toSnakeCase}_$postfix.dart';

      /// ${name.toSentenceCase} mapper.
      class ${name}Mapper implements BaseMapper<${name}Entity, ${name}Model> {
        @override
        ${name}Model fromEntity(${name}Entity entity) => throw UnimplementedError();

        @override
        ${name}Entity toEntity(${name}Model model) => throw UnimplementedError();
      }
    ''';

/// Gets entity structure.
String getEntityStructure({
  required String name,
  required List<ModelStructure> modelStructures,
}) =>
    '''
      import 'package:flutter_app_architecture/components.dart';

      /// ${name.toSentenceCase} entity.
      class ${name}Entity implements BaseEntity {
        ${_generateConstructor(name: name, modelStructures: modelStructures, isModel: false)}

        ${_generateFields(modelStructures)}

        ${_getEquatableMixinMethods(modelStructures)}
      }
    ''';

/// Gets service structure.
String getServiceStructure({required String name, required String postfix}) =>
    '''
      import 'package:flutter_app_architecture/components.dart';

      import '../${name.toSnakeCase}_$postfix.dart';

      /// ${name.toSentenceCase} service.
      class ${name}Service implements BaseService<${name}Entity, ${name}Model> {
        /// Initializes [${name}Service].
        ${name}Service(this.repository);

        @override
        final Base${name}Repository repository;
      }
    ''';

/// Gets cubit structure.
String getCubitStructure({required String name, required String postfix}) => '''
      import 'package:flutter_app_architecture/components.dart';

      import '../${name.toSnakeCase}_$postfix.dart';
      
      /// ${name.toSentenceCase} cubit.
      class ${name}Cubit extends BaseCubit<${name}Entity, ${name}Model> {
        /// Initializes [${name}Cubit].
        ${name}Cubit({
          required BaseState<${name}Entity> initialState,
          ${name}Service? service,
        }) : super(service: service, initialState: initialState);
      }
    ''';

/// Gets widget structure.
String getWidgetStructure({required String name, required String postfix}) =>
    '''
      import 'package:flutter/material.dart';

      import 'package:flutter_app_architecture/components.dart';

      import '../${name.toSnakeCase}_$postfix.dart';
      
      /// ${name.toSentenceCase} widget.
      class ${name}Widget extends StatelessWidget {
        @override
        Widget build(BuildContext context) => BaseWidget<${name}Entity, ${name}Model, ${name}Cubit>(
          initialWidgetBuilder:
            (BuildContext context, BaseState<BaseEntity> state) => throw UnimplementedError(),
          loadingWidgetBuilder:
            (BuildContext context, BaseState<BaseEntity> state) => throw UnimplementedError(),
          successWidgetBuilder:
            (BuildContext context, BaseState<BaseEntity> state) => throw UnimplementedError(),
          errorWidgetBuilder:
            (BuildContext context, BaseState<BaseEntity> state) => throw UnimplementedError(),
        );
      }
    ''';

String _generateConstructor({
  required String name,
  required List<ModelStructure> modelStructures,
  bool isModel = true,
}) {
  modelStructures.sortModelStructures();

  final StringBuffer body = StringBuffer();

  for (final ModelStructure modelStructure in modelStructures) {
    body.write(modelStructure.getConstructorDefinition);
  }

  return '''
    /// Initializes [$name${isModel ? 'Model' : 'Entity'}].
    $name${isModel ? 'Model' : 'Entity'}({$body});
  ''';
}

String _generateFromJson({
  required String name,
  required List<ModelStructure> modelStructures,
}) {
  modelStructures.sortModelStructures();

  final StringBuffer body = StringBuffer();

  for (final ModelStructure modelStructure in modelStructures) {
    body.write(modelStructure.getFromJsonDefinition);
  }

  return '''
    /// Creates an instance from JSON.
    factory ${name}Model.fromJson(Map<String, dynamic> json) => ${name}Model($body);
  ''';
}

String _generateToJson({
  required String name,
  required List<ModelStructure> modelStructures,
}) {
  modelStructures.sortModelStructures();

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

String _generateFields(List<ModelStructure> modelStructures) {
  modelStructures.sortModelStructures();

  final StringBuffer body = StringBuffer();

  for (final ModelStructure modelStructure in modelStructures) {
    body
      ..write('/// ${modelStructure.name.toSentenceCase}.\n')
      ..write(modelStructure.getFieldDefinition);
  }

  return '$body';
}

String _getEquatableMixinMethods(List<ModelStructure> modelStructures) => '''
      @override
      List<Object?> get props => <Object?>[${_getSeparatedFieldNames(modelStructures)}];

      @override
      bool get stringify => true;
    ''';

String _getSeparatedFieldNames(
  List<ModelStructure> modelStructures, [
  String separator = ',',
]) =>
    (modelStructures..sortModelStructures())
        .map<String>((ModelStructure element) => element.name)
        .fold(
          '',
          (String previousValue, String element) =>
              '$previousValue${previousValue == '' ? '' : '$separator'}$element',
        );
