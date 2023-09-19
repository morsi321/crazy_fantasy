
import 'package:dartz/dartz.dart';

import '../../../../../core/models/team.dart';


abstract class AddTeamRepo {
  Future<Either<String, String>> addTeam({required String id,required Team teamModel});

  Future<Either<String, String>> updateTeam(
      {required String id, required Team teamModel});

  Future<Either<String, String>> deleteTeam({required String id});

  Future<Either<String, List<Team>>> getTeams();

}
