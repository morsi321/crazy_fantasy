import 'package:crazy_fantasy/core/constance/colors.dart';
import 'package:crazy_fantasy/core/extension/MediaQueryValues.dart';
import 'package:crazy_fantasy/core/widget/button_custom.dart';
import 'package:crazy_fantasy/core/widget/labelAndTextForm.dart';
import 'package:crazy_fantasy/feauters/teams/presentation/view%20model/add_team_cubit.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widget/bootom_sheet_custom.dart';
import '../../../../../core/widget/card_white.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void addCaptain(
    BuildContext context, String mangerId, String teamId, String name) {
  final cubit = context.read<AddTeamCubit>();
  String lastIdUser = mangerId;
  TextEditingController mangerIdController =
      TextEditingController(text: mangerId);
  showBottomSheetCustom(
      context,
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          CardWhite(
            color: AppColors.mainColor,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "تسجيل قائد فريق",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Material(
                    color: Colors.transparent,
                    child: LabelAndTextForm(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          mangerIdController.clear();
                        },
                        child: Icon(
                          Icons.clear,
                          color: Colors.white,
                        ),
                      ),
                      label: 'Manger ID',
                      controller: mangerIdController,
                    )),
                SizedBox(
                  height: 30,
                ),
                BlocConsumer<AddTeamCubit, AddTeamState>(
                  builder: (context, state) {
                    if (state is LoadingAddLeaderState) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return ButtonCustom(
                      onTap: () => cubit.addLeaderInTeam(
                          idUser: mangerIdController.text.replaceAll(' ', ''),
                          teamId: teamId,
                          lastIdLeader: lastIdUser),
                      label: " ربط القائد بالفريق",
                      colorText: Colors.white,
                      width: context.width ,
                      fontSize: 20,
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.redAccent,
                    );
                  },
                  listener: (BuildContext context, AddTeamState state) {
                    if (state is SuccessfulAddLeaderState) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Directionality(
                              textDirection: TextDirection.rtl,
                              child: AlertDialog(
                                title: Text(
                                  "عمليه نجاحه",
                                  textAlign: TextAlign.center,

                                  style: TextStyle(
                                      color: Colors.green, fontSize: 30),
                                ),
                                content: Text(
                                  state.response,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 20),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("تم"))
                                ],
                              ),
                            );
                          });
                    } else if (state is FailureAddLeaderNameState) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Directionality(
                              textDirection: TextDirection.rtl,
                              child: AlertDialog(
                                title: Text(
                                  "تحذير",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 30),
                                ),
                                content: Text(state.message,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 20)),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "تم",
                                        style: TextStyle(fontSize: 20),
                                      ))
                                ],
                              ),
                            );
                          });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ));
}
