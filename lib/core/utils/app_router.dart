import 'package:crazy_fantasy/feauters/Teams%20Data%20update/presentation/View/teams_data_update_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

import '../../feauters/teams/presentation/view/team_view.dart';


class AppRouter {
  static String addTeamPage = '/';
  static String updateTeam = '/UpdateTeam';


  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: addTeamPage,
        builder: (BuildContext context, GoRouterState state) {
          return const TeamView();
        },
      ),
      GoRoute(
        path: updateTeam,
        builder: (BuildContext context, GoRouterState state) {
          return const TeamsDataUpdateView();
        },
      )
  ]);

}
