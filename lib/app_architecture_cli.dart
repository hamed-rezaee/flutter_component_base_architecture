#! /usr/bin/env dcli

import 'package:dcli/dcli.dart';

import 'package:dart_app_architecture_cli/extensions.dart';

void main(List<String> args) {
  print('Generate Flutter Deriv Component... 💪');
  final String componentName = ask('# enter component name:');
  final confirmed = confirm(
    '# component name would be [$componentName],  is it correct?',
    defaultValue: true,
  );

  if (!confirmed) {
    return;
  }

  String path = './lib/${componentName.toCamelCase}_component';

  final bool pathConfirmed =
      confirm('is path [$path] correct?', defaultValue: true);

  if (!pathConfirmed) {
    path = ask('# enter correct path:');
  }

  createDir(path, recursive: true);

  final String dataPath = '$path/data';
  final String repositoriesPath = '$path/repositories';
  final String domainPath = '$path/domain';
  final String presentationPath = '$path/presentation';

  createDir(dataPath, recursive: true);
  createDir(domainPath, recursive: true);
  createDir(presentationPath, recursive: true);

  createModel(dataPath, componentName);
  createRepository(repositoriesPath, componentName);

  createEntity(domainPath, componentName);
  createService(domainPath, componentName);

  createCubit(presentationPath, componentName);
  createWidget(presentationPath, componentName);

  print('Component [$componentName] has been created.');
}

void createModel(String dataPath, String componentName) {
  '$dataPath/${componentName.toCamelCase}_model.dart'.write('''
class ${componentName}Model {
  ${componentName}Model();
}
''');
}

void createRepository(String repositoriesPath, String componentName) {
  '$repositoriesPath/base_${componentName.toCamelCase}_repository.dart'
      .write('''
import 'package:flutter_app_architecture/structure/data/base_repository.dart';

class Base${componentName}Repository extends BaseRepository {}
''');

  '$repositoriesPath/${componentName.toCamelCase}_repository.dart'.write('''
class Base${componentName}Repository extends Base${componentName}Repository {}
''');
}

void createEntity(String domainPath, String componentName) {
  '$domainPath/${componentName.toCamelCase}_repository.dart'.write('''
import 'package:flutter_app_architecture/structure/domain/base_entity.dart';

class ${componentName}Entity extends BaseEntity {
  ${componentName}Entity();

  @override
  String toString() => throw UnimplementedError();  
}
''');
}

createService(domainPath, componentName) {
  '$domainPath/${componentName.toCamelCase}_service.dart'.write('''
import 'package:flutter_app_architecture/structure/domain/base_service.dart';

class ${componentName}Service extends BaseService<${componentName}Entity> {
  ${componentName}Service(Base${componentName}Repository repository) : super(repository);
''');
}

createCubit(presentationPath, componentName) {
  '$presentationPath/${componentName.toCamelCase}_cubit.dart'.write('''
import 'package:flutter_app_architecture/structure/presentation/state_manager/base_cubit.dart';
import 'package:flutter_app_architecture/structure/presentation/state_manager/base_state.dart';
import 'package:flutter_app_architecture/structure/presentation/state_manager/base_state_status.dart';

class ${componentName}Cubit extends BaseCubit<${componentName}Entity> {
  ${componentName}Cubit({required ${componentName}Service service})
      : super(
          service: service,
          initialState: BaseState<${componentName}Entity>(status: BaseStateStatus.initial),
        );
''');
}

createWidget(presentationPath, componentName) {
  '$presentationPath/${componentName.toCamelCase}_widget.dart'.write('''
import 'package:flutter/material.dart';

import 'package:flutter_app_architecture/structure/domain/base_entity.dart';
import 'package:flutter_app_architecture/structure/presentation/base_widget.dart';
import 'package:flutter_app_architecture/structure/presentation/state_manager/base_state.dart';

class ${componentName}Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BaseWidget<${componentName}Entity, ${componentName}Cubit>(
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
''');
}
