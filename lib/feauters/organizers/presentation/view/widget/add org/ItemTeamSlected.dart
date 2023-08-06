import 'package:crazy_fantasy/core/extension/MediaQueryValues.dart';
import 'package:crazy_fantasy/feauters/organizers/presentation/view%20Model/add_orgaizer_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/models/team.dart';
import '../../../../../../core/widget/cash_image_network.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class ListSelectedItemTeamView extends StatelessWidget {
  const ListSelectedItemTeamView({super.key, required this.teams});

  final List<Team> teams;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: teams.length ,
        itemBuilder: (context, index) {
          return SelectedItemTeam(
            team: teams[index],
            index: index + 1,
          );
        });
  }
}

class SelectedItemTeam extends StatelessWidget {
  const SelectedItemTeam({
    super.key,
    required this.team,
    required this.index,
  });

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
          height: 65,
          color: Colors.white.withOpacity(.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InfoDataTeam(
                team: team,
                index: index,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {
                        BlocProvider.of<AddOrganizerCubit>(context)
                            .removeTeamInBag(team,);
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          index.toString(),
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          width: context.width * .40,
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
                          fontSize: 16,
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
    );
  }
}
