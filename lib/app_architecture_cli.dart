#! /usr/bin/env dcli

import 'package:dcli/dcli.dart';

import 'package:dart_app_architecture_cli/extensions.dart';

void main(List<String> args) => _generateComponent();

void _generateComponent() {
  print(blue('*** Flutter Deriv Component Generator ***'));

  String componentName = ask(
    green('# Enter component name'),
    defaultValue: 'RegisterUser',
  );

  final confirmed = confirm(
    '${green('# Component name would be')} ${red(componentName)}',
    defaultValue: true,
  );

  if (!confirmed) {
    return;
  }

  final String path = ask(
    green('# Enter component path'),
    defaultValue: './lib/${componentName.toSnakeCase}_component',
  );

  final String dataPath = '$path/data';
  final String repositoriesPath = '$path/repositories';
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
  } on Exception catch (e) {
    print(red('$e'));
  }

  print(
    '${blue('Component ')}${red(componentName)}${blue(' has been created successfully.')} 🎉 🎉 🎉',
  );
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

  _generateCubit(path: presentationPath, name: componentName);
  _generateWidget(path: presentationPath, name: componentName);
}

void _generateModel({required String path, required String name}) {
  '$path/${name.toSnakeCase}_model.dart'.write(
    '''
      class ${name}Model {
        ${name}Model();
      }
    '''
        .dartFormat,
  );
}

void _generateRepository({required String path, required String name}) {
  '$path/base_${name.toSnakeCase}_repository.dart'.write(
    '''
      import 'package:flutter_app_architecture/structure/data/base_repository.dart';

      class Base${name}Repository extends BaseRepository {}
    '''
        .dartFormat,
  );

  '$path/${name.toSnakeCase}_repository.dart'.write(
    '''
      class Base${name}Repository extends Base${name}Repository {}
    '''
        .dartFormat,
  );
}

void _generateEntity({required String path, required String name}) {
  '$path/${name.toSnakeCase}_repository.dart'.write(
    '''
      import 'package:flutter_app_architecture/structure/domain/base_entity.dart';

      class ${name}Entity extends BaseEntity {
        ${name}Entity();

        @override
        String toString() => throw UnimplementedError();  
      }
    '''
        .dartFormat,
  );
}

_generateService({required String path, required String name}) {
  '$path/${name.toSnakeCase}_service.dart'.write(
    '''
      import 'package:flutter_app_architecture/structure/domain/base_service.dart';

      class ${name}Service extends BaseService<${name}Entity> {
        ${name}Service(Base${name}Repository repository) : super(repository);
      }
    '''
        .dartFormat,
  );
}

_generateCubit({required String path, required String name}) {
  '$path/${name.toSnakeCase}_cubit.dart'.write(
    '''
      import 'package:flutter_app_architecture/structure/presentation/state_manager/base_cubit.dart';
      import 'package:flutter_app_architecture/structure/presentation/state_manager/base_state.dart';
      import 'package:flutter_app_architecture/structure/presentation/state_manager/base_state_status.dart';

      class ${name}Cubit extends BaseCubit<${name}Entity> {
        ${name}Cubit({required ${name}Service service})
            : super(
                service: service,
                initialState: BaseState<${name}Entity>(status: BaseStateStatus.initial),
              );
      }
    '''
        .dartFormat,
  );
}

_generateWidget({required String path, required String name}) {
  '$path/${name.toSnakeCase}_widget.dart'.write(
    '''
      import 'package:flutter/material.dart';

      import 'package:flutter_app_architecture/structure/domain/base_entity.dart';
      import 'package:flutter_app_architecture/structure/presentation/base_widget.dart';
      import 'package:flutter_app_architecture/structure/presentation/state_manager/base_state.dart';

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
