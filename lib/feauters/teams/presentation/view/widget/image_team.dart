import 'package:crazy_fantasy/core/widget/cash_image_network.dart';
import 'package:crazy_fantasy/feauters/teams/presentation/view/widget/add_image_team.dart';
import 'package:flutter/material.dart';

import '../../view model/add_team_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageTeam extends StatelessWidget {
  const ImageTeam({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTeamCubit, AddTeamState>(
  builder: (context, state) {
    return SizedBox(
      child: BlocProvider.of<AddTeamCubit>(context).pathImageTeamUpdate == null
          ? const AddImageTeam()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  CashImageNetwork(
                      width: 250,
                      height: 150,
                      borderRadius: BorderRadius.circular(8),
                      url: BlocProvider.of<AddTeamCubit>(context)
                          .pathImageTeamUpdate!),
                  !BlocProvider.of<AddTeamCubit>(context).isView && ! BlocProvider.of<AddTeamCubit>(context).isCloseUpdate  ?                IconButton(
                      onPressed: ()=>BlocProvider.of<AddTeamCubit>(context)
                          .removeImageTeam(),
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      )):const SizedBox(),
                ],
              ),
            ),
    );
  },
);
  }
}

