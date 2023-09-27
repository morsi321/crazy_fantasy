
import '../../../organizers/Data/models/orgnizer_model.dart';

abstract class OrganizeClassicLeagueRepo {
  Future  createClassicLeague({required Organizer org});

  Future handel512Classic({required Organizer org});
  Future handel128Classic({required Organizer org});
  Future handel256Classic({required Organizer org});

}
