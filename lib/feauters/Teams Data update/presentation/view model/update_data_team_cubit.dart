import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Data/repos/update_teams_repo_impl.dart';

part 'update_data_team_state.dart';

class UpdateDataTeamCubit extends Cubit<UpdateDataTeamState> {
  UpdateDataTeamCubit() : super(UpdateDataTeamInitial());
  String lastDateUpdate = '';

  int? gameWeek;

  getLastDateUpdate() async {
    emit(GetLastDateLoading());
    var response = await UpdateTeamsRepoImpl().getLastUpdate();
    response.fold((failure) {
      emit(FailureGetLastDateUpdate(message: failure));
    }, (lastDateUpdate) {
      this.lastDateUpdate = lastDateUpdate;
      emit(SuccessfulGetLastDateUpdate());
    });
  }

  getCurrentGameWeek() {
    emit(GetCurrentGameWeekLoading());
    UpdateTeamsRepoImpl().getCurrentGameWeek().then((value) {
      value.fold((failure) {
        emit(FailureGetCurrentGameWeek(message: failure));
      }, (gameWeek) {
        this.gameWeek = gameWeek;

        emit(SuccessfulGetCurrentGameWeek());
      });
    });
  }

  startSeason() async {
    emit(StartSeasonLoading());
    var response = await UpdateTeamsRepoImpl().startSeason();
    response.fold((failure) {
      emit(FailureStartSeason(message: failure));
    }, (s) async {
      List<Future> futures = [
        getLastDateUpdate(),
        getCurrentGameWeek(),
      ];
      await Future.wait(futures);
      emit(SuccessfulStartSeason());
    });
  }

  updateAllTeams() async {
    emit(UpdateAllTeamLoading(sent: 0, total: 1));
    var response = await UpdateTeamsRepoImpl().finishGameWeek(
        onSendProgress: (int sent, int total) {
      emit(UpdateAllTeamLoading(
        sent: sent,
        total: total,
      ));
    });
    response.fold((failure) {
      emit(FailureUpdateAllTeam(message: failure));
    }, (s) async {
      List<Future> futures = [
        getLastDateUpdate(),
        getCurrentGameWeek(),
      ];
      await Future.wait(futures);
      emit(SuccessfulUpdateAllTeam(message: s));
    });
  }
}
