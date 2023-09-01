import 'package:crazy_fantasy/core/widget/button_custom.dart';
import 'package:crazy_fantasy/core/widget/my_snackBar.dart';
import 'package:crazy_fantasy/feauters/Teams%20Data%20update/presentation/View/widget/dailog_loading.dart';
import 'package:crazy_fantasy/feauters/Teams%20Data%20update/presentation/View/widget/start_season.dart';
import 'package:crazy_fantasy/feauters/organizers/Data/models/orgnizer_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    return BlocListener<UpdateDataTeamCubit, UpdateDataTeamState>(
      listener: (context, state) {
        if (state is UpdateAllTeamLoading) {
          showDialogLoading(context);
        } else if (state is FailureUpdateAllTeam) {
          context.pop();
          mySnackBar(context,
              message:
                  "حدث خطأ ما غير متوقع في انهاء جوله رقم ${org.numGameWeek}");
        } else if (state is SuccessfulUpdateAllTeam) {
          context.pop();
          mySnackBar(context, message: "تم انهاء جوله  بنجاح");
        }
      },
      child: Column(
        children: [
          org.numGameWeek! >= 1
              ? ButtonCustom(
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
                  label: "انهاء الجولة ${org.numGameWeek}")
              : StartSeason(org: org)
        ],
      ),
    );
  }
}
