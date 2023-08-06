import 'package:crazy_fantasy/core/extension/MediaQueryValues.dart';
import 'package:crazy_fantasy/feauters/teams/presentation/view%20model/add_team_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Item_team.dart';

class ShowTeams extends StatefulWidget {
  const ShowTeams({super.key,  this.forOrg = false});
  final bool forOrg ;

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
    return Column(
      children: [
        SizedBox(
          height: context.height * 0.01,
        ),
        SizedBox(
          height: context.height * 0.01,
        ),
        BlocConsumer<AddTeamCubit, AddTeamState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoadingCrudChampionState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (BlocProvider.of<AddTeamCubit>(context)
                .teams
                .isNotEmpty) {
              return Expanded(
                child: ListItemTeamView(
                  forOrg: widget.forOrg,
                  teams: BlocProvider.of<AddTeamCubit>(context).teams,
                ),
              );
            } else {
              return const Center(
                child: Text("No Data"),
              );
            }
          },
        ),
      ],
    );
  }
}
