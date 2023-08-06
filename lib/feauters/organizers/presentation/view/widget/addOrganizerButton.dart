import 'package:crazy_fantasy/core/widget/bootom_sheet_custom.dart';

import 'package:flutter/material.dart';

import 'add org/add_oragnizer_Widget.dart';

class AddOrganizerButton extends StatelessWidget {
  const AddOrganizerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.only(bottom: 50.0,right: 15),
      child: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: (){
          showBottomSheetCustom(context, const AddOrganizerWidget());},
        child: const Icon(Icons.add),
      ),
    );
  }
}
