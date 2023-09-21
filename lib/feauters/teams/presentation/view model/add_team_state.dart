part of 'add_team_cubit.dart';

@immutable
abstract class AddTeamState {}

class AddTeamInitial extends AddTeamState {}

class AddTeamChampionState extends AddTeamState {}

class LoadingCrudChampionState extends AddTeamState {}

class RemoveImageTeamState extends AddTeamState {}

class FailureCrudTeamState extends AddTeamState {
  final String message;

  FailureCrudTeamState({required this.message});
}

class SuccessfulCrudState extends AddTeamState {
  final String message;

  SuccessfulCrudState(this.message);
}

class LoadingGetTeamsState extends AddTeamState {}

class ChangeChampionshipSelectedState extends AddTeamState {}

class ClearDataTeamState extends AddTeamState {}

class RemoveTeamFromShowState extends AddTeamState {}

class AddTeamToShowTeamState extends AddTeamState {}

class RemoveListOfTeamState extends AddTeamState {}

class SuccessfulGetTeamsState extends AddTeamState {}

class FailureGetTeamsState extends AddTeamState {
  final String message;

  FailureGetTeamsState(this.message);
}

class LoadingSearchState extends AddTeamState {}

class SuccessfulSearchState extends AddTeamState {
  final int length;

  SuccessfulSearchState({required this.length});
}

class FailureSeachState extends AddTeamState {
  final String message;

  FailureSeachState(this.message);
}

class LoadingAddLeaderState extends AddTeamState {}

class SuccessfulAddLeaderState extends AddTeamState {
  final String response;

  SuccessfulAddLeaderState({required this.response});
}

class FailureAddLeaderNameState extends AddTeamState {
  final String message;

  FailureAddLeaderNameState(this.message);
}
