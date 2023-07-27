import 'package:crazy_fantasy/core/widget/background_image.dart';
import 'package:crazy_fantasy/feauters/Teams%20Data%20update/presentation/View/widget/button_update_teams.dart';
import 'package:crazy_fantasy/feauters/Teams%20Data%20update/presentation/View/widget/show_last_update.dart';
import 'package:crazy_fantasy/feauters/Teams%20Data%20update/presentation/View/widget/start_season.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view model/update_data_team_cubit.dart';

class TeamsDataUpdateViewBody extends StatefulWidget {
  const TeamsDataUpdateViewBody({super.key});

  @override
  State<TeamsDataUpdateViewBody> createState() =>
      _TeamsDataUpdateViewBodyState();
}

class _TeamsDataUpdateViewBodyState extends State<TeamsDataUpdateViewBody> {
  @override
  void initState() {
    context.read<UpdateDataTeamCubit>().getCurrentGameWeek();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: BackgroundImage(
        child: BlocBuilder<UpdateDataTeamCubit, UpdateDataTeamState>(
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const ShowLastUpdate(),
                const SizedBox(
                  height: 50,
                ),
                BlocProvider.of<UpdateDataTeamCubit>(context).gameWeek != 909
                    ? const ButtonUpdateTeams()
                    : const StartSeason(),
              ],
            );
          },
        ),
      ),
    );
  }
}
