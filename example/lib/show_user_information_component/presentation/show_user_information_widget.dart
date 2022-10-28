import 'package:flutter/material.dart';

import 'package:flutter_app_architecture/components.dart';

import '../show_user_information_component.dart';

/// Show user information widget.
class ShowUserInformationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      BaseWidget<ShowUserInformationEntity, ShowUserInformationCubit>(
        loadingWidgetBuilder:
            (BuildContext context, BaseState<BaseEntity> state) =>
                const CircularProgressIndicator(),
        successWidgetBuilder:
            (BuildContext context, BaseState<BaseEntity> state) =>
                Text('${state.data}'),
        errorWidgetBuilder:
            (BuildContext context, BaseState<BaseEntity> state) =>
                Text(state.error ?? 'ERROR'),
      );
}
