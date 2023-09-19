import 'package:crazy_fantasy/feauters/teams/presentation/view/widget/floating_action_button.dart';
import 'package:crazy_fantasy/feauters/teams/presentation/view/widget/search.dart';
import 'package:flutter/material.dart';

import '../../../../core/widget/show_teams.dart';


class TeamView extends StatelessWidget {
  const TeamView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: Search(),
      floatingActionButton: AddTeamButton(),
      body: Center(
        child: ShowTeams(),
      ),
    );
  }
}
