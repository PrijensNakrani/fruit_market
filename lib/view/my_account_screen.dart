import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/constant/const.dart';
import 'package:fruit_market/service/profile_controller.dart';
import 'package:fruit_market/service/update_user_info.dart';
import 'package:fruit_market/view/login_screen.dart';
import 'package:fruit_market/widget/nexrContainer.dart';
import 'package:fruit_market/widget/text_size.dart';
import 'package:fruit_market/widget/textfield_demo.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  ProfileController profileController = Get.put(ProfileController());
  UpdateProfileController updateProfileController =
      Get.put(UpdateProfileController());
  var _nameController = TextEditingController();
  final _addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("user").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: SizedBox());
            }
            var profileInfo = snapshot.data!.docs;
            if (snapshot.hasData) {
              return Container(
                height: 229.h,
                color: Color(0xff69A03A),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            GetStorage().remove("name").then(
                                  (value) => Get.offAll(
                                    LoginScreen(),
                                  ),
                                );
                          },
                          icon: Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 70.w,
                        ),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              child: CircleAvatar(
                                radius: 42.r,
                                backgroundImage: NetworkImage(
                                    profileController.profileImage == null
                                        ? profileController.defaultProfileImage
                                        : profileController.profileImage),
                              ),
                              radius: 43.r,
                              backgroundColor: Colors.white,
                            ),
                            Positioned(
                              bottom: -0,
                              right: -10,
                              child: InkWell(
                                onTap: () {
                                  updateProfileController.getGalleryImage();
                                },
                                child: CircleAvatar(
                                  radius: 20.r,
                                  backgroundColor: Color(0xffCC7D00),
                                  child: Center(
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 20.sp,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 80.w,
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SimpleDialog(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 30.h,
                                          ),
                                          SizedBox(
                                            height: 30.h,
                                          ),
                                          CommonTextField(
                                            controller: _nameController,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return "Enter Name";
                                              }
                                            },
                                            keyboardType: TextInputType.name,
                                            hintText: "Enter Name",
                                            labelText: "Enter Name",
                                            obscureText: false,
                                            action: TextInputAction.next,
                                          ),
                                          SizedBox(
                                            height: 30.h,
                                          ),
                                          CommonTextField(
                                            controller: _addressController,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return "Enter Address";
                                              }
                                            },
                                            keyboardType:
                                                TextInputType.streetAddress,
                                            maxLines: 5,
                                            hintText: "Address",
                                            labelText: "Address",
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.h, horizontal: 20),
                                            obscureText: false,
                                            action: TextInputAction.done,
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: SizedBox(
                                                  height: 50.h,
                                                  width: 100.w,
                                                  child: NextContainer(
                                                      text: "Cancel"),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20.w,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  updateProfileController
                                                      .updateUserData(
                                                    name: _nameController.text,
                                                    address:
                                                        _addressController.text,
                                                  );
                                                  setState(() {});
                                                },
                                                child: SizedBox(
                                                  height: 50.h,
                                                  width: 100.w,
                                                  child: NextContainer(
                                                      text: "Update"),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.edit_note_outlined,
                            color: Colors.white,
                            size: 35.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextSize(
                      text: profileController.name == null
                          ? ""
                          : profileController.name,
                      weight: FontWeight.bold,
                      color: Colors.white,
                      size: 16.sp,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    TextSize(
                      text: FirebaseAuth.instance.currentUser!.email == null
                          ? FirebaseAuth.instance.currentUser!.phoneNumber
                          : FirebaseAuth.instance.currentUser!.email,
                      weight: FontWeight.bold,
                      color: Colors.white,
                      size: 12.sp,
                    ),
                  ],
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ),
        preferredSize: Size.fromHeight(229.h),
      ),
      body: ListView.builder(
        itemCount: 8,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              ListTile(
                leading: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    profileIcon[index],
                    color: Color(0xff69A03A),
                  ),
                ),
                title: TextSize(
                  text: profileTitle[index],
                  weight: FontWeight.w600,
                ),
              ),
              Divider(
                thickness: 1,
              ),
            ],
          );
        },
      ),
    );
  }
}
