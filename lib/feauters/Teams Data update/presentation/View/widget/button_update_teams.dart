import 'package:crazy_fantasy/core/widget/button_custom.dart';
import 'package:crazy_fantasy/feauters/Teams%20Data%20update/presentation/View/widget/Uploader_widget.dart';
import 'package:crazy_fantasy/feauters/Teams%20Data%20update/presentation/View/widget/start_season.dart';
import 'package:crazy_fantasy/feauters/organizers/Data/models/orgnizer_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../view model/update_data_team_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonUpdateTeams extends StatelessWidget {
  const ButtonUpdateTeams({
    super.key,
    required this.org,
  });

  final Organizer org;

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
            BlocBuilder<UpdateDataTeamCubit, UpdateDataTeamState>(
              builder: (context, state) {
                if (state is GetCurrentGameWeekLoading) {
                  return const CircularProgressIndicator();
                }
                return org.numGameWeek! >=1?  ButtonCustom(
                    color: Colors.red,
                    colorText: Colors.white,
                    width: 250,
                    borderRadius: BorderRadius.circular(6),
                    height: 60,
                    fontSize: 20,
                    onTap: () => BlocProvider.of<UpdateDataTeamCubit>(context)
                            .updateTeamOrg(
                          org: org,
                        ),
                    label: "انهاء الجولة ${org.numGameWeek}"):
                StartSeason(org: org);
              },
            ),
          ],
        );
      },
    );
  }
}
