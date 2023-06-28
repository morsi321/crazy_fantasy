import 'package:crazy_fantasy/core/extension/MediaQueryValues.dart';
import 'package:crazy_fantasy/core/widget/cash_image_network.dart';
import 'package:flutter/material.dart';

import '../../../Data/models/team.dart';
import '../../view model/add_team_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListItemTeamView extends StatelessWidget {
  const ListItemTeamView({super.key, required this.teams});

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
            team: teams[index],
            index: index + 1,
          );
        });
  }
}

class ItemTeam extends StatelessWidget {
  const ItemTeam({super.key, required this.team, required this.index});

  final Team team;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 5.0,
      ),
      child: Container(
          width: double.infinity,
          height: 60,
          color: Colors.white.withOpacity(.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                index.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),

              CashImageNetwork(url: team.pathImage!, width: 50, height: 50),
              SizedBox(
                width: context.width * .35,
                child: Text(
                  team.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              IconButton(
                  onPressed: () {
                    BlocProvider.of<AddTeamCubit>(context).editTeam(team,context);
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ))
            ],
          )),
    );
  }
}
