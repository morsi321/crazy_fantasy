import 'package:crazy_fantasy/feauters/teams/presentation/view/widget/Drawer_custom.dart';
import 'package:crazy_fantasy/feauters/teams/presentation/view/widget/floating_action_button.dart';
import 'package:crazy_fantasy/feauters/teams/presentation/view/widget/search.dart';
import 'package:flutter/material.dart';

import 'widget/show_teams.dart';

class TeamView extends StatelessWidget {
  const TeamView({super.key});

  @override
  Widget build(BuildContext context) {
    return   const Scaffold(

      endDrawer: DrawerCustom(),
      appBar: Search(),
      floatingActionButton: AddTeamButton(),
      body: Center(
        child: ShowTeams(),
      ),
    );
  }
}
