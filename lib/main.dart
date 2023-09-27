import 'package:crazy_fantasy/feauters/teams/presentation/view%20model/add_team_cubit.dart';
import 'package:crazy_fantasy/feauters/vip/presentaion/viewModel/vip_championship_cubit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/utils/app_router.dart';
import 'core/utils/bloc_observer.dart';
import 'feauters/Teams Data update/presentation/view model/update_data_team_cubit.dart';
import 'feauters/organizers/presentation/view Model/add_orgaizer_cubit.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddTeamCubit(),
        ),
        BlocProvider(
          create: (context) => UpdateDataTeamCubit(),
        ),BlocProvider(
          create: (context) => VipChampionshipCubit(),
        ),BlocProvider(
          create: (context) => AddOrganizerCubit(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        title: 'Crazy Fantasy',

        theme: ThemeData(
          fontFamily: 'Janna',
          scaffoldBackgroundColor: const Color.fromRGBO(28, 22, 54, .9),

          useMaterial3: true,
        ),

      ),
    );
  }
}