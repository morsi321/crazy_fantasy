import 'package:bloc/bloc.dart';
import 'package:crazy_fantasy/feauters/vip/Data/repo/vip_repo.dart';
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

    var result = await OrganizeVipChampionshipRepoImpl().finishGameWeek();

     getCurrentGameWeek();

    result.fold((l) {
      emit(FailureFinishGameWeekState(
        message: l.toString(),
      ));
    }, (r) {
      emit(SuccessfulFinishGameWeekState(
        message: r.toString(),
      ));
    });
  } void removeFirstGameWeek() async {
    emit(VipChampionshipLoading());

    var result = await OrganizeVipChampionshipRepoImpl().removeFirstGameWeek();
     getCurrentGameWeek();

    result.fold((l) {
      emit(FailureCreateVipChampionshipState(
        message: l.toString(),
      ));
    }, (r) {
      emit(SuccessfulCreateVipChampionshipState(
        message: r.toString(),
      ));
    });
  }

  void createRound512() async {
    emit(VipChampionshipLoading());

    var result = await OrganizeVipChampionshipRepoImpl().createVip();
    await getCurrentGameWeek();

    result.fold((l) {
      emit(FailureCreateVipChampionshipState(
        message: l.toString(),
      ));
    }, (r) {
      emit(SuccessfulCreateVipChampionshipState(
        message: r.toString(),
      ));
    });
  }
}
