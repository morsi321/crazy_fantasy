import 'package:crazy_fantasy/core/widget/text_field_custom.dart';
import 'package:crazy_fantasy/feauters/organizers/presentation/view%20Model/add_orgaizer_cubit.dart';
import 'package:crazy_fantasy/feauters/organizers/presentation/view/widget/add%20org/select_teams_in_dailog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/widget/icon_with_counter.dart';
import '../../../../../teams/presentation/view model/add_team_cubit.dart';

class AppBarSearchTeam extends StatelessWidget {
  const AppBarSearchTeam({super.key});


  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(170),
      child: AppBar(
        title: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: TextFromCustom(
            onChanged: (value) {
              BlocProvider.of<AddTeamCubit>(context).search(value);
            },
            width: double.infinity,
            height: 55,
            hintText: "Search",
            disableBorder: true,
            suffixIcon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            fillColor: Colors.white.withOpacity(.1),
            label: '',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          BlocBuilder<AddOrganizerCubit, AddOrganizerState>(
            builder: (context, state) {
              return IconButton(
                padding: const EdgeInsets.only(right: 10),
                onPressed: () {
                  showTeamsSelected(context);
                },
                icon: IconWithCounter(
                  icon: Icons.diversity_2, counter: BlocProvider
                    .of<AddOrganizerCubit>(context).teams
                    .length,

                ),
              );
            },
          ),
        ],
        backgroundColor: const Color.fromRGBO(28, 22, 54, .9),
      ),
    );
  }
}
