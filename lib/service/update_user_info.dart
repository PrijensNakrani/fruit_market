import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileController extends GetxController {
  RxBool isAddLoading = false.obs;
  RxBool isUpdateLoading = false.obs;
  final picker = ImagePicker();
  File? image;

  Future getCameraImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      update();
      print("=========${image}");
    }
  }

  Future getGalleryImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      updateUserPhoto(profileImage: image);
      update();
      print("=========>>>${image}");
    }
  }

  Future<String?> uploadFile({File? file, String? filename}) async {
    print("File path:$file");
    try {
      var response = await FirebaseStorage.instance
          .ref("user_image/$filename")
          .putFile(file!);
      var result =
          await response.storage.ref("user_image/$filename").getDownloadURL();
      return result;
    } catch (e) {
      print("ERROR===>>$e");
    }
    return null;
  }

  Future updateUserPhoto({required var profileImage}) async {
    try {
      isUpdateLoading.value = true;
      var id2 = Random().nextInt(1000000);
      print("===============${id2}");

      String? itemImage = await uploadFile(file: image, filename: "${id2}");
      update();
      FirebaseFirestore.instance
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "profileImage": itemImage,
      });
    } catch (e) {
      print(e);
      isUpdateLoading.value = false;
    }
  }

  Future updateUserData({required var name, required var address}) async {
    try {
      isUpdateLoading.value = true;
      update();
      FirebaseFirestore.instance
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "name": name,
        "address": address,
      });
    } catch (e) {
      print(e);
      isUpdateLoading.value = false;
    }
  }
}
