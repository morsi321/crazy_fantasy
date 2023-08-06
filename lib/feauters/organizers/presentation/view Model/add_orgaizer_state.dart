part of 'add_orgaizer_cubit.dart';

@immutable
abstract class AddOrganizerState {}

class AddOrganizerInitial extends AddOrganizerState {}
class AddImageOrganizerState extends AddOrganizerState {}
class RemoveImageOrgState extends AddOrganizerState {}
class CrudOrganizerLoadingState extends AddOrganizerState {}
class GetOrganizerLoadingState extends AddOrganizerState {}
class ChangeIndexPageOrganizerState extends AddOrganizerState {}
class CrudOrganizerSuccessState extends AddOrganizerState {
  final String success;
  CrudOrganizerSuccessState(this.success);
}
class CrudOrganizerErrorState extends AddOrganizerState {
  final String error;

  CrudOrganizerErrorState(this.error);
}class GetOrganizerSuccessState extends AddOrganizerState {
  GetOrganizerSuccessState();
}
class GetOrganizerErrorState extends AddOrganizerState {
  final String error;

  GetOrganizerErrorState(this.error);
}

class ChangeIsTeams1000State extends AddOrganizerState {}
class ChangeIsCupState extends AddOrganizerState {}
class ChangeIsClassicLeagueState extends AddOrganizerState {}
class ChangeIsVipLeagueState extends AddOrganizerState {}
class ChangeCountTeamsState extends AddOrganizerState {}
class AddTeamOrgState extends AddOrganizerState {}
class RemoveTeamOrgState extends AddOrganizerState {}


