import 'package:crazy_fantasy/feauters/organizers/presentation/view%20Model/add_orgaizer_cubit.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class Championships extends StatelessWidget {
  const Championships({super.key});

  @override
  Widget build(BuildContext context) {
    final addOrgCubit = context.read<AddOrganizerCubit>();
    return BlocBuilder<AddOrganizerCubit, AddOrganizerState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CheckboxListTile(
              title: const Text(
                'بطولة الف تيم',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              value: addOrgCubit.isTeams1000,
              onChanged: (bool? value) {
                addOrgCubit.changeIsTeams1000();
              },
            ),
            CheckboxListTile(
              title: const Text(
                ' الكاس',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              value: addOrgCubit.isCup,
              onChanged: (bool? value) {
                addOrgCubit.changeIsCup();
              },
            ),

            CheckboxListTile(
              title: const Text(
                'الدوري الكلاسيكي ',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              value: addOrgCubit.isClassicLeague,
              onChanged: (bool? value) {
                addOrgCubit.changeIsClassicLeague();
              },
            ),
            CheckboxListTile(
              title: const Text(
                'VIP',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              value: addOrgCubit.isVipLeague,
              onChanged: (bool? value) {
                addOrgCubit.changeIsVipLeague();
              },
            ),
          ],
        );
      },
    );
  }
}
