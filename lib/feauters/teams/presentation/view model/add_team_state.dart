part of 'add_team_cubit.dart';

@immutable
abstract class AddTeamState {}

class AddTeamInitial extends AddTeamState {}

class AddTeamChampionState extends AddTeamState {}

class LoadingAddTeamChampionState extends AddTeamState {}

class FailureAddTeamState extends AddTeamState {
  final String message;

  FailureAddTeamState({required this.message});
}

class SuccessfulAddTeamState extends AddTeamState {
  final String message;

  SuccessfulAddTeamState(this.message);
}

class LoadingGetTeamsState extends AddTeamState {}

class SuccessfulGetTeamsState extends AddTeamState {
}

class FailureGetTeamsState extends AddTeamState {
  final String message;

  FailureGetTeamsState(this.message);
}
