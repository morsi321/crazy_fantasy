import 'package:crazy_fantasy/feauters/organizers/presentation/view/widget/add%20org/ItemTeamSlected.dart';
import 'package:flutter/material.dart';

import '../../../view Model/add_orgaizer_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showTeamsSelected(context) {
  showDialog(
      context: context,
      builder: (context) {
        final addOrgCubit = BlocProvider.of<AddOrganizerCubit>(context);

        return Dialog(
          backgroundColor: const Color.fromRGBO(28, 22, 54, 1),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "الفرق المختارة",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: BlocBuilder<AddOrganizerCubit, AddOrganizerState>(
                    builder: (context, state) {
                      return ListSelectedItemTeamView(
                        teams: addOrgCubit.isTeams1000 &&
                                !(addOrgCubit.isVipLeague ||
                                    addOrgCubit.isClassicLeague ||
                                    addOrgCubit.isCup)
                            ? addOrgCubit.teams1000
                            : addOrgCubit.indexPageOrganizer == 2 &&
                                    (addOrgCubit.isCup ||
                                        addOrgCubit.isVipLeague ||
                                        addOrgCubit.isClassicLeague)
                                ? addOrgCubit.teams
                                : addOrgCubit.indexPageOrganizer == 3 &&
                                        addOrgCubit.isTeams1000
                                    ? addOrgCubit.teams1000
                                    : [],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
