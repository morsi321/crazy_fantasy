import 'package:crazy_fantasy/core/widget/background_image.dart';
import 'package:crazy_fantasy/feauters/Teams%20Data%20update/presentation/View/widget/button_update_teams.dart';
import 'package:crazy_fantasy/feauters/Teams%20Data%20update/presentation/View/widget/show_last_update.dart';
import 'package:flutter/material.dart';

class TeamsDataUpdateViewBody extends StatelessWidget {
  const TeamsDataUpdateViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.0),
      child: BackgroundImage(

        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            ShowLastUpdate(),
            SizedBox(
              height: 50,
            ),

            ButtonUpdateTeams(),

          ],
        ),
      ),
    ) ;
  }
}
