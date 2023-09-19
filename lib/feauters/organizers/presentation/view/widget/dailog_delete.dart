import 'package:crazy_fantasy/feauters/teams/presentation/view%20model/add_team_cubit.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

void showDailogDeleteTeam(context, String id, String name, bool isCloseUpdate) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Directionality(

              textDirection: TextDirection.rtl,
              child: Text('حذف فريق', style: TextStyle(color: Colors.red))),
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              isCloseUpdate
                  ? "لا يمكنك حذف هذا فريق لانه تم تسجبله في بطوله"
                  : 'هل تريد حذف فريق $name ',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                )),
            isCloseUpdate? const SizedBox() :        TextButton(
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
