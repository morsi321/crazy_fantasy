import 'package:dartz/dartz.dart';

import '../../models/orgnizer_model.dart';

abstract class AddOrganizerRepo {
  Future<Either<String, String>> addOrganizer(
      {required Organizer organizerModel});
  Future<Either<String, String>> deleteOrganizer(
      {required String id ,required List<String> idTeams,});
  Future<Either<String, String>> updateOrganizer(
      {required String id, required Organizer organizerModel});
  Future<Either<String, List<Organizer>>> getOrganizer();



}