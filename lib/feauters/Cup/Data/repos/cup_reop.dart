import 'package:dartz/dartz.dart';

import '../../../organizers/Data/models/orgnizer_model.dart';

abstract class OrganizeCupChampionshipRepo {
  Future<Either<String, String>> createCup({required Organizer org});

  Future<Either<String, String>> doRound({required int numRound, required String orgId,});

  Future handeCup512({required Organizer org});

  Future handeCup256({required Organizer org});

  Future handeCup128({required Organizer org});
}
