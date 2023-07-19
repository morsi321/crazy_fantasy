import 'package:dartz/dartz.dart';

abstract class OrganizeVipChampionshipRepo {
  Future<Either<String, String>> createVip();

  Future<Either<String, String>> doRound256();
  Future<Either<String, String>> doRound({required int numRound });
  Future<Either<String, String>> doRound8();
  Future<Either<String, int>> getCurrentGameWeek();
  Future<Either<String, String>> removeFirstGameWeek();
  // Future<Either<String, String>> removeRound();
  Future<Either<String, String>> finishGameWeek();
}
