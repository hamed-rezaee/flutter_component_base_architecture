#! /usr/bin/env dcli
// ignore_for_file: avoid_print

import 'package:dcli/dcli.dart';

import 'extensions.dart';

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

  final String path =
      '${ask(green('# Enter component path'), defaultValue: './lib')}/${componentName.toSnakeCase}_$postfix';

  final String dataPath = '$path/data';
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
      componentName: componentName,
      repositoriesPath: repositoriesPath,
      domainPath: domainPath,
      presentationPath: presentationPath,
      postfix: postfix,
    );

    print(
      '${blue('Component ')}${orange(componentName)}${blue(' has been created successfully.')}',
    );
  } on Exception catch (e) {
    print(red('$e'));
  }
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
  required String componentName,
  required String repositoriesPath,
  required String domainPath,
  required String presentationPath,
  required String postfix,
}) {
  _generateImports(path: path, name: componentName, postfix: postfix);

  _generateModel(path: dataPath, name: componentName);
  _generateRepository(
    path: repositoriesPath,
    name: componentName,
    postfix: postfix,
  );

  _generateEntity(path: domainPath, name: componentName, postfix: postfix);
  _generateService(path: domainPath, name: componentName, postfix: postfix);
  _generateBaseRepository(path: domainPath, name: componentName);

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
}) {
  final String nameSnakeCase = name.toSnakeCase;

  '$path/${nameSnakeCase}_$postfix.dart'.write(
    '''
      export 'data/${nameSnakeCase}_model.dart';
      export 'data/repositories/${nameSnakeCase}_repository.dart';
      export 'domain/base_${nameSnakeCase}_repository.dart';
      export 'domain/${nameSnakeCase}_entity.dart';
      export 'domain/${nameSnakeCase}_service.dart';
      export 'presentation/${nameSnakeCase}_cubit.dart';
      export 'presentation/${nameSnakeCase}_widget.dart';
    '''
        .dartFormat,
  );
}

void _generateModel({required String path, required String name}) {
  final String nameSnakeCase = name.toSnakeCase;

  '$path/${nameSnakeCase}_model.dart'.write(
    '''
      import '../${nameSnakeCase}_component.dart';

      class ${name}Model {
        ${name}Model();

        factory ${name}Model.fromJson(Map<String, dynamic> json) =>
          throw UnimplementedError();

        ${name}Entity getEntity() =>
          throw UnimplementedError();
      }
    '''
        .dartFormat,
  );
}

void _generateBaseRepository({required String path, required String name}) {
  final String nameSnakeCase = name.toSnakeCase;

  '$path/base_${nameSnakeCase}_repository.dart'.write(
    '''
      import 'package:flutter_app_architecture/components.dart';

      abstract class Base${name}Repository extends BaseRepository {}
    '''
        .dartFormat,
  );
}

void _generateRepository({
  required String path,
  required String name,
  required String postfix,
}) {
  final String nameSnakeCase = name.toSnakeCase;

  '$path/${nameSnakeCase}_repository.dart'.write(
    '''
      import '../../${nameSnakeCase}_$postfix.dart';

      class ${name}Repository extends Base${name}Repository {}
    '''
        .dartFormat,
  );
}

void _generateEntity({
  required String path,
  required String name,
  required String postfix,
}) {
  final String nameSnakeCase = name.toSnakeCase;

  '$path/${nameSnakeCase}_entity.dart'.write(
    '''
      import 'package:flutter_app_architecture/components.dart';

      class ${name}Entity extends BaseEntity {
        ${name}Entity();

        @override
        String toString() => throw UnimplementedError();  
      }
    '''
        .dartFormat,
  );
}

void _generateService({
  required String path,
  required String name,
  required String postfix,
}) {
  final String nameSnakeCase = name.toSnakeCase;

  '$path/${nameSnakeCase}_service.dart'.write(
    '''
      import 'package:flutter_app_architecture/components.dart';

      import '../${nameSnakeCase}_$postfix.dart';

      class ${name}Service extends BaseService<${name}Entity> {
        ${name}Service(Base${name}Repository repository) : super(repository);
      }
    '''
        .dartFormat,
  );
}

void _generateCubit({
  required String path,
  required String name,
  required String postfix,
}) {
  final String nameSnakeCase = name.toSnakeCase;

  '$path/${nameSnakeCase}_cubit.dart'.write(
    '''
      import 'package:flutter_app_architecture/components.dart';

      import '../${nameSnakeCase}_$postfix.dart';
      
      class ${name}Cubit extends BaseCubit<${name}Entity> {
        ${name}Cubit({${name}Service? service})
            : super(
                service: service,
                initialState: BaseState<${name}Entity>(status: BaseStateStatus.initial),
              );
      }
    '''
        .dartFormat,
  );
}

void _generateWidget({
  required String path,
  required String name,
  required String postfix,
}) {
  final String nameSnakeCase = name.toSnakeCase;

  '$path/${nameSnakeCase}_widget.dart'.write(
    '''
      import 'package:flutter/material.dart';

      import 'package:flutter_app_architecture/components.dart';

      import '../${nameSnakeCase}_$postfix.dart';
      
      class ${name}Widget extends StatelessWidget {
        @override
        Widget build(BuildContext context) => BaseWidget<${name}Entity, ${name}Cubit>(
              loadingWidgetBuilder:
                  (BuildContext context, BaseState<BaseEntity> state) =>
                      throw UnimplementedError(),
              successWidgetBuilder:
                  (BuildContext context, BaseState<BaseEntity> state) =>
                      throw UnimplementedError(),
              errorWidgetBuilder:
                  (BuildContext context, BaseState<BaseEntity> state) =>
                      throw UnimplementedError(),
            );
      }
    '''
        .dartFormat,
  );
}