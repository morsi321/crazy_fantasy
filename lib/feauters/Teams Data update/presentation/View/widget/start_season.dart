import 'package:crazy_fantasy/feauters/Teams%20Data%20update/presentation/view%20model/update_data_team_cubit.dart';
import 'package:crazy_fantasy/feauters/organizers/Data/models/orgnizer_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/widget/button_custom.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widget/dailog_error.dart';
import 'dailog_loading.dart';

class StartSeason extends StatelessWidget {
  final Organizer org;

  const StartSeason({
    super.key,
    required this.org,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdateDataTeamCubit>();
    return BlocListener<UpdateDataTeamCubit, UpdateDataTeamState>(
      listener: (context, state) {
        if (state is StartSeasonLoading) {
          showDialogLoading(context);
        } else if (state is SuccessfulStartSeason) {
          context.pop();
        } else
        if (state is FailureStartSeason) {
          dialogError(
              context, state.message, () => cubit.startSeason(org: org));
        }
      },

       child:  ButtonCustom(
          fontSize: 20,
          onTap: () => cubit.startSeason(org: org),
          label: " بدء الموسم",
          width: 200,
          colorText: Colors.white,
          borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(6), right: Radius.circular(6)),
          height: 55,
          color: Colors.red,
        ),
    );


  }
}
