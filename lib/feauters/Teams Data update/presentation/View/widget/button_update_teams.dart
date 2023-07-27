import 'package:crazy_fantasy/core/widget/button_custom.dart';
import 'package:crazy_fantasy/feauters/Teams%20Data%20update/presentation/View/widget/Uploader_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widget/dailog_error.dart';
import '../../view model/update_data_team_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonUpdateTeams extends StatelessWidget {
  const ButtonUpdateTeams({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateDataTeamCubit, UpdateDataTeamState>(
      builder: (context, state) {
        return Column(
          children: [
            state is UpdateAllTeamLoading
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: UploaderWidget(
                      current: state.sent.toDouble(),
                      end: state.total.toDouble(),
                    ),
                  )
                : const SizedBox(),
            BlocConsumer<UpdateDataTeamCubit, UpdateDataTeamState>(
              listener: (context, state) {
                if (state is FailureGetCurrentGameWeek) {
                  dialogError(
                      context,
                      state.message,
                      () => context
                          .read<UpdateDataTeamCubit>()
                          .getCurrentGameWeek());
                }
              },
              builder: (context, state) {
                if(state is GetCurrentGameWeekLoading )
                  {
                    return const CircularProgressIndicator();
                  }
                return ButtonCustom(
                    color: Colors.red,
                    colorText: Colors.white,
                    width: 250,
                    borderRadius: BorderRadius.circular(6),
                    height: 60,
                    fontSize: 20,
                    onTap: () => BlocProvider.of<UpdateDataTeamCubit>(context)
                        .updateAllTeams(),
                    label: "بدا الجولة ${context.read<UpdateDataTeamCubit>()
                        .gameWeek!+1 }");
              },
            ),
          ],
        );
      },
    );
  }
}
