part of 'update_data_team_cubit.dart';

@immutable
abstract class UpdateDataTeamState {}

class UpdateDataTeamInitial extends UpdateDataTeamState {}

class GetLastDateLoading extends UpdateDataTeamState {}

class SuccessfulGetLastDateUpdate extends UpdateDataTeamState {}

class FailureGetLastDateUpdate extends UpdateDataTeamState {
  final String message;

  FailureGetLastDateUpdate({required this.message});
}

class UpdateAllTeamLoading extends UpdateDataTeamState {
  final int sent;
  final int total;

  UpdateAllTeamLoading({required this.sent, required this.total});
}
class SuccessfulUpdateAllTeam extends UpdateDataTeamState {
  final String message;

  SuccessfulUpdateAllTeam({required this.message});
}
class FailureUpdateAllTeam extends UpdateDataTeamState {
  final String message;

  FailureUpdateAllTeam({required this.message});
}
class GetCurrentGameWeekLoading extends UpdateDataTeamState {}
class SuccessfulGetCurrentGameWeek extends UpdateDataTeamState {

}
class StartSeasonLoading extends UpdateDataTeamState {}
class SuccessfulStartSeason extends UpdateDataTeamState {}
class FailureStartSeason extends UpdateDataTeamState {
  final String message;

  FailureStartSeason({required this.message});
}
class FailureGetCurrentGameWeek extends UpdateDataTeamState {
  final String message;

  FailureGetCurrentGameWeek({required this.message});
}


