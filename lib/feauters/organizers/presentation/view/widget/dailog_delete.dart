import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view Model/add_orgaizer_cubit.dart';

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
                BlocProvider.of<AddOrganizerCubit>(context).deleteOrg(id);
              },
              child: const Text('Delete',style: TextStyle(color: Colors.red),),
            ),
          ],
        );
      });
}