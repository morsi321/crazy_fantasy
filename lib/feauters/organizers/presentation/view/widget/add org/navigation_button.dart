import 'package:crazy_fantasy/core/widget/IconButtonCustom.dart';
import 'package:flutter/material.dart';

import '../../../view Model/add_orgaizer_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationButton extends StatelessWidget {
  const NavigationButton({super.key});

  @override
  Widget build(BuildContext context) {
    final orgCubit = BlocProvider.of<AddOrganizerCubit>(context);
    return Positioned(
      bottom: 50,
      child: BlocBuilder<AddOrganizerCubit, AddOrganizerState>(
        builder: (context, state) {
          return Row(
            children: [
              orgCubit.indexPageOrganizer != 0
                  ? IconButtonCustom(
                      height: 65,
                      width: 68,
                      borderRadius: BorderRadius.horizontal(
                          left: const Radius.circular(10),
                          right: orgCubit.indexPageOrganizer != 0
                              ? const Radius.circular(0)
                              : const Radius.circular(10)),
                      color: Colors.white,
                      icon: Icons.arrow_back_ios,
                      onTap: () => orgCubit.changeIndexPageOrganizer(true))
                  : const SizedBox(),
              const SizedBox(
                width: 3,
              ),
              IconButtonCustom(
                  height: 65,
                  width: 68,
                  borderRadius: BorderRadius.horizontal(
                      right: const Radius.circular(10),
                      left: orgCubit.indexPageOrganizer != 0
                          ? const Radius.circular(0)
                          : const Radius.circular(10)),
                  color: Colors.white,
                  icon: orgCubit.indexPageOrganizer == 0
                      ? Icons.add
                      : Icons.arrow_forward_ios,
                  onTap: () => orgCubit.changeIndexPageOrganizer(false)),
            ],
          );
        },
      ),
    );
  }
}
