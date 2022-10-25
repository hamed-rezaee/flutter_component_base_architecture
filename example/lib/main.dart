import 'package:flutter/material.dart';
import 'package:flutter_deriv_bloc_manager/manager.dart';

import 'package:example/show_user_information_component/data/repositories/show_user_information_repository.dart';
import 'package:example/show_user_information_component/domain/show_user_information_service.dart';

import 'show_user_information_component/presentation/show_user_information_cubit.dart';
import 'show_user_information_component/presentation/show_user_information_widget.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocManager.instance.register(
      ShowUserInformationCubit(
        service: ShowUserInformationService(ShowUserInformationRepository()),
      ),
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ShowUserInformationWidget(),
              const SizedBox(height: 16),
              TextButton(
                child: const Text('FETCH DATA'),
                onPressed: BlocManager.instance
                    .fetch<ShowUserInformationCubit>()
                    .fetchUserInformation,
              )
            ],
          ),
        ),
      ),
    );
  }
}
