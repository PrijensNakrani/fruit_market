import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fruit_market/view/bottom_nav_bar.dart';
import 'package:fruit_market/view/login_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../view/otp_screen.dart';
import '../view/your_profile_screen.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingVeryfi = false.obs;
  String? verificationCode;
  var profileNumber;

  Future getOtp(phoneNumber, code, context) async {
    try {
      isLoading.value = true;
      update();
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: code + phoneNumber,
        codeAutoRetrievalTimeout: (String verificationId) {},
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Otp sent"),
            ),
          );
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          verificationCode = verificationId;
          Get.to(() => OTPScreen(phoneNumber: phoneNumber),
              transition: Transition.leftToRight);
          isLoading.value = false;
          profileNumber = phoneNumber;
          update();
        },
        verificationFailed: (FirebaseAuthException e) {
          isLoading.value = false;
          update();
          if (e.code == 'invalid-phone-number') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Invalid MobileNumber',
                ),
              ),
            );
          } else if (e.code == 'missing-phone-number') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'missing-phone-number',
                ),
              ),
            );
          } else if (e.code == 'user-disabled') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'user-disabled',
                ),
              ),
            );
            print('Number is Disabled');
          } else if (e.code == 'quota-exceeded') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'You try too many time. try later',
                ),
              ),
            );
          } else if (e.code == 'captcha-check-failed') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "try again",
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "varification faild",
                ),
              ),
            );
          }
          print('>>> Verification Failed');
        },
      );
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future veryfiOtp(smsCode, phoneNumber, context) async {
    try {
      isLoadingVeryfi.value = true;
      update();
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: verificationCode!, smsCode: smsCode))
          .catchError((e) {
        isLoadingVeryfi.value = false;
        update();
        if (e.code == 'expired-action-code') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Code Expired",
              ),
            ),
          );
        } else if (e.code == 'invalid-action-code') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Invalid Code",
              ),
            ),
          );
        } else if (e.code == 'user-disabled') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "User Disabled",
              ),
            ),
          );
        }
      }).then((value) {
        Get.off(
            () => YourProfileScreen(
                  phoneNumber: phoneNumber.toString(),
                  name: name,
                  email: email,
                  profileImage: image,
                ),
            transition: Transition.leftToRight);

        isLoadingVeryfi.value = false;
        update();
      });
    } catch (e) {
      isLoadingVeryfi.value = false;
      update();
      print(e.toString());
    }
  }

  Future logOutUser() async {
    FirebaseAuth.instance.signOut().then((value) => Get.offAll(LoginScreen()));
  }

  String? email;
  String? image;
  String? name;
  Future<bool> googleServices() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      print('=======>>>>${authCredential}');
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(authCredential);
      User? user = userCredential.user;

      name = user!.displayName;
      image = user.photoURL;
      email = user.email;
      GetStorage().write("name", name);
      GetStorage().write("profileImage", image);
      GetStorage().write("email", email);
      print("?????????$name");
      print("?????????$image");
      print("?????????$email");
      Get.offAll(BottomNavBar());
    } catch (e) {
      print(e);
    }
    return true;
  }
}
