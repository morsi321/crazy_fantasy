import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:crazy_fantasy/core/constance/constance.dart';
import 'package:crazy_fantasy/core/servies/image_picker_servies.dart';
import 'package:crazy_fantasy/core/widget/bootom_sheet_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/servies/comperison_image.dart';

import '../../Data/models/team.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import '../../Data/repos/addTeam/add_team_repo_impl.dart';
import '../view/widget/add_team.dart';

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

  String? pathImageTeam;

  String championship = championShip[0];
  String captain = '';

  List<Team> teams = [];

  bool isUpdate = false;
  String pathImageTeamUpdate = '';

  bool isLoading = false;

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

  void changeChampionShip(String value) {
    championship = value;
    emit(AddTeamChampionState());
  }

  addImageTeam() async {
    pathImageTeam = await ImagePickerServices.getImage();
    emit(AddTeamChampionState());
  }

  Future<void> addTeam(context) async {
    isUpdate = false;
    emit(LoadingAddTeamChampionState());
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
      emit(FailureAddTeamState(message: failure));
    }, (message) async {
      Navigator.pop(context);
      clearDataTeam();
       teams.clear();
      await getTeams(refrish: true);

      emit(SuccessfulAddTeamState(message));
    });
  }

  void editTeam(Team team, context) {
    showBottomSheetCustom(context, const AddTeam());
    isUpdate = true;
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
  }

  addOrUpdateTeam(context) async {
    if (isUpdate) {
      await updateTeam(context);
    } else {
      await addTeam(context);
    }
  }

  Future<void> updateTeam(context) async {
    emit(LoadingAddTeamChampionState());
    
    String path = await uploadImageToFirebaseStorage(File(pathImageTeam!));
    addTeamRepoImpl = AddTeamRepoImpl();
    var response = await addTeamRepoImpl.updateTeam(
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
      emit(FailureAddTeamState(message: failure));
    }, (message) async {
      Navigator.pop(context);
      clearDataTeam();

      await getTeams(refrish: true);

      emit(SuccessfulAddTeamState(message));
    });
  }

  getTeams({bool refrish = false}) async {
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

  clearDataTeam() {
    nameTeamController.clear();
    fantasyID1.clear();
    fantasyID2.clear();
    fantasyID3.clear();
    fantasyID4.clear();
    fantasyID5.clear();
    mangerId.clear();
    pathImageTeam = null;
    championship = championShip[0];
    captain = '';
    pathImageTeamUpdate = '';
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
}
