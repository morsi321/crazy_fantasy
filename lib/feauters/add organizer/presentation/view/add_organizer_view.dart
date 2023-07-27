import 'package:crazy_fantasy/core/widget/AppBar_custom.dart';
import 'package:crazy_fantasy/feauters/add%20organizer/presentation/view/widget/addOrganizerButton.dart';
import 'package:crazy_fantasy/feauters/add%20organizer/presentation/view/widget/show_organizers.dart';
import 'package:flutter/material.dart';

class AddOrganizerView extends StatelessWidget {
  const AddOrganizerView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        floatingActionButton:AddOrganizerButton() ,
        appBar: AppBarCustom(
          title: 'اضافة منظم',
        ),
        body: Center(
          child: ShowOrganizer(),
        ));
  }
}
