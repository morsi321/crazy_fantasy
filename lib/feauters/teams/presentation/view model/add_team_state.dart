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

class SuccessfulGetTeamsState extends AddTeamState {
}

class FailureGetTeamsState extends AddTeamState {
  final String message;

  FailureGetTeamsState(this.message);
}


