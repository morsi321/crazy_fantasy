import 'package:crazy_fantasy/core/extension/MediaQueryValues.dart';
import 'package:crazy_fantasy/core/widget/cash_image_network.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../teams/presentation/view/widget/dailog_delete.dart';
import '../../../Data/models/orgnizer_model.dart';
import '../../view Model/add_orgaizer_cubit.dart';

class ListOrganizerView extends StatelessWidget {
  const ListOrganizerView({super.key, required this.organizers});

  final List<Organizer> organizers;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: organizers.length,
        itemBuilder: (context, index) {
          return OrganizerItem(
            organizer: organizers[index],
            index: index + 1,
          );
        });
  }
}

class OrganizerItem extends StatelessWidget {
  const OrganizerItem(
      {super.key, required this.organizer, required this.index});

  final Organizer organizer;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 5.0,
      ),
      child: Container(
          width: double.infinity,
          height: 65,
          color: Colors.white.withOpacity(.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InfoDataOrganizer(
                organizer: organizer,
                index: index,
              ),
              IconButton(
                  onPressed: () {
                    BlocProvider.of<AddOrganizerCubit>(context)
                        .editOrganizer(organizer, context);
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {
                    showDailogDeleteOrg(
                        context,
                        organizer.id!,
                        organizer.otherChampionshipsTeams!
                            .map((e) => e["id"] as String)
                            .toList(),
                        organizer.teams1000Id!,
                        organizer.image!,
                        organizer.name!);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ))
            ],
          )),
    );
  }
}

class InfoDataOrganizer extends StatelessWidget {
  const InfoDataOrganizer(
      {super.key, required this.organizer, required this.index});

  final Organizer organizer;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * .7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            index.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(
            width: context.width * .52,
            child: Row(
              children: [
                CashImageNetwork(url: organizer.image!, width: 50, height: 50),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(
                    organizer.name!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'janna'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
