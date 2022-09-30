#! /usr/bin/env dcli

import 'package:dcli/dcli.dart';

import 'package:dart_app_architecture_cli/extensions.dart';

void main(List<String> args) {
  print('Flutter Deriv Component Generator... 💪');

  String componentName = ask('# enter component name [example: RegisterUser]:');

  final confirmed = confirm(
    '# component name would be [$componentName],  is it correct?',
    defaultValue: true,
  );

  if (!confirmed) {
    return;
  }

  String path = './lib/${componentName.toSnakeCase}_component';

  final bool pathConfirmed =
      confirm('# is path [$path] correct?', defaultValue: true);

  if (!pathConfirmed) {
    path = ask('# enter correct path:');
  }

  createDir(path, recursive: true);

  final String dataPath = '$path/data';
  final String repositoriesPath = '$path/repositories';
  final String domainPath = '$path/domain';
  final String presentationPath = '$path/presentation';

  createDir(dataPath, recursive: true);
  createDir(repositoriesPath, recursive: true);
  createDir(domainPath, recursive: true);
  createDir(presentationPath, recursive: true);

  createModel(path: dataPath, name: componentName);
  createRepository(path: repositoriesPath, name: componentName);

  createEntity(path: domainPath, name: componentName);
  createService(path: domainPath, name: componentName);

  createCubit(path: presentationPath, name: componentName);
  createWidget(path: presentationPath, name: componentName);

  print('Component [$componentName] has been created.');
}

void createModel({required String path, required String name}) {
  '$path/${name.toSnakeCase}_model.dart'.write(
    '''
      class ${name}Model {
        ${name}Model();
      }
    '''
        .dartFormat,
  );
}

void createRepository({required String path, required String name}) {
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

void createEntity({required String path, required String name}) {
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

createService({required String path, required String name}) {
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

createCubit({required String path, required String name}) {
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

createWidget({required String path, required String name}) {
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
