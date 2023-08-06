import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view Model/add_orgaizer_cubit.dart';

class AddImageOrganizer extends StatelessWidget {
  const AddImageOrganizer({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<AddOrganizerCubit>(context).addImageOrganizer();
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
          child: BlocBuilder<AddOrganizerCubit, AddOrganizerState>(
              builder: (context, state) {
            if (BlocProvider.of<AddOrganizerCubit>(context).imagePath != null) {
              return ImageFile(
                  filePath:
                      BlocProvider.of<AddOrganizerCubit>(context).imagePath!);
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
