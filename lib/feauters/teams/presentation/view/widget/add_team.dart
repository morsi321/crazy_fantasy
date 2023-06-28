import 'package:crazy_fantasy/core/constance/constance.dart';
import 'package:crazy_fantasy/core/extension/MediaQueryValues.dart';
import 'package:crazy_fantasy/core/widget/BoxColor.dart';
import 'package:crazy_fantasy/core/widget/IconButtonCustom.dart';
import 'package:crazy_fantasy/core/widget/blurBody.dart';
import 'package:crazy_fantasy/feauters/teams/Data/models/team.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widget/drop_down_custom.dart';
import '../../../../../core/widget/labelAndTextForm.dart';
import '../../../../../core/widget/my_snackBar.dart';
import '../../view model/add_team_cubit.dart';
import 'add_image_team.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTeam extends StatelessWidget {
  const AddTeam({super.key});

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
        onWillPop: () async {
          BlocProvider.of<AddTeamCubit>(context).clearDataTeam();
      return true;
    },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  width: context.width * .80,
                  height: context.height * .05,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  child: const Center(
                      child: Text(
                    'اضافه فريق',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'janna',
                        fontWeight: FontWeight.w500),
                  ))),
              const SizedBox(height: 20),
              LabelAndTextForm(
                label: 'Name Team',
                controller:
                    BlocProvider.of<AddTeamCubit>(context).nameTeamController,
              ),
              const SizedBox(height: 20),
              LabelAndTextForm(
                label: 'Manager ID',
                controller: BlocProvider.of<AddTeamCubit>(context).mangerId,
              ),
              const SizedBox(height: 20),
              BoxColor(
                  width: double.infinity,
                  color: Colors.white.withOpacity(.1),
                  child: BlocBuilder<AddTeamCubit, AddTeamState>(
                    builder: (context, state) {
                      return DroDownCustom(
                        colorBorder: Colors.transparent,
                        onTap: (String? value) {
                          BlocProvider.of<AddTeamCubit>(context)
                              .changeChampionShip(value!);
                        },
                        items: championShip,
                        labelDropDown: '',
                        selectedValue:
                            BlocProvider.of<AddTeamCubit>(context).championship,
                      );
                    },
                  )),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LabelAndTextForm(
                    label: 'Fantasy ID 1',
                    controller: BlocProvider.of<AddTeamCubit>(context).fantasyID1,
                    width: context.width * .46,
                  ),
                  LabelAndTextForm(
                    label: 'Fantasy ID 2',
                    controller: BlocProvider.of<AddTeamCubit>(context).fantasyID2,
                    width: context.width * .46,
                  ),
                ],
              ),
              const AddImageTeam(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LabelAndTextForm(
                    label: 'Fantasy ID 3',
                    controller: BlocProvider.of<AddTeamCubit>(context).fantasyID3,
                    width: context.width * .46,
                  ),
                  LabelAndTextForm(
                    label: 'Fantasy ID 4',
                    controller: BlocProvider.of<AddTeamCubit>(context).fantasyID4,
                    width: context.width * .46,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              LabelAndTextForm(
                label: 'Fantasy ID 5 (this is Captain)',
                controller: BlocProvider.of<AddTeamCubit>(context).fantasyID5,
              ),
              const SizedBox(height: 20),
              const AddTeamButton(),
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
        if (state is SuccessfulAddTeamState) {
          mySnackBar(context, message: state.message, color: Colors.green);
        } else if (state is FailureAddTeamState) {
          mySnackBar(context, message: state.message, color: Colors.red);
        }
      },
      builder: (context, state) {
        if (state is LoadingAddTeamChampionState) {
          return const Center(child: CircularProgressIndicator());
        }

        return IconButtonCustom(
            height: 55,
            iconColor: Colors.white,
            width: 150,
            borderRadius: BorderRadius.circular(8),
            color: Colors.white.withOpacity(.1),
            iconSize: 30,
            icon: Icons.add,
            onTap: () {
              BlocProvider.of<AddTeamCubit>(context).addOrUpdateTeam(context);
            });
      },
    );
  }
}
