import 'package:crazy_fantasy/core/widget/cash_image_network.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view Model/add_orgaizer_cubit.dart';
import 'AddImageTeam.dart';

class ImageOrganizer extends StatelessWidget {
  const ImageOrganizer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddOrganizerCubit, AddOrganizerState>(
      builder: (context, state) {
        return SizedBox(
          child:
              BlocProvider.of<AddOrganizerCubit>(context).pathImageTeamUpdate ==
                      null
                  ? const AddImageOrganizer()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          CashImageNetwork(
                              width: 250,
                              height: 150,
                              borderRadius: BorderRadius.circular(8),
                              url: BlocProvider.of<AddOrganizerCubit>(context)
                                  .pathImageTeamUpdate!),
                          !  BlocProvider.of<AddOrganizerCubit>(context).isView?                IconButton(
                              onPressed: ()=>BlocProvider.of<AddOrganizerCubit>(context)
                                  .removeImageOrg(),
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ))
                              : const SizedBox(),
                        ],
                      ),
                    ),
        );
      },
    );
  }
}
