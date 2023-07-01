import 'dart:io';

import 'package:crazy_fantasy/feauters/teams/presentation/view%20model/add_team_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddImageTeam extends StatelessWidget {
  const AddImageTeam({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<AddTeamCubit>(context).addImageTeam();
      },
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 10,
          top: 15,
        ),
        child: Container(
          width: 250,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: BlocBuilder<AddTeamCubit, AddTeamState>(
              builder: (context, state) {
            if (BlocProvider.of<AddTeamCubit>(context).pathImageTeam != null) {
              return ImageFile(
                  filePath:
                      BlocProvider.of<AddTeamCubit>(context).pathImageTeam!);
            } else {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.white,
                    ),
                    Text(
                      'Add Image',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )
                  ],
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}

class ImageFile extends StatelessWidget {
  const ImageFile({super.key, required this.filePath});

  final String filePath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.file(File(filePath),
          width: 250, height: 150, fit: BoxFit.cover),
    );
  }
}
