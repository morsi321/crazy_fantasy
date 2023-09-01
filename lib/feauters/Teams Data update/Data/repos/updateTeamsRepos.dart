import 'package:crazy_fantasy/feauters/organizers/Data/models/orgnizer_model.dart';
import 'package:dartz/dartz.dart';

abstract class UpdateTeamsRepo {
  // Future<Either<String, String>> updateTeams({required void Function(int countUpdate, int total) onSendProgress});

  Future<Either<String, String>> finishGameWeek(
      {required Organizer org,
      required void Function(int countUpdate, int total) onSendProgress,
      });


  Future<Either<String, String>> startSeason({required Organizer org});
}
