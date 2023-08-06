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
    return BlocBuilder<AddOrganizerCubit, AddOrganizerState>(
      builder: (context, state) {
        if (BlocProvider.of<AddOrganizerCubit>(context).indexPageOrganizer ==
            2) {
          return const AppBarSearchTeam();
        } else {
          return const AppBarCustom(
            title: 'المنظمين',
          );
        }
      },
    );
  }
}
