import 'package:flutter/material.dart';

import '../../../../../core/widget/dailog_error.dart';
import '../../viewModel/vip_championship_cubit.dart';
import 'button_action.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FailureWidget extends StatelessWidget {
  const FailureWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    final vipCubit = context.read<VipChampionshipCubit>();

    if (message ==
        'Bad state: cannot get a field on a DocumentSnapshotPlatform which does not exist') {
      return ButtonAction(
        onTap: () => vipCubit.createRound512(),
        label: ' انشاء  الدور 512',
      );
    } else {
      dialogError(context, "حدث خطاء غير متوقع برجا محاوله مره اخري", () async {
        vipCubit.getCurrentGameWeek();
      });
    }
    return const SizedBox();
  }

}
