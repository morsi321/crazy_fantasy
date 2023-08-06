import 'package:crazy_fantasy/core/extension/MediaQueryValues.dart';
import 'package:crazy_fantasy/core/widget/IconButtonCustom.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widget/labelAndTextForm.dart';
import '../../../../../core/widget/my_snackBar.dart';
import '../../view model/add_team_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../organizers/presentation/view/widget/add org/championships.dart';
import 'image_team.dart';

class AddTeam extends StatelessWidget {
  const AddTeam({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<AddTeamCubit>(context).clearDataTeam();
        return true;
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                    width: context.width * .80,
                    height: context.height * .05,
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    child: Center(
                        child: Text(
                      BlocProvider.of<AddTeamCubit>(context).isUpdate
                          ? 'تعديل فريق'
                          : BlocProvider.of<AddTeamCubit>(context).isView
                              ? 'عرض فريق'
                              : 'اضافة فريق',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'janna',
                          fontWeight: FontWeight.w500),
                    ))),
              ),
              const SizedBox(height: 20),
              LabelAndTextForm(
                label: 'اسم فريق ',
                controller:
                    BlocProvider.of<AddTeamCubit>(context).nameTeamController,
                enable: BlocProvider.of<AddTeamCubit>(context).isView,
              ),
              const SizedBox(height: 20),
              LabelAndTextForm(
                label: 'الدولة',
                controller:
                    BlocProvider.of<AddTeamCubit>(context).countryController,
                enable: BlocProvider.of<AddTeamCubit>(context).isView,
              ),
              const SizedBox(height: 20),
              LabelAndTextForm(
                label: 'Manager ID',
                controller: BlocProvider.of<AddTeamCubit>(context).mangerId,
                enable: BlocProvider.of<AddTeamCubit>(context).isView,
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LabelAndTextForm(
                    label: 'Fantasy ID 1',
                    controller:
                        BlocProvider.of<AddTeamCubit>(context).fantasyID1,
                    width: context.width * .46,
                    enable: BlocProvider.of<AddTeamCubit>(context).isView,
                  ),
                  LabelAndTextForm(
                    label: 'Fantasy ID 2',
                    controller:
                        BlocProvider.of<AddTeamCubit>(context).fantasyID2,
                    width: context.width * .46,
                    enable: BlocProvider.of<AddTeamCubit>(context).isView,
                  ),
                ],
              ),
              const Center(child: ImageTeam()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LabelAndTextForm(
                    label: 'Fantasy ID 3',
                    controller:
                        BlocProvider.of<AddTeamCubit>(context).fantasyID3,
                    width: context.width * .46,
                    enable: BlocProvider.of<AddTeamCubit>(context).isView,
                  ),
                  LabelAndTextForm(
                    label: 'Fantasy ID 4',
                    enable: BlocProvider.of<AddTeamCubit>(context).isView,
                    controller:
                        BlocProvider.of<AddTeamCubit>(context).fantasyID4,
                    width: context.width * .46,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              LabelAndTextForm(
                label: 'Captain ID',
                enable: BlocProvider.of<AddTeamCubit>(context).isView,
                controller: BlocProvider.of<AddTeamCubit>(context).captain,
              ),
              const SizedBox(height: 20),
              const Championships(),
              BlocProvider.of<AddTeamCubit>(context).isView
                  ? const SizedBox()
                  : const AddTeamButton(),
              const SizedBox(height: 200),
            ],
          ),
        ),
      ),
    );
  }
}

class AddTeamButton extends StatelessWidget {
  const AddTeamButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddTeamCubit, AddTeamState>(
      listener: (context, state) {
        if (state is SuccessfulCrudState) {
          mySnackBar(context, message: state.message, color: Colors.green);
        } else if (state is FailureCrudTeamState) {
          mySnackBar(context, message: state.message, color: Colors.red);
        }
      },
      builder: (context, state) {
        if (state is LoadingCrudChampionState) {
          return const Center(child: CircularProgressIndicator());
        }

        return Center(
          child: IconButtonCustom(
              height: 55,
              iconColor: Colors.white,
              width: 150,
              borderRadius: BorderRadius.circular(8),
              color: Colors.white.withOpacity(.1),
              iconSize: 30,
              icon: Icons.add,
              onTap: () {
                BlocProvider.of<AddTeamCubit>(context)
                    .checkValidationAddTeam(context);
              }),
        );
      },
    );
  }
}
