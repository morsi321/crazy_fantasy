import 'package:flutter/material.dart';

import '../../view model/add_team_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Championships extends StatelessWidget {
  const Championships({super.key});

  @override
  Widget build(BuildContext context) {
    final addTeamCubit = context.read<AddTeamCubit>();
    return BlocBuilder<AddTeamCubit, AddTeamState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CheckboxListTile(
              title: const Text(
                'بطولة الف تيم',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              value: addTeamCubit.isTeams1000,
              onChanged: (bool? value) {
                addTeamCubit.changeIsTeams1000();
              },
            ),
            CheckboxListTile(
              title: const Text(
                ' الكاس',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              value: addTeamCubit.isCup,
              onChanged: (bool? value) {
                addTeamCubit.changeIsCup();
              },
            ),
            CheckboxListTile(
              title: const Text(
                'الدوري الكلاسيكي ',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              value: addTeamCubit.isClassicLeague,
              onChanged: (bool? value) {
                addTeamCubit.changeIsClassicLeague();
              },
            ),
            CheckboxListTile(
              title: const Text(
                'VIP',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              value: addTeamCubit.isVipLeague,
              onChanged: (bool? value) {
                addTeamCubit.changeIsVipLeague();
              },
            ),
          ],
        );
      },
    );
  }
}
