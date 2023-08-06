import 'package:flutter/material.dart';

import '../../viewModel/vip_championship_cubit.dart';
import 'button_action.dart';
import 'failureWidget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameWeek extends StatelessWidget {
  const GameWeek({super.key});

  @override
  Widget build(BuildContext context) {
    final vipCubit = context.read<VipChampionshipCubit>();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<VipChampionshipCubit, VipChampionshipState>(
            builder: (context, state) {
              if (state is LoadingGetGameWeek) {
                return const Center(child: CircularProgressIndicator());
              } else
              if(vipCubit.gameWeek >= 1){
                return ButtonAction(
                  onTap: () => vipCubit.finishFirstGameWeek(),
                  label: 'انهاء جوله ${vipCubit.gameWeek}',
                  numGameWeek: vipCubit.gameWeek,
                );



              } else if (state is FailureGetGameWeek) {
                return FailureWidget(message: state.message);
              }
              return ButtonAction(
                onTap: () => vipCubit.createRound512(),
                label: ' انشاء الدور 512',
              );
            },
          ),
        ],
      ),
    );
  }
}
