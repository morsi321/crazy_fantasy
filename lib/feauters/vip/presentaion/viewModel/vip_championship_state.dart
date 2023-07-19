part of 'vip_championship_cubit.dart';

@immutable
abstract class VipChampionshipState {}

class VipChampionshipInitial extends VipChampionshipState {}
class LoadingGetGameWeek extends VipChampionshipState {}
class SuccessfulGetGameWeek extends VipChampionshipState {
  final int gameWeek;
  SuccessfulGetGameWeek({required this.gameWeek});
}
class FailureGetGameWeek extends VipChampionshipState {
  final String message;
  FailureGetGameWeek({required this.message});
}

class VipChampionshipLoading extends VipChampionshipState {}
class SuccessfulCreateVipChampionshipState extends VipChampionshipState {
  final String message;
  SuccessfulCreateVipChampionshipState({required this.message});
}
class FailureCreateVipChampionshipState extends VipChampionshipState {
  final String message;
  FailureCreateVipChampionshipState({required this.message});
}

class FinishGameWeekLoading extends VipChampionshipState {}
class SuccessfulFinishGameWeekState extends VipChampionshipState {
  final String message;
  SuccessfulFinishGameWeekState({required this.message});
}
class FailureFinishGameWeekState extends VipChampionshipState {
  final String message;
  FailureFinishGameWeekState({required this.message});
}


