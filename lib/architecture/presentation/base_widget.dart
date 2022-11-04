import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_deriv_bloc_manager/manager.dart';

import 'package:flutter_app_architecture/components.dart';

/// General widget builder method type.
typedef GeneralWidgetBuilder<Entity extends BaseEntity> = Widget Function(
  BuildContext context,
  BaseState<Entity> state,
);

/// Base class for all component widgets, based on [GenericStates].
class BaseWidget<Entity extends BaseEntity, Model extends BaseModel,
    Cubit extends BaseCubit<Entity, Model>> extends StatelessWidget {
  /// Initializes [BaseWidget].
  const BaseWidget({
    required this.initialWidgetBuilder,
    required this.loadingWidgetBuilder,
    required this.successWidgetBuilder,
    required this.errorWidgetBuilder,
    this.cubitKey = BaseBlocManager.defaultKey,
    Key? key,
  }) : super(key: key);

  /// Cubit key to access an specific cubit.
  final String cubitKey;

  /// Initial state widget builder.
  final GeneralWidgetBuilder initialWidgetBuilder;

  /// Loading state widget builder.
  final GeneralWidgetBuilder loadingWidgetBuilder;

  /// Success state widget builder.
  final GeneralWidgetBuilder successWidgetBuilder;

  /// Error state widget builder.
  final GeneralWidgetBuilder errorWidgetBuilder;

  @override
  Widget build(BuildContext context) => BlocBuilder<Cubit, BaseState<Entity>>(
        bloc: BlocManager.instance.fetch<Cubit>(cubitKey),
        builder: (BuildContext context, BaseState<Entity> state) {
          switch (state.status) {
            case BaseStateStatus.initial:
              return initialWidgetBuilder(context, state);
            case BaseStateStatus.loading:
              return loadingWidgetBuilder(context, state);
            case BaseStateStatus.success:
              return successWidgetBuilder(context, state);
            case BaseStateStatus.failure:
              return errorWidgetBuilder(context, state);
          }
        },
      );
}
