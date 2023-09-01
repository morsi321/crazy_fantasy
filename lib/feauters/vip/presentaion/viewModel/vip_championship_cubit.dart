import 'package:bloc/bloc.dart';
import 'package:crazy_fantasy/feauters/vip/Data/repo/vip_repo_impl.dart';
import 'package:meta/meta.dart';

part 'vip_championship_state.dart';

class VipChampionshipCubit extends Cubit<VipChampionshipState> {
  VipChampionshipCubit() : super(VipChampionshipInitial());
  int gameWeek = 0;

  getCurrentGameWeek() async {
    emit(LoadingGetGameWeek());
    var result = await OrganizeVipChampionshipRepoImpl().getCurrentGameWeek();
    result.fold((l) {
      emit(FailureGetGameWeek(message: l.toString()));
    }, (r) {
      gameWeek = r;
      emit(SuccessfulGetGameWeek(gameWeek: r));
    });
  }

  void finishFirstGameWeek() async {
    emit(FinishGameWeekLoading());

    // var result = await handVip();
    //
    // getCurrentGameWeek();
    //
    // result.fold((l) {
    //   emit(FailureFinishGameWeekState(
    //     message: l.toString(),
    //   ));
    // }, (r) {
    //   emit(SuccessfulFinishGameWeekState(
    //     message: r.toString(),
    //   ));
    // });
  }

  void removeFirstGameWeek() async {
    // emit(VipChampionshipLoading());
    //
    // var result = await OrganizeVipChampionshipRepoImpl().removeFirstGameWeek();
    // getCurrentGameWeek();
    //
    // result.fold((l) {
    //   emit(FailureCreateVipChampionshipState(
    //     message: l.toString(),
    //   ));
    // }, (r) {
    //   emit(SuccessfulCreateVipChampionshipState(
    //     message: r.toString(),
    //   ));
    // });
  }

  void createRound512() async {
    emit(VipChampionshipLoading());

    // var result = await OrganizeVipChampionshipRepoImpl().createVip();
    await getCurrentGameWeek();

    // result.fold((l) {
    //   emit(FailureCreateVipChampionshipState(
    //     message: l.toString(),
    //   ));
    // }, (r) {
    //   emit(SuccessfulCreateVipChampionshipState(
    //     message: r.toString(),
    //   ));
    // });
  }

// handVip() async {
//   var result;
//
//   if (gameWeek >= 1 && gameWeek <= 15) {
//     result = await OrganizeVipChampionshipRepoImpl().finishGameWeek();
//   } else if (gameWeek == 16) {
//     await OrganizeVipChampionshipRepoImpl().doRound256();
//
//     result = await OrganizeVipChampionshipRepoImpl()
//         .finishGameWeekInRound(numRound: 256);
//   } else if (gameWeek == 17) {
//     result = await OrganizeVipChampionshipRepoImpl()
//         .finishGameWeekInRound(numRound: 256);
//   } else if (gameWeek == 18) {
//     await OrganizeVipChampionshipRepoImpl().doRound(numRound: 128);
//     result = await OrganizeVipChampionshipRepoImpl()
//         .finishGameWeekInRound(numRound: 128);
//   } else if (gameWeek == 19) {
//     result = await OrganizeVipChampionshipRepoImpl()
//         .finishGameWeekInRound(numRound: 128);
//   } else if (gameWeek == 20) {
//
//     await OrganizeVipChampionshipRepoImpl().doRound(numRound: 64);
//     result = await OrganizeVipChampionshipRepoImpl()
//         .finishGameWeekInRound(numRound: 64);
//   } else if (gameWeek == 21) {
//     result = await OrganizeVipChampionshipRepoImpl()
//         .finishGameWeekInRound(numRound: 64);
//   }
//   else if (gameWeek == 22) {
//     await OrganizeVipChampionshipRepoImpl().doRound(numRound: 32);
//     result = await OrganizeVipChampionshipRepoImpl()
//         .finishGameWeekInRound(numRound: 32);
//   } else if (gameWeek == 23) {
//     result = await OrganizeVipChampionshipRepoImpl()
//         .finishGameWeekInRound(numRound: 32);
//   } else if (gameWeek == 24) {
//     await OrganizeVipChampionshipRepoImpl().doRound(numRound: 16);
//     result = await OrganizeVipChampionshipRepoImpl()
//         .finishGameWeekInRound(numRound: 16);
//   } else if (gameWeek == 25) {
//     result = await OrganizeVipChampionshipRepoImpl()
//         .finishGameWeekInRound(numRound: 16);
//   } else if (gameWeek == 26) {
//     await OrganizeVipChampionshipRepoImpl().doRound8();
//     result =
//     await OrganizeVipChampionshipRepoImpl().finishGameWeeKInLastRound();
//   } else if (gameWeek > 26 && gameWeek <= 32) {
//     result =
//     await OrganizeVipChampionshipRepoImpl().finishGameWeeKInLastRound();
//   }
//   return result;
// }
}
