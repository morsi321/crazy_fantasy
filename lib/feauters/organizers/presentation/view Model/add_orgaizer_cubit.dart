import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:crazy_fantasy/core/widget/my_snackBar.dart';
import 'package:crazy_fantasy/feauters/organizers/Data/repos/organizers_in_teams/OrganizersRepoImpl.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../core/models/team.dart';
import '../../../../core/servies/comperison_image.dart';
import '../../../../core/servies/image_picker_servies.dart';
import '../../../../core/widget/bootom_sheet_custom.dart';
import '../../../teams/presentation/view model/add_team_cubit.dart';
import '../../../teams/presentation/view/widget/dailog_validation.dart';
import '../../Data/models/orgnizer_model.dart';
import '../../Data/repos/addOrg/addOrganizerRepoImpl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view/widget/add org/add_oragnizer_Widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'add_orgaizer_state.dart';

class AddOrganizerCubit extends Cubit<AddOrganizerState> {
  AddOrganizerCubit() : super(AddOrganizerInitial());
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController whatsApp = TextEditingController();
  TextEditingController faceBook = TextEditingController();
  TextEditingController twiter = TextEditingController();
  TextEditingController instagram = TextEditingController();
  TextEditingController youtube = TextEditingController();
  TextEditingController tiktok = TextEditingController();
  TextEditingController description = TextEditingController();

  List<Team> teams = [];
  List<Team> teams1000 = [];
  List<Team> teamsRemoves = [];
  List<Team> teams1000Removes = [];
  int numGameWeek = 0;

  int countHeadingTeam = 0;
  String lastImage = "";

  bool isTeams1000 = false;
  bool isCup = false;
  bool isClassicLeague = false;
  bool isVipLeague = false;

  String countTeams = "256";

  String? pathImageTeamUpdate;
  bool isUpdate = false;

  bool isView = false;

  int indexPageOrganizer = 0;
  String? imagePath;
  List<Organizer> organizers = [];
  String idOrganizer = "";
  bool isCloseUpdate = false;

  addTeamInBag(Team team, context) {
    if (isCloseUpdate) {
      mySnackBar(
        context,
        duration: 1,
        message: "لا يمكنك اضافة فريق بعد البدء في الموسم",
      );
      return;
    }
    if (teams.length >= int.parse(countTeams)) {
      mySnackBar(
        context,
        duration: 1,
        message: "لا يمكنك اضافة اكثر من $countTeams فريق",
      );
      return;
    }
    if (teams.where((t) => t.id == team.id).isNotEmpty) {
      mySnackBar(
        context,
        duration: 1,
        message: "هذا الفريق موجود بالفعل",
      );
    } else {
      teams.add(team);
      BlocProvider.of<AddTeamCubit>(context).removeTeamFromShow(team);
      emit(AddTeamOrgState());
    }
  }

  addFor1000Team(Team team, context) {
    if (isCloseUpdate) {
      mySnackBar(
        context,
        duration: 1,
        message: "لا يمكنك اضافة فريق بعد البدء في الموسم",
      );
      return;
    }
    if (teams1000.where((t) => t.id == team.id).isNotEmpty) {
      mySnackBar(
        context,
        duration: 1,
        message: "هذا الفريق موجود بالفعل",
      );
    } else {
      teams1000.add(team);
      BlocProvider.of<AddTeamCubit>(context).removeTeamFromShow(team);
      emit(AddTeamOrgState());
    }
  }

  removeTeamInBag(Team team, context) {
    if (isCloseUpdate) {
      mySnackBar(
        context,
        duration: 1,
        message: "لا يمكنك حدف فريق بعد البدء في الموسم",
      );
      return;
    }
    teams.removeWhere((t) => t.id == team.id);

    isUpdate ? teamsRemoves.add(team) : () {};
    BlocProvider.of<AddTeamCubit>(context).addTeamToShow(team);
    emit(RemoveTeamOrgState());
  }

  removeTeamInBag1000(Team team, context) {
    if (isCloseUpdate) {
      mySnackBar(
        context,
        duration: 1,
        message: "لا يمكنك حدف فريق بعد البدء في الموسم",
      );
      return;
    }
    teams1000.removeWhere((t) => t.id == team.id);
    isUpdate ? teams1000Removes.add(team) : () {};
    BlocProvider.of<AddTeamCubit>(context).addTeamToShow(team);

    emit(RemoveTeamOrgState());
  }

  removeOrgFromTeam({required String id, required String url}) async {
    List<String> otherChampionsId = removeElementsDuplicated(
        convertListTeamToListID(teamsRemoves),
        convertListTeamToListID(teams1000));
    List<String> team1000Ids = removeElementsDuplicated(
        convertListTeamToListID(teams1000Removes),
        convertListTeamToListID(teams));
    List<Future> futures = [
      OrganizersRepoImpl().removeTeamFromOrg(
        listOfTeams: mergeTwoList(otherChampionsId, team1000Ids),
        orgId: id,
        nameOrg: name.text,
        urlImage: lastImage,
      ),
      OrganizersRepoImpl().removeOrgOthersChampions(
        teams: convertListTeamToListID(teamsRemoves),
        nameOrg: id,
      ),
      OrganizersRepoImpl().removeOrgChampion1000Team(
        teams: convertListTeamToListID(teams1000Removes),
        nameOrg: id,
      ),
    ];
    await Future.wait(futures);
  }

  changeCountTeams(String value) {
    countTeams = value;
    emit(ChangeCountTeamsState());
  }

  checkValidationAddOrg(
    bool back,
    context,
  ) async {
    if (indexPageOrganizer != 1 || back) {
      changeIndexPageOrganizers(back, context);
      return;
    }

    List<String> errorValidation = validationAddTeam();

    if (errorValidation.isNotEmpty) {
      showDailogValidtion(context: context, errorsValidation: errorValidation);
    } else {
      changeIndexPageOrganizers(back, context);
    }
  }

  changeIsTeams1000() {
    isTeams1000 = !isTeams1000;
    emit(ChangeIsTeams1000State());
  }

  changeIsCup() {
    isCup = !isCup;

    emit(ChangeIsCupState());
  }

  changeIsClassicLeague() {
    isClassicLeague = !isClassicLeague;
    emit(ChangeIsClassicLeagueState());
  }

  changeIsVipLeague() {
    isVipLeague = !isVipLeague;

    emit(ChangeIsVipLeagueState());
  }

  clearChamopionships() {
    isTeams1000 = false;
    isCup = false;
    isClassicLeague = false;
    isVipLeague = false;
  }

  convertListTeamToListID(List<Team> teams) {
    List<String> listID = [];
    for (var element in teams) {
      listID.add(element.id!);
    }
    return listID;
  }

  convertListTeamToListOrg(List<Team> teams) {
    List<Map> listOrg = [];
    for (var element in teams) {
      listOrg.add({
        "id": element.id,
        "isHeading": element.isHeading ?? false,
      });
    }
    return listOrg;
  }

  void changeIndexPageOrganizers(bool back, context) async {
    if (indexPageOrganizer == 2 &&
        !back &&
        teams.length < int.parse(countTeams)) {
      mySnackBar(
        context,
        message: "يجب اضافة $countTeams فريق",
      );

      return;
    }

    if (back) {
      indexPageOrganizer--;
      indexPageOrganizer == 0 ? clearData() : () {};
    } else {
      indexPageOrganizer++;
    }
    emit(ChangeIndexPageOrganizerState());

    if (indexPageOrganizer == 2) {
      await BlocProvider.of<AddTeamCubit>(context).getTeams(teamsdelete: teams);
    }
    if (indexPageOrganizer == 3) {
      await BlocProvider.of<AddTeamCubit>(context)
          .getTeams(teamsdelete: teams1000);
    }
  }

  deleteOrg({required Organizer org}) async {
    emit(CrudOrganizerLoadingState());

    var result = await AddOrganizerRepoImpl().deleteOrganizer(
      id: org.id!,
      idTeams: mergeTwoList(
          org.otherChampionshipsTeams!.map((e) => e["id"] as String).toList(),
          org.teams1000Id!),
      nameOrg: org.name!,
      urlImage: org.image!,
    );

    result.fold((l) {
      emit(CrudOrganizerErrorState(l));
    }, (r) {
      getOrganizers();
      emit(CrudOrganizerSuccessState(r));
    });
  }

  void viewOrg(Organizer organizer, context) {
    showBottomSheetCustom(context, const AddOrganizerWidget());
    isView = true;
    fetchDataOrganizer(organizer);
  }

  addOrgInTeams({required String url}) async {
    List<String> champions = [];
    if (isClassicLeague) {
      champions.add("الدوري الكلاسيكي");
    }
    if (isVipLeague) {
      champions.add("VIP");
    }
    if (isCup) {
      champions.add("كأس الاقصائي");
    }
    if (isTeams1000) {
      champions.add("البطولة المفتوحة");
    }
    List<Future> futures = [
      OrganizersRepoImpl().closeUpdateTeams(
          teamsId: mergeTwoList(convertListTeamToListID(teams),
              convertListTeamToListID(teams1000)),
          isCloseUpdate: true),
      OrganizersRepoImpl().addTeamInOrg(
        listOfTeams: mergeTwoList(
            convertListTeamToListID(teams), convertListTeamToListID(teams1000)),
        orgId: name.text.replaceAll(' ', ''),
        nameOrg: name.text,
        urlImage: url,
      ),
      OrganizersRepoImpl().addOrganizersInTeamsForOthersChampions(
          teams: teams,
          nameOrg: name.text.replaceAll(' ', ''),
          championShip: champions),
      OrganizersRepoImpl().addOrganizersInTeamsForChamp1000Team(
        teams: teams1000,
        nameOrg: name.text.replaceAll(' ', ''),
      )
    ];
    await Future.wait(futures);
  }

  addOrUpdateOrganize(context) async {
    if (isUpdate) {
      await updateOrganizer();
    } else {
      await addOrganizer(context);
    }
  }

  getOrganizers() async {
    emit(GetOrganizerLoadingState());
    var result = await AddOrganizerRepoImpl().getOrganizer();
    result.fold((l) {
      emit(GetOrganizerErrorState(l));
    }, (r) {
      organizers = r;
      emit(GetOrganizerSuccessState());
    });
  }

  addImageOrganizer() async {
    imagePath = await ImagePickerServices.getImage();
    emit(AddImageOrganizerState());
  }

  void editOrganizer(Organizer organizer, context) {
    indexPageOrganizer = 1;
    isUpdate = true;
    fetchDataOrganizer(organizer);
  }

  fetchDataOrganizer(Organizer organizer) {
    idOrganizer = organizer.id!;
    name.text = organizer.name!;
    phone.text = organizer.phone!;
    whatsApp.text = organizer.whatsApp!;
    faceBook.text = organizer.urlFacebook!;
    twiter.text = organizer.urlTwitter!;
    instagram.text = organizer.urlInstagram!;
    tiktok.text = organizer.urlTiktok!;
    lastImage = organizer.image!;
    youtube.text = organizer.urlYoutube!;
    description.text = organizer.description!;
    numGameWeek = organizer.numGameWeek!;
    countTeams = organizer.countTeams!;
    isCloseUpdate = organizer.isCloseUpdate!;
    pathImageTeamUpdate = organizer.image;
    isTeams1000 = organizer.isTeam1000League!;
    isCup = organizer.isCupLeague!;
    isClassicLeague = organizer.isClassicLeague!;
    isVipLeague = organizer.isVipLeague!;

    fetchTeamsOrg(organizer);
  }

  fetchTeamsOrg(
    Organizer organizer,
  ) {
    emit(FetchTeamsOrgLoadingState());
    try {
      List<Future> futures = [
        getTeamsOthersChampions(organizer.otherChampionshipsTeams!),
        getTeamsByListId(organizer.teams1000Id!)
      ];

      Future.wait(futures).then((value) =>
          {teams = value[0], teams1000 = value[1], emit(FetchTeamsOrgState())});
    } catch (e) {
      emit(FetchTeamsOrgErrorState("خطا غير متوقع حاول مره اخري"));
    }
  }

  getTeamsByListId(List<String> idTeam) async {
    List<Team> teams = [];
    List<Future> futures = [];
    for (var element in idTeam) {
      futures.add(FirebaseFirestore.instance
          .collection("teams")
          .doc(element)
          .get()
          .then((value) {
        String idDoc = value.reference.id;

        teams.add(Team.fromJson(value.data()!, idDoc, isHead: false));
      }));
    }
    await Future.wait(futures);
    return teams;
  }

  getTeamsOthersChampions(List<Map> infoTeam) async {
    List<Team> teams = [];
    List<Future> futures = [];
    for (var element in infoTeam) {
      futures.add(FirebaseFirestore.instance
          .collection("teams")
          .doc(element["id"])
          .get()
          .then((value) {
        String idDoc = value.reference.id;

        teams.add(
            Team.fromJson(value.data()!, idDoc, isHead: element["isHeading"]));
      }));
    }
    await Future.wait(futures);
    return teams;
  }

  clearData() {
    name.clear();
    phone.clear();
    whatsApp.clear();
    faceBook.clear();
    twiter.clear();
    instagram.clear();
    tiktok.clear();
    description.clear();
    idOrganizer = "";
    countHeadingTeam = 0;

    pathImageTeamUpdate = null;
    isUpdate = false;
    imagePath = null;
    clearChamopionships();
    teams.clear();
    teams1000.clear();
    teamsRemoves.clear();
    teams1000Removes.clear();
    numGameWeek = 0;
    countTeams = "256";
    isCloseUpdate = false;
  }

  Future<void> updateOrganizer() async {
    emit(CrudOrganizerLoadingState());

    Organizer organizer = Organizer();

    if (imagePath != null) {
      String path = await uploadImageToFirebaseStorage(File(imagePath!));
      organizer.image = path;
    } else {
      organizer.image = pathImageTeamUpdate;
    }
    !isCloseUpdate
        ? {
            await addOrgInTeams(url: organizer.image!),
            await removeOrgFromTeam(id: idOrganizer, url: organizer.image!),
          }
        : () {};
    organizer.id = idOrganizer;
    organizer.name = name.text;
    organizer.phone = phone.text;
    organizer.whatsApp = whatsApp.text;
    organizer.urlYoutube = youtube.text;
    organizer.numGameWeek = numGameWeek;
    organizer.urlFacebook = faceBook.text;
    organizer.urlTwitter = twiter.text;
    organizer.urlInstagram = instagram.text;
    organizer.urlTiktok = tiktok.text;
    organizer.description = description.text;
    organizer.isTeam1000League = isTeams1000;
    organizer.isCupLeague = isCup;
    organizer.isCloseUpdate = isCloseUpdate;

    organizer.isClassicLeague = isClassicLeague;
    organizer.isVipLeague = isVipLeague;
    if (!isCloseUpdate) {
      organizer.countTeams = countTeams;
      organizer.otherChampionshipsTeams = convertListTeamToListOrg(teams);
      organizer.teams1000Id = convertListTeamToListID(teams1000);
    }

    var result = await AddOrganizerRepoImpl().updateOrganizer(
      organizerModel: organizer,
      isCloseUpdate: isCloseUpdate,
    );
    result.fold((l) {
      emit(CrudOrganizerErrorState(l));
    }, (r) {
      getOrganizers();
      clearData();
      indexPageOrganizer = 0;
      emit(CrudOrganizerSuccessState(r));
    });
  }

  void removeImageOrg() {
    pathImageTeamUpdate = null;

    emit(RemoveImageOrgState());
  }

  checkCountTeam(context) {
    if (indexPageOrganizer == 2 &&
        (isCup || isVipLeague || isClassicLeague || isCup) &&
        teams.length < 15) {
      mySnackBar(
        context,
        message: "يجب اضافة $countTeams فريق",
      );
      return false;
    } else if ((indexPageOrganizer == 2 &&
                !(isCup && isVipLeague && isClassicLeague && isCup) ||
            indexPageOrganizer == 3) &&
        teams1000.length < 10) {
      mySnackBar(
        context,
        message: "   علي الاقل يجب اضافة 10 فريق",
      );
      return false;
    }
    return true;
  }

  addOrganizer(context) async {
    bool isCompletedTeams = checkCountTeam(context);

    if (isCompletedTeams) {
      emit(CrudOrganizerLoadingState());
      String urlImage = await uploadImageToFirebaseStorage(File(imagePath!));
      await addOrgInTeams(url: urlImage);

      AddOrganizerRepoImpl addOrganizerRepoImpl = AddOrganizerRepoImpl();
      var response = await addOrganizerRepoImpl.addOrganizer(
        organizerModel: Organizer(
          name: name.text,
          isCloseUpdate: isCloseUpdate,
          phone: phone.text,
          whatsApp: whatsApp.text,
          urlFacebook: faceBook.text,
          numGameWeek: numGameWeek,
          urlYoutube: youtube.text,
          urlTwitter: twiter.text,
          urlInstagram: instagram.text,
          urlTiktok: tiktok.text,
          description: description.text,
          image: urlImage,
          isClassicLeague: isClassicLeague,
          isVipLeague: isVipLeague,
          isCupLeague: isCup,
          isTeam1000League: isTeams1000,
          countTeams: countTeams,
          teams1000Id: convertListTeamToListID(teams1000),
          otherChampionshipsTeams: convertListTeamToListOrg(teams),
        ),
      );

      response.fold((l) {
        emit(CrudOrganizerErrorState(l));
      }, (r) {
        getOrganizers();
        indexPageOrganizer = 0;
        emit(CrudOrganizerSuccessState(r));
      });
    }
  }

  void changeHeadingInTeams(Team team) {
    for (var element in teams) {
      if (element.id == team.id) {
        element.isHeading =
            element.isHeading == null ? true : !element.isHeading!;
      }
    }
    emit(ChangeHeadingGroupState());
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

  validationAddTeam() {
    List<String> errorValidation = [];

    if (name.text.isEmpty) {
      errorValidation.add('من فضلك ادخل اسم المنظم');
    }
    if (phone.text.isEmpty) {
      errorValidation.add('من فضلك ادخل رقم الهاتف');
    }
    if (description.text.isEmpty) {
      errorValidation.add('من فضلك ادخل الوصف');
    }
    if (imagePath == null && !isUpdate) {
      errorValidation.add('من فضلك ادخل صورة المنظم');
    } else if (imagePath == null && isUpdate && pathImageTeamUpdate == null) {
      errorValidation.add('من فضلك ادخل صورة المنظم');
    }
    if (!(isTeams1000 || isVipLeague || isCup || isClassicLeague)) {
      errorValidation.add('يجب اختيار دوري واحد علي الاقل');
    }

    return errorValidation;
  }

  mergeTwoList(List<String> list1, List<String> list2) {
    List<String> list = [];
    list.addAll(list1);
    list.addAll(list2);
    list = list.toSet().toList();
    return list;
  }

  List<T> removeElementsDuplicated<T>(List<T> list1, List<T> list2) {
    List<T> resultList = List<T>.from(list1);

    for (var element in list2) {
      if (resultList.isNotEmpty && resultList.first == element) {
        resultList.removeAt(0);
      } else {
        break;
      }
    }

    return resultList;
  }
}
