#! /usr/bin/env dcli
// ignore_for_file: avoid_print

import 'package:dcli/dcli.dart';

import 'extensions.dart';
import 'generator.dart';
import 'model_structure.dart';
import 'types.dart';

void main(List<String> args) => _generateComponent();

void _generateComponent() {
  print(blue('Deriv Component Generator:'));

  String? componentName;

  while (componentName == null) {
    componentName = _getComponentName();
  }

  final String postfix = ask(
    green('# Enter component directory postfix'),
    defaultValue: 'component',
    validator: Ask.alpha,
  );

  final List<ModelStructure> modelStructures = _getFields();

  final String path =
      '${ask(green('# Enter component path'), defaultValue: './lib')}/${componentName.toSnakeCase}_$postfix';

  final String dataPath = '$path/data';
  final String mapperPath = '$path/data';
  final String repositoriesPath = '$dataPath/repositories';
  final String domainPath = '$path/domain';
  final String presentationPath = '$path/presentation';

  try {
    _createDirectories(
      path: path,
      dataPath: dataPath,
      repositoriesPath: repositoriesPath,
      domainPath: domainPath,
      presentationPath: presentationPath,
    );

    _generateComponents(
      path: path,
      dataPath: dataPath,
      mapperPath: mapperPath,
      componentName: componentName,
      repositoriesPath: repositoriesPath,
      domainPath: domainPath,
      presentationPath: presentationPath,
      postfix: postfix,
      modelStructures: modelStructures,
    );

    print(
      '${blue('Component ')}${orange(componentName)}${blue(' has been created successfully.')}',
    );
  } on Exception catch (e) {
    print(red('$e'));
  }
}

List<ModelStructure> _getFields() {
  final List<ModelStructure> modelStructures = <ModelStructure>[];

  while (confirm('${green('# Add model field')}')) {
    final String fieldName = ask(
      green('# Enter field name ${orange('(e.g. firstName)')}'),
      validator: Ask.alpha,
    );

    final String fieldType = ask(
      green('# Enter field type ${orange('${dartTypes.printKeys}')}'),
      validator: Ask.inList(dartTypes.keys.toList(), caseSensitive: true),
    );

    final bool isRequired = confirm(
      green('# Required'),
      defaultValue: true,
    );

    final bool isNullable = confirm(
      green('# Nullable'),
      defaultValue: false,
    );

    final ModelStructure modelStructure = ModelStructure(
      name: fieldName,
      type: dartTypes[fieldType.toLowerCase()]!,
      isRequired: isRequired,
      isNullable: isNullable,
    );

    modelStructures.add(modelStructure);
  }

  return modelStructures;
}

String? _getComponentName() {
  final String componentName = ask(
    green('# Enter component name'),
    defaultValue: 'RegisterUser',
    validator: Ask.alpha,
  );

  final bool confirmed = confirm(
    '${green('# Component name would be')} ${orange(componentName)}',
    defaultValue: true,
  );

  return confirmed ? componentName : null;
}

void _createDirectories({
  required String path,
  required String dataPath,
  required String repositoriesPath,
  required String domainPath,
  required String presentationPath,
}) {
  createDir(path, recursive: true);
  createDir(dataPath, recursive: true);
  createDir(repositoriesPath, recursive: true);
  createDir(domainPath, recursive: true);
  createDir(presentationPath, recursive: true);
}

void _generateComponents({
  required String path,
  required String dataPath,
  required String mapperPath,
  required String componentName,
  required String repositoriesPath,
  required String domainPath,
  required String presentationPath,
  required String postfix,
  required List<ModelStructure> modelStructures,
}) {
  _generateImports(path: path, name: componentName, postfix: postfix);

  // Data layer.
  _generateModel(
    path: dataPath,
    name: componentName,
    modelStructures: modelStructures,
  );
  _generateMapper(
    path: mapperPath,
    name: componentName,
    postfix: postfix,
  );
  _generateRepository(
    path: repositoriesPath,
    name: componentName,
    postfix: postfix,
  );

  // Domain layer.
  _generateEntity(
    path: domainPath,
    name: componentName,
    modelStructures: modelStructures,
    postfix: postfix,
  );
  _generateService(path: domainPath, name: componentName, postfix: postfix);
  _generateBaseRepository(
    path: domainPath,
    name: componentName,
    postfix: postfix,
  );

  // presentation layer.
  _generateCubit(path: presentationPath, name: componentName, postfix: postfix);
  _generateWidget(
    path: presentationPath,
    name: componentName,
    postfix: postfix,
  );
}

void _generateImports({
  required String path,
  required String name,
  required String postfix,
}) =>
    getFilePath(path: path, name: name, type: postfix)
        .write(getImportsStructure(name).dartFormat);

void _generateModel({
  required String path,
  required String name,
  required List<ModelStructure> modelStructures,
}) =>
    getFilePath(path: path, name: name, type: 'model').write(
      getModelStructure(
        name: name,
        modelStructures: modelStructures,
      ).dartFormat,
    );

void _generateMapper({
  required String path,
  required String name,
  required String postfix,
}) =>
    getFilePath(path: path, name: name, type: 'mapper').write(
      getMapperStructure(
        name: name,
        postfix: postfix,
      ).dartFormat,
    );

void _generateBaseRepository({
  required String path,
  required String name,
  required String postfix,
}) =>
    getFilePath(path: path, name: name, type: 'repository', isBase: true).write(
      getBaseRepositoryStructure(
        name: name,
        postfix: postfix,
      ).dartFormat,
    );

void _generateRepository({
  required String path,
  required String name,
  required String postfix,
}) =>
    getFilePath(path: path, name: name, type: 'repository')
        .write(getRepositoryStructure(name: name, postfix: postfix).dartFormat);

void _generateEntity({
  required String path,
  required String name,
  required String postfix,
  required List<ModelStructure> modelStructures,
}) =>
    getFilePath(path: path, name: name, type: 'entity').write(
      getEntityStructure(name: name, modelStructures: modelStructures)
          .dartFormat,
    );

void _generateService({
  required String path,
  required String name,
  required String postfix,
}) =>
    getFilePath(path: path, name: name, type: 'service')
        .write(getServiceStructure(name: name, postfix: postfix).dartFormat);

void _generateCubit({
  required String path,
  required String name,
  required String postfix,
}) =>
    getFilePath(path: path, name: name, type: 'cubit')
        .write(getCubitStructure(name: name, postfix: postfix).dartFormat);

void _generateWidget({
  required String path,
  required String name,
  required String postfix,
}) =>
    getFilePath(path: path, name: name, type: 'widget')
        .write(getWidgetStructure(name: name, postfix: postfix).dartFormat);
