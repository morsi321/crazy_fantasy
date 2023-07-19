import 'package:crazy_fantasy/core/widget/button_custom.dart';
import 'package:crazy_fantasy/feauters/vip/presentaion/view/widget/button_action.dart';
import 'package:crazy_fantasy/feauters/vip/presentaion/view/widget/failureWidget.dart';
import 'package:crazy_fantasy/feauters/vip/presentaion/view/widget/game_week.dart';
import 'package:crazy_fantasy/feauters/vip/presentaion/view/widget/round_game.dart';
import 'package:crazy_fantasy/feauters/vip/presentaion/viewModel/vip_championship_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widget/dailog_error.dart';

class VipViewBody extends StatefulWidget {
  const VipViewBody({super.key});

  @override
  State<VipViewBody> createState() => _VipViewBodyState();
}

class _VipViewBodyState extends State<VipViewBody> {
  @override
  void initState() {
    context.read<VipChampionshipCubit>().getCurrentGameWeek();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vipCubit = context.read<VipChampionshipCubit>();
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const GameWeek(),
          const SizedBox(height: 20,),
          RoundVip(onTap: (){}, label: "انشاء الدور  256", numGameWeek: vipCubit.gameWeek,)

        ],
      ),
    );
  }
}
