import 'package:dartz/dartz.dart';

abstract class OrganizeClassicLeagueRepo {
  Future<Either<String, String>> createClassicLeague();
  Future<Either<String, String>> doRound({required int numRound});

}
