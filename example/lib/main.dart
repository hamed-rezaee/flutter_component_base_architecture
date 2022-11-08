import 'package:flutter/material.dart';

import 'package:flutter_deriv_bloc_manager/manager.dart';

import 'package:flutter_app_architecture/components.dart';

import 'package:example/show_user_information_component/data/repositories/show_user_information_repository.dart';
import 'package:example/show_user_information_component/data/show_user_information_mapper.dart';
import 'package:example/show_user_information_component/domain/show_user_information_entity.dart';
import 'package:example/show_user_information_component/domain/show_user_information_service.dart';
import 'package:example/show_user_information_component/presentation/show_user_information_cubit.dart';
import 'package:example/show_user_information_component/presentation/show_user_information_widget.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocManager.instance.register(
      ShowUserInformationCubit(
        initialState: BaseState<ShowUserInformationEntity>(
          status: BaseStateStatus.initial,
        ),
        service: ShowUserInformationService(
          ShowUserInformationRepository(ShowUserInformationMapper()),
        ),
      ),
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: Scaffold(
        appBar: AppBar(elevation: 0, title: const Text('Example App')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 128),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ShowUserInformationWidget(),
                const Spacer(),
                ElevatedButton(
                  child: const Text('FETCH DATA'),
                  onPressed: BlocManager.instance
                      .fetch<ShowUserInformationCubit>()
                      .fetchUserInformation,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
