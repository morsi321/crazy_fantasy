import 'package:bloc/bloc.dart';
import 'package:crazy_fantasy/feauters/organizers/Data/models/orgnizer_model.dart';
import 'package:meta/meta.dart';

import '../../../organizers/Data/repos/addOrg/addOrganizerRepoImpl.dart';
import '../../Data/repos/update_teams_repo_impl.dart';

part 'update_data_team_state.dart';

class UpdateDataTeamCubit extends Cubit<UpdateDataTeamState> {
  UpdateDataTeamCubit() : super(UpdateDataTeamInitial());
  String lastDateUpdate = '';
  List<Organizer> organizers = [];

  int? gameWeek;

  startSeason({required Organizer org}) async {
    emit(StartSeasonLoading());
    var response = await UpdateTeamsRepoImpl().startSeason(org: org);
    response.fold((failure) {
      emit(FailureStartSeason(message: failure));
    }, (_) async {
      await getAllOrgs();
      emit(SuccessfulStartSeason());
    });
  }

  updateTeamOrg({required Organizer org,}) async {
    emit(UpdateAllTeamLoading());
    var response = await UpdateTeamsRepoImpl().finishGameWeek(
        org: org,);
        response.fold((failure)
    {
      emit(FailureUpdateAllTeam(message: failure));
    }, (s) async {
    await getAllOrgs();
    emit(SuccessfulUpdateAllTeam(message: s));
    });
  }


  getAllOrgs() {
    emit(GetAllOrgsLoading());
    AddOrganizerRepoImpl().getOrganizer().then((value) {
      value.fold((failure) {
        emit(FailureGetAllOrgs(message: failure));
      }, (orgs) {
        organizers = orgs;
        emit(SuccessfulGetAllOrgs());
      });
    });
  }
}
