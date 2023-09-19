import 'package:crazy_fantasy/feauters/organizers/Data/models/orgnizer_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view model/update_data_team_cubit.dart';

void showDailogUpdateOrg(context,{required Organizer org}) {
  showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: const Text('انهاء الجوله'),
            content: const Text(
              'هل انت متاكد من انهاء الجوله',
              style: TextStyle(fontSize: 16),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'لا',
                    style: TextStyle(fontSize: 16)),
                  ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  org.isUpdateRealTime = false;
                  BlocProvider.of<UpdateDataTeamCubit>(context)
                      .updateTeamOrg(
                    org: org,
                  );
                },
                child: const Text(
                  'نعم',
                  style: TextStyle(color: Colors.red,fontSize: 16),
                ),
              ),
            ],
          ),
        );
      });
}
