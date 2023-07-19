import 'package:dartz/dartz.dart';

abstract class OrganizeCupChampionshipRepo {
  Future<Either<String, String>> createCup();

  Future<Either<String, String>> doRound({required int numRound});
}
