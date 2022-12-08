import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var name;
  var email;
  var address;
  var profileImage;
  var defaultProfileImage =
      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";
  @override
  void onInit() async {
    print("call onInit"); // this line not printing
    super.onInit();
    getProfileDetaile();
  }

  Future getProfileDetaile() async {
    final user = await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    Map<String, dynamic>? userData = user.data();
    name = userData!["name"];
    address = userData["address"];
    email = userData["email"];
    profileImage = userData["profileImage"];
    print("99999999$name");
    print("99999999$profileImage");
    // print("99999999$address");
    print("99999999$defaultProfileImage");
    update();
  }
}
