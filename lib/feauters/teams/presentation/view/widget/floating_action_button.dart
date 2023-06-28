import 'package:crazy_fantasy/core/widget/bootom_sheet_custom.dart';
import 'package:crazy_fantasy/feauters/teams/presentation/view/team_view.dart';
import 'package:crazy_fantasy/feauters/teams/presentation/view/widget/add_team.dart';
import 'package:flutter/material.dart';

class AddTeamButton extends StatelessWidget {
  const AddTeamButton({super.key});

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.only(bottom: 50.0,right: 15),
      child: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: (){
          showBottomSheetCustom(context, const AddTeam());},
        child: const Icon(Icons.add),
      ),
    );
  }
}
