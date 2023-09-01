import 'package:flutter/material.dart';

import '../../../../../../core/widget/show_teams.dart';
import '../../../view Model/add_orgaizer_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectTeams extends StatelessWidget {
  const SelectTeams({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final addOrgCubit = BlocProvider.of<AddOrganizerCubit>(context);
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          addOrgCubit.isTeams1000 &&
                  !(addOrgCubit.isVipLeague ||
                      addOrgCubit.isClassicLeague ||
                      addOrgCubit.isCup)
              ? " اختر الفرق الخاصه بطولات 1000 team"
              : addOrgCubit.indexPageOrganizer == 2 &&
                      (addOrgCubit.isCup ||
                          addOrgCubit.isVipLeague ||
                          addOrgCubit.isClassicLeague)
                  ? " اختر الفرق الخاصه بطولات Classique ,vip ,Cup"
                  : addOrgCubit.indexPageOrganizer == 3 &&
                          addOrgCubit.isTeams1000
                      ? " اختر الفرق الخاصه بطولات 1000 team"
                      : "",
          textDirection: TextDirection.rtl,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        const Expanded(
            child: ShowTeams(
          forOrg: true,
        )),
      ],
    );
  }
}
