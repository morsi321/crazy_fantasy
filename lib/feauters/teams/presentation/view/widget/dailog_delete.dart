import 'package:crazy_fantasy/feauters/organizers/Data/models/orgnizer_model.dart';
import 'package:crazy_fantasy/feauters/organizers/presentation/view%20Model/add_orgaizer_cubit.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

void showDailogDeleteOrg(
    context,
    Organizer org ) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete org'),
          content: const Text(
            'Are you sure you want to delete this org?',
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
                BlocProvider.of<AddOrganizerCubit>(context).deleteOrg(org: org
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
