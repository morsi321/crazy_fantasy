
abstract class OrganizeVipChampionshipRepo {
  Future handeVip({required int gameWeek, required String org});

  Future  createVip({required String org});

  Future doRound256({required String org});
  Future doRound({required int numRound ,required String org});
  Future doRound8({required String org});
  // Future<Either<String, int>> getCurrentGameWeek();
  Future finishGameWeekInRound({required int numRound,required String org});
  Future finishGameWeeKInLastRound({required String org});
  Future finishGameWeek({required String org});
}
