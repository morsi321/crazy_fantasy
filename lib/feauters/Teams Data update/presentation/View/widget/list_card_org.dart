import 'package:crazy_fantasy/feauters/Teams%20Data%20update/presentation/View/widget/card_org.dart';
import 'package:flutter/material.dart';

import '../../view model/update_data_team_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListOfCardOrganizes extends StatelessWidget {
  const  ListOfCardOrganizes({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateDataTeamCubit, UpdateDataTeamState>(
  builder: (context, state) {
    return ListView.builder(
      itemCount:
          BlocProvider.of<UpdateDataTeamCubit>(context).organizers.length,
      itemBuilder: (context, index) {
        return CardOrganizer(
          org: BlocProvider.of<UpdateDataTeamCubit>(context).organizers[index],
        );
      },
    );
  },
);
  }
}
