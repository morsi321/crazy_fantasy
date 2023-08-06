import 'package:crazy_fantasy/feauters/organizers/presentation/view/widget/add%20org/ItemTeamSlected.dart';
import 'package:flutter/material.dart';

import '../../../view Model/add_orgaizer_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showTeamsSelected(context) {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color.fromRGBO(28, 22, 54, 1),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "الفرق المختارة",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: BlocBuilder<AddOrganizerCubit, AddOrganizerState>(
                    builder: (context, state) {
                      return ListSelectedItemTeamView(
                        teams: BlocProvider
                            .of<AddOrganizerCubit>(context)
                            .teams,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
