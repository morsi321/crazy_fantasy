
import 'package:crazy_fantasy/feauters/organizers/Data/models/orgnizer_model.dart';

abstract class OrganizeVipChampionshipRepo {
  Future handeVip512({required Organizer org});
  Future handeVip256({required Organizer org});
  Future handeVip128({required Organizer org});

  Future  createVip({required Organizer org});

  Future doSecondRound({required String org, required String numRound});
  Future doRound({required int numRound ,required String org});
  Future doRound8({required String org});
  // Future<Either<String, int>> getCurrentGameWeek();
  Future finishGameWeekInRound({required int numRound,required String org, required int numGameWeek});
  Future finishGameWeeKInLastRound({required String org, required int numGameWeek});
  Future finishGameWeek({required String orgName, required int numGameWeek, required String numRound});
}
