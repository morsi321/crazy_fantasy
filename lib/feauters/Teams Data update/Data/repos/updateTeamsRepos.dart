import 'package:dartz/dartz.dart';


abstract class UpdateTeamsRepo {
  // Future<Either<String, String>> updateTeams({required void Function(int countUpdate, int total) onSendProgress});

  Future<Either<String, String>> finishGameWeek({required void Function(int countUpdate, int total)
  onSendProgress});

  Future<Either<String, String>> getLastUpdate();
  Future<Either<String, int>> getCurrentGameWeek();
  Future<Either<String, String>> startSeason();



}


