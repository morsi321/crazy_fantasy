import 'package:flutter/material.dart';

import '../../view model/add_team_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showDailogDelete( context,String id) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Team'),
          content: const Text('Are you sure you want to delete this team?',style: TextStyle(fontSize: 16),),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel',)
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                BlocProvider.of<AddTeamCubit>(context).deleteTeam(id);
              },
              child: const Text('Delete',style: TextStyle(color: Colors.red),),
            ),
          ],
        );
      });
}