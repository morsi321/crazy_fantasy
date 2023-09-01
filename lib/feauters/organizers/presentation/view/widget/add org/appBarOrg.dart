import 'package:flutter/material.dart';

import '../../../../../../core/widget/AppBar_custom.dart';
import '../../../view Model/add_orgaizer_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'appBar_searchTeam.dart';

class AppBarOrg extends StatefulWidget implements PreferredSizeWidget {
  const AppBarOrg({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _AppBarOrgState createState() => _AppBarOrgState();
}

class _AppBarOrgState extends State<AppBarOrg> {
  @override
  Widget build(BuildContext context) {
    final addOrgCubit = context.read<AddOrganizerCubit>();
    return BlocBuilder<AddOrganizerCubit, AddOrganizerState>(
      builder: (context, state) {
        if (addOrgCubit.indexPageOrganizer >= 2) {
          return AppBarSearchTeam(
            counter: addOrgCubit.isTeams1000 &&
                    !(addOrgCubit.isVipLeague ||
                        addOrgCubit.isClassicLeague ||
                        addOrgCubit.isCup)
                ? addOrgCubit.teams1000.length
                : addOrgCubit.indexPageOrganizer == 2 &&
                        (addOrgCubit.isCup ||
                            addOrgCubit.isVipLeague ||
                            addOrgCubit.isClassicLeague)
                    ? addOrgCubit.teams.length
                    : addOrgCubit.indexPageOrganizer == 3 &&
                            addOrgCubit.isTeams1000
                        ? addOrgCubit.teams1000.length
                        : 0,
          );
        } else {
          return const AppBarCustom(
            title: 'المنظمين',
          );
        }
      },
    );
  }
}
