import 'package:crazy_fantasy/feauters/vip/presentaion/view/widget/game_week.dart';
import 'package:crazy_fantasy/feauters/vip/presentaion/viewModel/vip_championship_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GameWeek(),
          SizedBox(
            height: 20,
          ),
          // RoundVip(
          //   onTap: () {},
          //   label: "انشاء الدور  256",
          //   numGameWeek: vipCubit.gameWeek,
          // )
        ],
      ),
    );
  }
}
