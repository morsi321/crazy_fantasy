import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:crazy_fantasy/core/constance/constance.dart';
import 'package:crazy_fantasy/core/servies/image_picker_servies.dart';
import 'package:crazy_fantasy/core/widget/bootom_sheet_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/servies/comperison_image.dart';

import '../../Data/models/team.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import '../../Data/repos/addTeam/add_team_repo_impl.dart';
import '../view/widget/add_team.dart';
import '../view/widget/dailog_validation.dart';

part 'add_team_state.dart';

class AddTeamCubit extends Cubit<AddTeamState> {
  AddTeamCubit() : super(AddTeamInitial());
  TextEditingController nameTeamController = TextEditingController();
  TextEditingController fantasyID1 = TextEditingController();
  TextEditingController fantasyID2 = TextEditingController();
  TextEditingController fantasyID3 = TextEditingController();
  TextEditingController fantasyID4 = TextEditingController();
  TextEditingController fantasyID5 = TextEditingController();
  TextEditingController mangerId = TextEditingController();

  ScrollController scrollController = ScrollController();

  AddTeamRepoImpl addTeamRepoImpl = AddTeamRepoImpl();

  String championshipSelected = '';

  String? pathImageTeam;

  String championship = championShip[0];
  String captain = '';

  List<Team> teams = [];

  bool isUpdate = false;
  String? pathImageTeamUpdate;

  bool isLoading = false;
  String idTeam = '';
  bool isView = false;

  void removeImageTeam() {
    pathImageTeamUpdate = null;

    emit(RemoveImageTeamState());
  }

  void scrollListenerPangation() {
    if (isLoading == false) {
      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          getTeams();
        }
      });
    }
  }

  changeChampionshipSelected(String value) async {
    championshipSelected = value;
    emit(ChangeChampionshipSelectedState());
    teams.clear();
    if (value == 'جميع البطولات') {
      await getTeams(refrish: true);
      return;
    }
    await getTeams(refrish: true, championShipSelected: value);
  }

  void changeChampionShip(String value) {
    championship = value;

    emit(AddTeamChampionState());
  }

  void viewTeam(Team team, context) {
    showBottomSheetCustom(context, const AddTeam());
    isView = true;
    fetchDataTeam(team);
  }

  addImageTeam() async {
    pathImageTeam = await ImagePickerServices.getImage();
    emit(AddTeamChampionState());
  }

  Future<void> addTeam(context) async {
    emit(LoadingCrudChampionState());
    String path = await uploadImageToFirebaseStorage(File(pathImageTeam!));
    AddTeamRepoImpl addTeamRepoImpl = AddTeamRepoImpl();
    var response = await addTeamRepoImpl.addTeam(
        id: nameTeamController.text,
        teamModel: Team(
          name: nameTeamController.text,
          pathImage: path,
          champion: championship,
          captain: fantasyID5.text,
          fantasyID1: fantasyID1.text,
          fantasyID2: fantasyID2.text,
          fantasyID3: fantasyID3.text,
          fantasyID4: fantasyID4.text,
          fantasyID5: fantasyID5.text,
          managerID: mangerId.text,
        ));

    response.fold((failure) {
      emit(FailureCrudTeamState(message: failure));
    }, (message) async {
      Navigator.pop(context);
      refreshTeams();
      await getTeams(refrish: true);

      emit(SuccessfulCrudState(message));
    });
  }

  void editTeam(Team team, context) {
    showBottomSheetCustom(context, const AddTeam());
    isUpdate = true;
    fetchDataTeam(team);
  }

  fetchDataTeam(Team team) {
    nameTeamController.text = team.name!;
    fantasyID1.text = team.fantasyID1!;
    fantasyID2.text = team.fantasyID2!;
    fantasyID3.text = team.fantasyID3!;
    fantasyID4.text = team.fantasyID4!;
    fantasyID5.text = team.fantasyID5!;
    mangerId.text = team.managerID!;
    pathImageTeamUpdate = team.pathImage!;
    championship = team.champion!;
    captain = team.captain!;
    idTeam = team.id!;
  }

  addOrUpdateTeam(context) async {
    if (isUpdate) {
      await updateTeam(context);
    } else {
      await addTeam(context);
    }
  }

  Future<void> updateTeam(context, {String? id}) async {
    emit(LoadingCrudChampionState());
    Team teamUpdate = Team();

    if (pathImageTeam != null) {
      String path = await uploadImageToFirebaseStorage(File(pathImageTeam!));
      teamUpdate.pathImage = path;
    }

    teamUpdate.name = nameTeamController.text;
    teamUpdate.champion = championship;
    teamUpdate.captain = fantasyID5.text;
    teamUpdate.fantasyID1 = fantasyID1.text;
    teamUpdate.fantasyID2 = fantasyID2.text;
    teamUpdate.fantasyID3 = fantasyID3.text;
    teamUpdate.fantasyID4 = fantasyID4.text;
    teamUpdate.fantasyID5 = fantasyID5.text;
    teamUpdate.managerID = mangerId.text;

    var response = await addTeamRepoImpl.updateTeam(
      id: idTeam,
      teamModel: teamUpdate,
    );

    response.fold((failure) {
      emit(FailureCrudTeamState(message: failure));
    }, (message) async {
      Navigator.pop(context);
      clearDataTeam();

      refreshTeams();


      emit(SuccessfulCrudState(message));
    });
  }

  refreshTeams() async {
    teams.clear();
    championshipSelected = 'جميع البطولات';
    await getTeams(refrish: true);
  }

  getTeams({bool refrish = false, String? championShipSelected}) async {
    emit(LoadingGetTeamsState());
    var response = await addTeamRepoImpl.getTeams(
        refrish: refrish, championship: championShipSelected);
    response.fold((failure) {
      isLoading = true;
      emit(FailureGetTeamsState(failure));
    }, (teams) {
      isLoading = true;
      this.teams.addAll(teams);
      emit(SuccessfulGetTeamsState());
    });
  }

  deleteTeam(String id) async {
    var response = await addTeamRepoImpl.deleteTeam(id: id);
    response.fold((failure) {
      emit(FailureCrudTeamState(
        message: failure,
      ));
    }, (message) async {
      refreshTeams();
      emit(SuccessfulCrudState(message));
    });
  }

  search(String nameTeam) async {
    emit(LoadingGetTeamsState());
    var response = await addTeamRepoImpl.search(nameTeam);
    response.fold((failure) {
      emit(FailureGetTeamsState(failure));
    }, (teams) {
      this.teams.clear();
      this.teams.addAll(teams);
      print(teams.length);
      emit(SuccessfulGetTeamsState());
    });
  }

  clearDataTeam() {
    isUpdate = false;
    nameTeamController.clear();
    fantasyID1.clear();
    fantasyID2.clear();
    fantasyID3.clear();
    fantasyID4.clear();
    fantasyID5.clear();
    mangerId.clear();
    pathImageTeam = null;
    pathImageTeamUpdate = null;
    isView = false;
    championship = championShip[0];
    captain = '';
    pathImageTeamUpdate = null;
  }

  Future<String> uploadImageToFirebaseStorage(File image) async {
    String fileName = "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
    Uint8List? imageByte = await CompressionImagesService.compressImage(image);

    Reference storageRef = FirebaseStorage.instance.ref().child(fileName);

    UploadTask uploadTask = storageRef.putData(imageByte!);
    await uploadTask.whenComplete(() {});

    String downloadURL = await storageRef.getDownloadURL();

    return downloadURL;
  }

  checkValidationAddTeam(context) async {
    List<String> errorValidation = validationAddTeam();

    if (errorValidation.isNotEmpty) {
      showDailogValidtion( context:context, errorsValidation: errorValidation );

    } else {
      await addOrUpdateTeam(context);
    }
  }

  validationAddTeam() {
    List<String> errorValidation = [];

    if (nameTeamController.text.isEmpty) {
      errorValidation.add('من فضلك ادخل اسم الفريق');
    }
    if (fantasyID1.text.isEmpty) {
      errorValidation.add('من فضلك ادخل فانتازي 1');
    }
    if (fantasyID2.text.isEmpty) {
      errorValidation.add('من فضلك ادخل فانتازي 2');
    }
    if (fantasyID3.text.isEmpty) {
      errorValidation.add('من فضلك ادخل فانتازي 3');
    }
    if (fantasyID4.text.isEmpty) {
      errorValidation.add('من فضلك ادخل فانتازي 4');
    }
    if (fantasyID5.text.isEmpty) {
      errorValidation.add('من فضلك ادخل فانتازي 5');
    }
    if (mangerId.text.isEmpty) {
      errorValidation.add('من فضلك ادخل id المدير');
    }
    if (pathImageTeam == null && !isUpdate) {
      errorValidation.add('من فضلك ادخل صورة الفريق');
    }

    return errorValidation;
  }
}
