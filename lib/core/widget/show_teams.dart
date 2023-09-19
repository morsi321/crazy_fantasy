import 'package:crazy_fantasy/core/extension/MediaQueryValues.dart';
import 'package:crazy_fantasy/core/widget/loading.dart';
import 'package:crazy_fantasy/feauters/teams/presentation/view%20model/add_team_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Item_team.dart';

class ShowTeams extends StatefulWidget {
  const ShowTeams({super.key, this.forOrg = false});

  final bool forOrg;

  @override
  State<ShowTeams> createState() => _ShowTeamsState();
}

class _ShowTeamsState extends State<ShowTeams> {
  @override
  void initState() {
    if(!widget.forOrg) {
      BlocProvider.of<AddTeamCubit>(context).getTeams();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final teamCubit = BlocProvider.of<AddTeamCubit>(context);
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
              if (state is LoadingSearchState ||
                  state is LoadingGetTeamsState) {
                return const LoadingWidget();
              } else if (BlocProvider.of<AddTeamCubit>(context)
                  .teams
                  .isNotEmpty) {
                return Expanded(
                  child: ListItemTeamView(
                    forOrg: widget.forOrg,
                    teams:  teamCubit.teams,
                  ),
                );
              } else if (state is SuccessfulSearchState) {
                if (state.length == 0) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 180.0),
                    child: Center(
                      child: Text("لا يوجد هذا الفريق في قاعده البيانات ",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                  );
                }
              }
              return const Center(
                child: SizedBox(),
              );
            }),
      ],
    );
  }
}
