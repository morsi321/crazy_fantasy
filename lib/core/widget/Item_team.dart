import 'package:crazy_fantasy/core/extension/MediaQueryValues.dart';
import 'package:crazy_fantasy/core/widget/cash_image_network.dart';
import 'package:crazy_fantasy/feauters/organizers/presentation/view%20Model/add_orgaizer_cubit.dart';
import 'package:flutter/material.dart';

import '../models/team.dart';
import '../../feauters/teams/presentation/view model/add_team_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ListItemTeamView extends StatelessWidget {
  const ListItemTeamView({super.key, required this.teams, this.forOrg = false});

  final bool forOrg;

  final List<Team> teams;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: BlocProvider.of<AddTeamCubit>(context).scrollController,
        itemCount: teams.length +
            (BlocProvider.of<AddTeamCubit>(context).isLoading ? 0 : 1),
        itemBuilder: (context, index) {
          if (index == teams.length) {
            return const Center(child: CircularProgressIndicator());
          }
          return ItemTeam(
            forOrg: forOrg,
            team: teams[index],
            index: index + 1,
          );
        });
  }
}

class ItemTeam extends StatelessWidget {
  const ItemTeam(
      {super.key,
      required this.team,
      required this.index,
      this.forOrg = false});

  final bool forOrg;

  final Team team;
  final int index;

  @override
  Widget build(BuildContext context) {
    final addOrgCubit = BlocProvider.of<AddOrganizerCubit>(context);
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 5.0,
      ),
      child: Container(
          width: double.infinity,
          height: 65,
          color: Colors.white.withOpacity(.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InfoDataTeam(
                team: team,
                index: index,
              ),
              forOrg
                  ? IconButton(
                      onPressed: () => addOrgCubit.isTeams1000 &&
                          !(addOrgCubit.isVipLeague ||
                              addOrgCubit.isClassicLeague ||
                              addOrgCubit.isCup)
                          ? addOrgCubit.addFor1000Team(team, context)
                          : addOrgCubit.indexPageOrganizer == 2 &&
                          (addOrgCubit.isCup ||
                              addOrgCubit.isVipLeague ||
                              addOrgCubit.isClassicLeague)
                          ? addOrgCubit.addTeamInBag(team, context)
                          : addOrgCubit.indexPageOrganizer == 3 &&
                          addOrgCubit.isTeams1000
                          ? addOrgCubit.addFor1000Team(team, context)
                          : (){},


                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () {
                              BlocProvider.of<AddTeamCubit>(context)
                                  .editTeam(team, context);
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            )),
                        IconButton(
                            onPressed: () {
                              // showDailogDelete(context, team.id!);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                      ],
                    )
            ],
          )),
    );
  }
}

class InfoDataTeam extends StatelessWidget {
  const InfoDataTeam({super.key, required this.team, required this.index});

  final Team team;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<AddTeamCubit>(context).viewTeam(team, context);
      },
      child: SizedBox(
        width: context.width * .7,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              index.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(
              width: context.width * .52,
              child: Row(
                children: [
                  CashImageNetwork(url: team.pathImage!, width: 50, height: 50),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          team.name!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'janna'),
                        ),
                        Text(
                          team.country!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'janna',
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
