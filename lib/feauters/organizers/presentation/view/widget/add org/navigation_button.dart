import 'package:crazy_fantasy/core/widget/IconButtonCustom.dart';
import 'package:crazy_fantasy/core/widget/button_custom.dart';
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
                          onTap: () =>
                              orgCubit.checkValidationAddOrg(true, context))
                      : const SizedBox(),
              const SizedBox(
                width: 3,
              ),
              orgCubit.indexPageOrganizer == 2 &&
                      (orgCubit.isCup ||
                          orgCubit.isVipLeague ||
                          orgCubit.isClassicLeague ||
                          orgCubit.isCup) &&
                      !orgCubit.isTeams1000
                  ? const SubmitButton()
                  : orgCubit.indexPageOrganizer == 3 && orgCubit.isTeams1000
                      ? const SubmitButton()
                      : !orgCubit.isTeams1000 &&
                              orgCubit.indexPageOrganizer == 2
                          ? const SubmitButton()
                          : orgCubit.indexPageOrganizer == 2 &&
                                  orgCubit.isTeams1000 &&
                                  (!orgCubit.isCup &&
                                      !orgCubit.isVipLeague &&
                                      !orgCubit.isCup &&
                                      !orgCubit.isClassicLeague)
                              ? const SubmitButton()
                              : IconButtonCustom(
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
                                  onTap: () => orgCubit.checkValidationAddOrg(
                                      false, context)),
            ],
          );
        },
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {

    final orgCubit = BlocProvider.of<AddOrganizerCubit>(context);
    final String label = orgCubit.isUpdate ? "تعديل منظم" : "اضافه منظم";
    return BlocBuilder<AddOrganizerCubit, AddOrganizerState>(
      builder: (context, state) {
        if (state is CrudOrganizerLoadingState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ButtonCustom(
                onTap: () {},
                label: label,
                fontSize: 20,
                color: Colors.white,
                height: 65,
                width: 130,
              ),
              Container(
                height: 65,
                width: 70,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(10)),
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          );
        }
        return ButtonCustom(
          onTap: () => orgCubit.addOrUpdateOrganize(context),
          label: label,
          fontSize: 20,
          color: Colors.white,
          height: 65,
          width: 150,
          borderRadius:
              const BorderRadius.horizontal(right: Radius.circular(10)),
        );
      },
    );
  }
}
