import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../view/bottom_nav_bar.dart';

class YourProfileController extends GetxController {
  RxBool isYourLoading = false.obs;

  Future setUserData(
      {required var name,
      required var address,
      required var phoneNumber,
      required var email,
      required var profileImage}) async {
    try {
      // isYourLoading.value = true;
      FirebaseFirestore.instance
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "name": name,
        "address": address,
        "phoneNumber": phoneNumber,
        "email": email,
        "profileImage": profileImage,
      }).then(
        (value) => Get.offAll(BottomNavBar()),
      );
    } catch (e) {
      print(e);
      isYourLoading.value = false;
    }
  }
}
