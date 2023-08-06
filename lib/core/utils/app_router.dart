import 'package:crazy_fantasy/feauters/Teams%20Data%20update/presentation/View/teams_data_update_view.dart';
import 'package:crazy_fantasy/feauters/vip/presentaion/view/widget/vip_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../feauters/organizers/presentation/view/organizer_view.dart';
import '../../feauters/teams/presentation/view/team_view.dart';


class AppRouter {
  static String addTeamPage = '/';
  static String updateTeam = '/UpdateTeam';
  static String vipChampionship = '/vipChampionship';
  static String addOrganizer = '/addOrganizer';



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
      ), GoRoute(
        path: vipChampionship,
        builder: (BuildContext context, GoRouterState state) {
          return const VipView();
        },
      ),
      GoRoute(
        path: addOrganizer,
        builder: (BuildContext context, GoRouterState state) {
          return const OrganizerView();
        },
      )
  ]);

}
