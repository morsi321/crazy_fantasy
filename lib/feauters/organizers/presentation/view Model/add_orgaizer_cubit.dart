import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:crazy_fantasy/core/widget/my_snackBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../core/models/team.dart';
import '../../../../core/servies/comperison_image.dart';
import '../../../../core/servies/image_picker_servies.dart';
import '../../../../core/widget/bootom_sheet_custom.dart';
import '../../../teams/presentation/view/widget/dailog_validation.dart';
import '../../Data/models/orgnizer_model.dart';
import '../../Data/repos/addOrganizerRepoImpl.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../view/widget/add org/add_oragnizer_Widget.dart';

part 'add_orgaizer_state.dart';

class AddOrganizerCubit extends Cubit<AddOrganizerState> {
  AddOrganizerCubit() : super(AddOrganizerInitial());
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController whatsApp = TextEditingController();
  TextEditingController faceBook = TextEditingController();
  TextEditingController twiter = TextEditingController();
  TextEditingController instagram = TextEditingController();
  TextEditingController tiktok = TextEditingController();
  TextEditingController description = TextEditingController();

  List<Team> teams = [];
  List<Team> teams1000 = [];

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

  addTeamInBag(Team team, context) {
    if (teams.where((t) => t.id == team.id).isNotEmpty) {
      mySnackBar(
        context,
        duration:1 ,
        message: "هذا الفريق موجود بالفعل",
      );
    } else {
      teams.add(team);
      emit(AddTeamOrgState());
    }
  }
  removeTeamInBag(Team team) {
    teams.removeWhere((t) => t.id == team.id);
    emit(RemoveImageOrgState());
  }

  changeCountTeams(String value) {
    countTeams = value;
    emit(ChangeCountTeamsState());
  }

  checkValidationAddTeam(context) async {
    List<String> errorValidation = validationAddTeam();

    if (errorValidation.isNotEmpty) {
      showDailogValidtion(context: context, errorsValidation: errorValidation);
    } else {
      await addOrUpdateOrganize(context);
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

  void changeIndexPageOrganizer(bool back) {
    if (back) {
      indexPageOrganizer--;
    } else {
      indexPageOrganizer++;
    }
    print(indexPageOrganizer);
    emit(ChangeIndexPageOrganizerState());
  }

  deleteOrg(String id) async {
    emit(CrudOrganizerLoadingState());
    var result = await AddOrganizerRepoImpl().deleteOrganizer(id: id);
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

  addOrUpdateOrganize(context) async {
    if (isUpdate) {
      await updateOrganizer(id: idOrganizer);
    } else {
      await addOrganizer();
      clearData();
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
    showBottomSheetCustom(context, const AddOrganizerWidget());
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
    description.text = organizer.description!;
    pathImageTeamUpdate = organizer.image;
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
    pathImageTeamUpdate = null;
    isUpdate = false;
    imagePath = null;
  }

  Future<void> updateOrganizer({String? id}) async {
    emit(CrudOrganizerLoadingState());

    Organizer organizer = Organizer();

    if (imagePath != null) {
      String path = await uploadImageToFirebaseStorage(File(imagePath!));
      organizer.image = path;
    } else {
      organizer.image = pathImageTeamUpdate;
    }
    organizer.name = name.text;
    organizer.phone = phone.text;
    organizer.whatsApp = whatsApp.text;
    organizer.urlFacebook = faceBook.text;
    organizer.urlTwitter = twiter.text;
    organizer.urlInstagram = instagram.text;
    organizer.urlTiktok = tiktok.text;
    organizer.description = description.text;

    var result = await AddOrganizerRepoImpl().updateOrganizer(
      organizerModel: organizer,
      id: id!,
    );
    result.fold((l) {
      emit(CrudOrganizerErrorState(l));
    }, (r) {
      getOrganizers();
      emit(CrudOrganizerSuccessState(r));
    });
  }

  void removeImageOrg() {
    pathImageTeamUpdate = null;

    emit(RemoveImageOrgState());
  }

  addOrganizer() async {
    emit(CrudOrganizerLoadingState());
    String urlImage = await uploadImageToFirebaseStorage(File(imagePath!));

    AddOrganizerRepoImpl addOrganizerRepoImpl = AddOrganizerRepoImpl();
    var response = await addOrganizerRepoImpl.addOrganizer(
      organizerModel: Organizer(
        name: name.text,
        phone: phone.text,
        whatsApp: whatsApp.text,
        urlFacebook: faceBook.text,
        urlTwitter: twiter.text,
        urlInstagram: instagram.text,
        urlTiktok: tiktok.text,
        description: description.text,
        image: urlImage,
      ),
    );
    response.fold((l) {
      emit(CrudOrganizerErrorState(l));
    }, (r) {
      getOrganizers();
      emit(CrudOrganizerSuccessState(r));
    });
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
    if (imagePath == '') {
      errorValidation.add('من فضلك ادخل صورة المنظم');
    }

    return errorValidation;
  }
}
