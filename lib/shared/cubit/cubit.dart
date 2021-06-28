import 'dart:io';

import 'package:clerk/models/saved_doc_model.dart';
import 'package:clerk/models/textcorrection_model.dart';
import 'package:clerk/modules/error_correction_screen/error_correction_screen.dart';
import 'package:clerk/modules/summarization_screen/summarization-screen.dart';
import 'package:clerk/modules/text_extraction_screen/text_extraction_screen.dart';
import 'package:clerk/modules/translation_screen/translation_screen.dart';
import 'package:clerk/shared/components/defaults.dart';
import 'package:clerk/shared/constants.dart';
import 'package:clerk/models/summarization_model.dart';
import 'package:clerk/models/translation_model.dart';
import 'package:clerk/models/user_model.dart';
import 'package:clerk/networks/local/cache_helper.dart';
import 'package:clerk/networks/remote/dio_helper.dart';
import 'package:clerk/shared/cubit/states.dart';

import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(ClerkInitialState());
  int selectedIndex = 0;
  List<Widget> screens = [
    ErrorCorrectionScreen(),
    TranslationScreen(),
    SummarizationScreen(),
    TextExtractionScreen(),
  ];

  void changeNavBar(int value) {
    selectedIndex = value;
    emit(ChangeNavBarState());
  }

  static AppCubit get(context) => BlocProvider.of(context);

  // Get User Data
  UserModel userModel;
  void getUserData() {
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .snapshots()
        .listen((event) {
      userModel = UserModel.fromJson(event.data());
      emit(GetUserDataSuccessState());
    });
  }

  // Update User Data
  void updateUserData({
    String key,
    String value,
  }) {
    emit(UpdateUserDataLoadingState());
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .update({key: value}).then((value) {
      emit(UpdateUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(UpdateUserDataErrorState());
    });
  }

  void signOut() {
    FirebaseAuth.instance.signOut().then((value) {
      CacheHelper.removeData("token");
      emit(UserSignOutSuccessState());
    });
  }

  final picker = ImagePicker();
  File image;
  Future getImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  void uploadProfileImage() {
    emit(UpdateUserDataLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(image.path).pathSegments.last}')
        .putFile(image)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserData(key: "userImage", value: value);
        emit(UploadUserProfileSuccessState());
      }).catchError((error) {
        emit(UploadUserProfileErrorState());
      });
    }).catchError((error) {
      emit(UploadUserProfileErrorState());
    });
  }

  // Translation Text
  TranslationModel translationModel;
  void translateText({String text}) {
    emit(TranslateTextLoadingState());
    DioHelper.postData(
            url: "https://translation.googleapis.com/language/translate/v2",
            query: {"key": translationApiKey, "q": text, "target": "ar"})
        .then((value) {
      translationModel = TranslationModel.fromJson(value.data);
      emit(TranslateTextSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(TranslateTextErrorState());
    });
  }

  // Summarize Text
  SummarizationModel summarizationModel;
  void summarizeText({String text}) {
    emit(SummarizeTextLoadingState());
    DioHelper.postData(
        url: "https://api.meaningcloud.com/summarization-1.0",
        query: {
          "key": summarizationApiKey,
          "txt": text,
          "sentences": 5,
          "of": "json"
        }).then((value) {
      summarizationModel = SummarizationModel.fromJson(value.data);
      emit(SummarizeTextSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SummarizeTextErrorState());
    });
  }

  void copyToClipboard({BuildContext context, String text}) {
    if (text.trim() != '') {
      FlutterClipboard.copy(text);
      customSnackBar(context: context, text: "text Copied");
    }
  }

  void convertFileIntoText(TextEditingController controller) {
    FilePicker.platform.pickFiles().then((value) async {
      controller.text = await File(value.files.single.path).readAsString();
      emit(FilePickedSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(FilePickedErrorState());
    });
  }

  bool isUploaded = false;
  IconData uploadIcon = Icons.upload_file;
  void changeUploadIcon({bool isShow, IconData icon}) {
    isUploaded = isShow;
    uploadIcon = icon;
    emit(ChangeUploadIconState());
  }

  // Error Correction
  TextCorrectionModel textCorrectionModel;
  void textCorrection(String text) {
    emit(TextCorrectionLoadingState());
    DioHelper.postData(
        url: "http://0b599c918c4c.ngrok.io/predict",
        query: {"text": text}).then((value) {
      textCorrectionModel = TextCorrectionModel.fromJson(value.data);
      print(textCorrectionModel.output);
      emit(TextCorrectionSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(TextCorrectionErrorState());
    });
  }

  // Get User Saved Docs
  List<SavedDocModel> savedDocModel = [];
  void getSavedDocs() {
    emit(UserSavedDocLoadingState());
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("saved")
        .snapshots()
        .listen((event) {
      savedDocModel = [];
      event.docs.forEach((element) {
        savedDocModel.add(SavedDocModel.fromJson(element.data()));
        emit(UserSavedDocSuccessState());
      });
    });
  }
}
