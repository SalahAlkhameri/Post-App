import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../models/user_model.dart';
import '../view/signin.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

class UserController extends GetxController {
  var isLoading = false.obs;
  final _db = FirebaseFirestore.instance;
  // File? imageFile;
  late UserModel _user;
  Rx<File?> imageFile = Rx<File?>(null);
  final picker = ImagePicker();

  File? get image => imageFile.value;


  final storage = GetStorage();

  final darkModeEnabled = RxBool(false);
  final icon = Rx<IconData>(LineAwesomeIcons.sun);

  @override
  void onInit() {
    // storage.write('imageStorage', "");
    darkModeEnabled.value = storage.read('darkModeEnabled') ?? false;
    icon.value =
        darkModeEnabled.value ? LineAwesomeIcons.moon : LineAwesomeIcons.sun;
    super.onInit();
  }

  Future<void> saveImageUrl() async {
    await GetStorage().write('imageStorage', _user.image);
  }
  Future<String?> getImageUrl() async {
    final url = await GetStorage().read('imageStorage');
    return url;
  }

  addUser(String name, String email, String password) async {
    if (await checkIfEmailExists(email)) {
      isLoading.value = true;

      UserModel userModel = UserModel();
      userModel.name = name;
      userModel.gmail = email;
      userModel.password = password;

      _db.collection("users").doc(email).set(userModel.toMap()).then((value) {
        isLoading.value = false;
        Get.snackbar("إضافة المستخدم", "تم إضافة المستخدم بنجاح",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.green);

        Get.to(SignIn(), arguments: email);
        print("#################################################");
        print(userModel.image);
        print(userModel.name);
        print(userModel.phone);
        print(userModel.id);
        print("#################################################");
        storage.write('emailStorage', email);
        storage.write('imageStorage', userModel.image);
        storage.write('nameStorage', name);
      }).catchError((onError) {
        isLoading.value = false;
        Get.snackbar(
            "إضافة المستخدم", "لم يتم إضافة المستخدم تأكد من إتصالك بلإنترنت",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.red);
      });
    } else {
      Get.snackbar("", "يوجد حساب مسجل بنفس البريد الإلكتروني",
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }

  Future<UserModel> getUserDetailes(String email) async {
    final snapshot =
        await _db.collection("users").where("gmail", isEqualTo: email).get();
    final usermodel =
        snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;

    return usermodel;
  }

  Future<bool> checkIfEmailExists(String email) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .where('gmail', isEqualTo: email)
        .limit(1)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    if (documents.isNotEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> updateUserRecord(UserModel user) async {
    await _db
        .collection("users")
        .doc("k1OqkMb3WL8nbXwaZ0mY")
        .update(user.toMap());
  }

  Future getImageFromGallery(BuildContext context) async {
    // final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if(pickedFile != null){
      imageFile.value = File(pickedFile.path);
      update();
    }
  }
  Future getImageFromCamera(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if(pickedFile != null){
      imageFile.value = File(pickedFile.path);

      // final storageRef = FirebaseStorage.instance.ref();
      // final mountainsRef = storageRef.child("mountains.jpg");
      // final mountainImagesRef = storageRef.child("images/mountains.jpg");
      // UploadTask uploadTask = mountainsRef.putFile(pickedFile as File);
      // assert(mountainsRef.name == mountainImagesRef.name);
      // assert(mountainsRef.fullPath != mountainImagesRef.fullPath);
      update();
    }
  }
  Future getImageFromCamfera(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if(pickedFile != null){
      File image = File(pickedFile.path);
      String imageURL = await uploadImageToFirebase(image);
      print("----------------------");
      print(imageURL);
      // storage.write("imageStorage", imageURL);
      imageFile.value = image;
      storage.write("imageStorage", imageURL);
      update();
      return imageURL;
    }
    return null;
  }

  Future<String> uploadImageToFirebase(File imageFile) async {
    String imageURL = "";
    Reference storageReference =
    FirebaseStorage.instance.ref().child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
    UploadTask uploadTask = storageReference.putFile(imageFile);
    await uploadTask.whenComplete(() async {
      imageURL = await storageReference.getDownloadURL();
    });

    return imageURL;
  }
  Future<void> uploadPic(BuildContext context) async {

    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            content: Container(
              height: 120,
              child: Column(
                children: [
                  ListTile(
                    onTap: ()async{
                      Get.back();
                      await  getImageFromCamfera(context);
                    },
                    leading: Icon(Icons.camera,
                      color: Colors.red,),
                    title: Text("Camera"),
                  ),
                  ListTile(
                    onTap: () async {
                      Get.back();
                      await getImageFromGallery(context);
                    },
                    leading: Icon(Icons.image,
                      color: Colors.red,),
                    title: Text("Gallery"),
                  ),
                ],
              ),

            ),
          );
        });
  }


  void changeTheme() {
    // final newDarkModeEnabled = !darkModeEnabled.value;
    print("----------------------");
    // print(newDarkModeEnabled);
    darkModeEnabled.value = !darkModeEnabled.value;
    storage.write('darkModeEnabled', darkModeEnabled.value);

    if (darkModeEnabled.value) {
      Get.changeThemeMode(ThemeMode.dark);
      icon.value = LineAwesomeIcons.moon;
    } else {
      Get.changeThemeMode(ThemeMode.light);
      icon.value = LineAwesomeIcons.sun;
    }
  }
}
