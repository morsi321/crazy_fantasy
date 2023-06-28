import 'package:crazy_fantasy/feauters/teams/presentation/view/widget/floating_action_button.dart';
import 'package:flutter/material.dart';

import '../view model/add_team_cubit.dart';
import 'widget/show_teams.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeamView extends StatelessWidget {
  const TeamView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(.05),
        elevation: 30,
        title: InkWell(
          onTap: () {
            BlocProvider.of<AddTeamCubit>(context).getTeams();
          },
          child: const Text(
            'Teams',
            style: TextStyle(color: Colors.white),
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: const AddTeamButton(),
      body: const Center(
        child: ShowTeams(),
      ),
    );
  }
}
