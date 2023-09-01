import 'package:crazy_fantasy/feauters/teams/presentation/view%20model/add_team_cubit.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


void showDailogDeleteTeam(context, String id, String nameOrg,
    List<String> otherChampionshipsTeams, List<String> teams1000Id) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Team'),
          content: const Text(
            'Are you sure you want to delete this team?',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                )),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                BlocProvider.of<AddTeamCubit>(context).deleteTeam(
                  id,
                );
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      });
}
