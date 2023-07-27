import 'package:crazy_fantasy/feauters/teams/presentation/view%20model/add_team_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTeamButton extends StatelessWidget {
  const AddTeamButton({super.key});

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.only(bottom: 50.0,right: 15),
      child: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: (){
          // showBottomSheetCustom(context, const AddTeam());
          BlocProvider.of<AddTeamCubit>(context).add1000Team();
          },
        child: const Icon(Icons.add),
      ),
    );
  }
}
