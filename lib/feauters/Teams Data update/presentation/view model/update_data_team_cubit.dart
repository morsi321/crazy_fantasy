import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Data/repos/update_teams_repo_impl.dart';

part 'update_data_team_state.dart';

class UpdateDataTeamCubit extends Cubit<UpdateDataTeamState> {
  UpdateDataTeamCubit() : super(UpdateDataTeamInitial());
  String lastDateUpdate = '';

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

  updateAllTeams() async {
    emit(UpdateAllTeamLoading(sent: 0, total: 1));
    var response = await UpdateTeamsRepoImpl().updateTeams(
        onSendProgress: (int sent, int total) {
      emit(UpdateAllTeamLoading(
        sent: sent,
        total: total,
      ));

    });
    response.fold((failure) {
      emit(FailureUpdateAllTeam(message: failure));
    }, (s)async {
    await  getLastDateUpdate();
      emit(SuccessfulUpdateAllTeam(message: s));
    });
  }
}
