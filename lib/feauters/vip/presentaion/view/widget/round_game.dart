import 'package:flutter/material.dart';

import '../../../../../core/widget/button_custom.dart';
import '../../../../../core/widget/dailog_error.dart';
import '../../viewModel/vip_championship_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoundVip extends StatelessWidget {
  const RoundVip(
      {super.key,
      required this.onTap,
      required this.label,
      required this.numGameWeek});

  final void Function() onTap;
  final String label;
  final int numGameWeek;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VipChampionshipCubit, VipChampionshipState>(
      listener: (context, state) {
        if (state is FailureGetGameWeek) {
          dialogError(context, state.message, () => onTap());
        }
      },
      builder: (context, state) {
        if (state is VipChampionshipLoading) {
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
                onTap: numGameWeek <= 15 ? () {} : onTap,
                label: label,
                width: 200,
                colorText: Colors.white,
                borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(6), right: Radius.circular(6)),
                height: 55,
                color: numGameWeek <= 15
                    ? Colors.red.withOpacity(0.07)
                    : Colors.red),
          ],
        );
      },
    );
  }
}
