part of 'add_orgaizer_cubit.dart';

@immutable
abstract class AddOrganizerState {}

class AddOrganizerInitial extends AddOrganizerState {}
class AddImageOrganizerState extends AddOrganizerState {}
class RemoveImageOrgState extends AddOrganizerState {}
class CrudOrganizerLoadingState extends AddOrganizerState {}
class CrudOrganizerSuccessState extends AddOrganizerState {
  final String success;
  CrudOrganizerSuccessState(this.success);
}
class CrudOrganizerErrorState extends AddOrganizerState {
  final String error;

  CrudOrganizerErrorState(this.error);
}

