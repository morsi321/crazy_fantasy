import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:crazy_fantasy/core/constance/constance.dart';
import 'package:crazy_fantasy/core/servies/image_picker_servies.dart';
import 'package:crazy_fantasy/core/widget/bootom_sheet_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../core/servies/comperison_image.dart';

import '../../../../core/models/team.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import '../../Data/repos/addTeam/add_team_repo_impl.dart';
import '../view/widget/add_team.dart';
import '../view/widget/dailog_validation.dart';

part 'add_team_state.dart';

class AddTeamCubit extends Cubit<AddTeamState> {
  AddTeamCubit() : super(AddTeamInitial());

  bool isChangeChampionship = false;

  TextEditingController nameTeamController = TextEditingController();
  TextEditingController countryController =
      TextEditingController(text: "مصر");
  TextEditingController fantasyID1 = TextEditingController();
  TextEditingController fantasyID2 = TextEditingController();
  TextEditingController fantasyID3 = TextEditingController();
  TextEditingController fantasyID4 = TextEditingController();
  TextEditingController captain = TextEditingController();
  TextEditingController mangerId = TextEditingController();

  ScrollController scrollController = ScrollController();

  AddTeamRepoImpl addTeamRepoImpl = AddTeamRepoImpl();

  String championshipSelected = '';

  String? pathImageTeam;

  String championship = championShip[0];

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
    bool isDone = true;
    if (isLoading == false && isDone) {
      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          getTeams();
          isDone = false;
        }
      });
    }
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
    // changeChampionshipSelected('جميع البطولات');
    emit(LoadingCrudChampionState());
    String path = await uploadImageToFirebaseStorage(File(pathImageTeam!));
    AddTeamRepoImpl addTeamRepoImpl = AddTeamRepoImpl();
    var response = await addTeamRepoImpl.addTeam(
        id: nameTeamController.text,
        teamModel: Team(
          name: nameTeamController.text,
          pathImage: path,
          country: countryController.text,
          captain: int.parse(captain.text),
          fantasyID1: int.parse(fantasyID1.text),
          fantasyID2: int.parse(fantasyID2.text),
          fantasyID3: int.parse(fantasyID3.text),
          fantasyID4: int.parse(fantasyID4.text),
          managerID: mangerId.text,

        ));

    response.fold((failure) {
      emit(FailureCrudTeamState(message: failure));
    }, (message) async {
      Navigator.pop(context);
      refreshTeams();

      emit(SuccessfulCrudState(message));
    });
  }

  done(context) async {
    Navigator.pop(context);
    teams.clear();
    await getTeams(refrish: true);
  }

  void editTeam(Team team, context) {
    showBottomSheetCustom(context, const AddTeam());
    isUpdate = true;
    fetchDataTeam(team);
  }

  fetchDataTeam(Team team) {
    nameTeamController.text = team.name!;
    fantasyID1.text = team.fantasyID1!.toString();
    fantasyID2.text = team.fantasyID2!.toString();
    fantasyID3.text = team.fantasyID3!.toString();
    fantasyID4.text = team.fantasyID4!.toString();
    mangerId.text = team.managerID!;
    pathImageTeamUpdate = team.pathImage!;
    captain.text = team.captain!.toString();
    idTeam = team.id!;
    countryController.text = team.country!;
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
    teamUpdate.country = countryController.text;
    teamUpdate.captain = int.parse(captain.text);
    teamUpdate.fantasyID1 = int.parse(fantasyID1.text);
    teamUpdate.fantasyID2 = int.parse(fantasyID2.text);
    teamUpdate.fantasyID3 = int.parse(fantasyID3.text);
    teamUpdate.fantasyID4 = int.parse(fantasyID4.text);
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
    clearDataTeam();
    championshipSelected = 'جميع البطولات';
    await getTeams(refrish: true);
  }

  getTeams({bool refrish = false, String? championShipSelected}) async {
    emit(LoadingGetTeamsState());
    var response = await addTeamRepoImpl.getTeams(refrish: refrish);
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
    countryController.clear();
    nameTeamController.clear();
    fantasyID1.clear();
    fantasyID2.clear();
    fantasyID3.clear();
    fantasyID4.clear();
    captain.clear();
    mangerId.clear();
    pathImageTeam = null;
    pathImageTeamUpdate = null;
    isView = false;
    championship = championShip[0];
    pathImageTeamUpdate = null;
    emit(ClearDataTeamState());
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
      showDailogValidtion(context: context, errorsValidation: errorValidation);
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
    if (captain.text.isEmpty) {
      errorValidation.add('من فضلك ادخل كابتن ');
    }
    if (mangerId.text.isEmpty) {
      errorValidation.add('من فضلك ادخل id المدير');
    }
    if (pathImageTeam == null && !isUpdate) {
      errorValidation.add('من فضلك ادخل صورة الفريق');
    }

    return errorValidation;
  }

// test() async {
//   AddTeamRepoImpl addTeamRepoImpl = AddTeamRepoImpl();
//
//   List <Future> futures = [];
//
//   for(int i = 0 ; i < 5000 ; i++){
// futures.add(   addTeamRepoImpl.getScorePlayer(i));
//
//   }
//   await Future.wait(futures);
//   print('done');
//
// }

  int counter = 1;

  add1000Team() async {
    AddTeamRepoImpl addTeamRepoImpl = AddTeamRepoImpl();
    List<Future> futures = [];
    for (int i = 0; i < 1000; i++) {
      Team teamModel = Team(
        name: 'team $i',
        country: 'مصر',
        captain: counter++,
        fantasyID1: counter++,
        fantasyID2: counter++,
        fantasyID3: counter++,
        fantasyID4: counter++,
        managerID: '123',
        pathImage:
            'https://firebasestorage.googleapis.com/v0/b/crazy-fantasy-97ec8.appspot.com/o/1688990399391.jpg?alt=media&token=f90ef88e-a643-4e1d-9e5f-ef3cf8f6ee90',
      );

      futures.add(addTeamRepoImpl.addTeam(id: "cvg", teamModel: teamModel));
    }
    if (kDebugMode) {
      print(futures.length);
    }
    await Future.wait(futures);
    print("done" * 130);
  }
}
