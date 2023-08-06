import 'package:crazy_fantasy/feauters/organizers/presentation/view/widget/add%20org/add_oragnizer_Widget.dart';
import 'package:crazy_fantasy/feauters/organizers/presentation/view/widget/add%20org/select_teams.dart';
import 'package:flutter/material.dart';

import '../view Model/add_orgaizer_cubit.dart';
import 'widget/show_organizers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrganizerViewBody extends StatelessWidget {
  const OrganizerViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final addOrgCubit = context.read<AddOrganizerCubit>();
    return BlocBuilder<AddOrganizerCubit, AddOrganizerState>(
      builder: (context, state) {
        return IndexedStack(
          clipBehavior: Clip.none,

          index:addOrgCubit
              .indexPageOrganizer,
          children:  [
            Visibility(
                visible: addOrgCubit.indexPageOrganizer == 0,
                child: const ShowOrganizer()),
             Visibility(
                 visible: addOrgCubit.indexPageOrganizer == 1,
                 child: const AddOrganizerWidget()),
            Visibility(
                visible: addOrgCubit.indexPageOrganizer == 2,
                child: const SelectTeams()),
          ],
        );
      },
    );
  }
}
