#! /usr/bin/env dcli
// ignore_for_file: avoid_print

import 'package:dcli/dcli.dart';

import 'package:dart_app_architecture_cli/extensions.dart';

void main(List<String> args) => _generateComponent();

void _generateComponent() {
  print(blue('Deriv Component Generator:'));

  final String componentName = ask(
    green('# Enter component name'),
    validator: Ask.alpha,
    defaultValue: 'RegisterUser',
  );

  final bool confirmed = confirm(
    '${green('# Component name would be')} ${orange(componentName)}',
    defaultValue: true,
  );

  if (!confirmed) {
    return;
  }

  final String path =
      '${ask(green('# Enter component path'), defaultValue: './lib')}/${componentName.toSnakeCase}_component';

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
      dataPath: dataPath,
      componentName: componentName,
      repositoriesPath: repositoriesPath,
      domainPath: domainPath,
      presentationPath: presentationPath,
    );

    print(
      '${blue('Component ')}${orange(componentName)}${blue(' has been created successfully.')}',
    );
  } on Exception catch (e) {
    print(red('$e'));
  }
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
  required String dataPath,
  required String componentName,
  required String repositoriesPath,
  required String domainPath,
  required String presentationPath,
}) {
  _generateModel(path: dataPath, name: componentName);
  _generateRepository(path: repositoriesPath, name: componentName);

  _generateEntity(path: domainPath, name: componentName);
  _generateService(path: domainPath, name: componentName);
  _generateBaseRepository(path: domainPath, name: componentName);

  _generateCubit(path: presentationPath, name: componentName);
  _generateWidget(path: presentationPath, name: componentName);
}

void _generateModel({required String path, required String name}) {
  final String nameSnakeCase = name.toSnakeCase;

  '$path/${nameSnakeCase}_model.dart'.write(
    '''
      class ${name}Model {
        ${name}Model();
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

      class Base${name}Repository extends BaseRepository {}
    '''
        .dartFormat,
  );
}

void _generateRepository({required String path, required String name}) {
  final String nameSnakeCase = name.toSnakeCase;

  '$path/${nameSnakeCase}_repository.dart'.write(
    '''
      import '../../domain/base_${nameSnakeCase}_repository.dart';

      class ${name}Repository extends Base${name}Repository {}
    '''
        .dartFormat,
  );
}

void _generateEntity({required String path, required String name}) {
  final String nameSnakeCase = name.toSnakeCase;

  '$path/${nameSnakeCase}_repository.dart'.write(
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

void _generateService({required String path, required String name}) {
  final String nameSnakeCase = name.toSnakeCase;

  '$path/${nameSnakeCase}_service.dart'.write(
    '''
      import 'package:flutter_app_architecture/components.dart';

      import 'base_${nameSnakeCase}_repository.dart';
      import '${nameSnakeCase}_repository.dart';

      class ${name}Service extends BaseService<${name}Entity> {
        ${name}Service(Base${name}Repository repository) : super(repository);
      }
    '''
        .dartFormat,
  );
}

void _generateCubit({required String path, required String name}) {
  final String nameSnakeCase = name.toSnakeCase;

  '$path/${nameSnakeCase}_cubit.dart'.write(
    '''
      import 'package:flutter_app_architecture/components.dart';

      import '../domain/${nameSnakeCase}_repository.dart';
      import '../domain/${nameSnakeCase}_service.dart';
      
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

void _generateWidget({required String path, required String name}) {
  final String nameSnakeCase = name.toSnakeCase;

  '$path/${nameSnakeCase}_widget.dart'.write(
    '''
      import 'package:flutter/material.dart';

      import 'package:flutter_app_architecture/components.dart';

      import '../domain/${nameSnakeCase}_repository.dart';
      import '${nameSnakeCase}_cubit.dart';
      
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
