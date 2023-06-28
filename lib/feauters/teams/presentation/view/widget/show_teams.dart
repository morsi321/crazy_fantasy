import 'package:crazy_fantasy/feauters/teams/presentation/view%20model/add_team_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widget/dailog_error.dart';
import 'Item_team.dart';

class ShowTeams extends StatefulWidget {
  const ShowTeams({super.key});

  @override
  State<ShowTeams> createState() => _ShowTeamsState();
}

class _ShowTeamsState extends State<ShowTeams> {
  @override
  void initState() {
    BlocProvider.of<AddTeamCubit>(context).scrollListenerPangation();
    BlocProvider.of<AddTeamCubit>(context).getTeams();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddTeamCubit, AddTeamState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is LoadingAddTeamChampionState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (BlocProvider.of<AddTeamCubit>(context).teams.isNotEmpty) {
          return ListItemTeamView(
            teams: BlocProvider.of<AddTeamCubit>(context).teams,
          );
        } else {
          return const Center(
            child: Text("No Data"),
          );
        }
      },
    );
  }
}