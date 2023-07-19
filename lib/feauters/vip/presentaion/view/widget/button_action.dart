import 'package:crazy_fantasy/feauters/vip/presentaion/viewModel/vip_championship_cubit.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widget/button_custom.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widget/dailog_error.dart';

class ButtonAction extends StatelessWidget {
  const ButtonAction(
      {super.key, required this.onTap, required this.label, this.numGameWeek});

  final void Function() onTap;
  final int? numGameWeek;
  final String label;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VipChampionshipCubit, VipChampionshipState>(
      listener: (context, state) {
        if (state is FailureFinishGameWeekState) {
          dialogError(context, state.message, () => onTap());
        }
      },
      builder: (context, state) {
        if (state is FinishGameWeekLoading) {
          return Container(
            height: 65,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Loading...",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonCustom(
              fontSize: 20,
              onTap: onTap,
              label: label,
              width: 200,
              colorText: Colors.white,
              borderRadius: BorderRadius.horizontal(
                left: const Radius.circular(6),
                right: numGameWeek == null || numGameWeek == 1
                    ? const Radius.circular(6)
                    : const Radius.circular(0),
              ),
              height: 55,
              color: Colors.red,
            ),
            const SizedBox(
              width: 3,
            ),
            numGameWeek == null || numGameWeek == 1
                ? const SizedBox()
                : ButtonCustom(
                    fontSize: 20,
                    onTap: ()=> context.read<VipChampionshipCubit>().removeFirstGameWeek(),
                    label: "مسح جوله ${numGameWeek! - 1}",
                    width: 150,
                    colorText: Colors.white,
                    borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(6)),
                    height: 55,
                    color: Colors.red,
                  ),
          ],
        );
      },
    );
  }
}
