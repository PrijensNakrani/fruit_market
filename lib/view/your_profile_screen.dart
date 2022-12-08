import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/widget/nexrContainer.dart';
import 'package:fruit_market/widget/textfield_demo.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../service/your_profile_controller.dart';

class YourProfileScreen extends StatelessWidget {
  final phoneNumber;
  final name;
  final email;
  final profileImage;
  YourProfileScreen(
      {Key? key, this.phoneNumber, this.name, this.email, this.profileImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _nameController = TextEditingController();
    final _addressController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    YourProfileController yourProfileController =
        Get.put(YourProfileController());
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Text(
                  "Enter Your Name",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15.h,
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
                    obscureText: false),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  "Add Address",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15.h,
                ),
                CommonTextField(
                    controller: _addressController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter Address";
                      }
                    },
                    keyboardType: TextInputType.streetAddress,
                    maxLines: 8,
                    hintText: "",
                    labelText: "",
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 20),
                    obscureText: false),
                SizedBox(
                  height: 30.h,
                ),
                SizedBox(
                  height: 54.h,
                ),
                Obx(
                  () => yourProfileController.isYourLoading == true
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              yourProfileController.setUserData(
                                profileImage: null,
                                email: null,
                                address: _addressController.text,
                                name: _nameController.text,
                                phoneNumber: phoneNumber,
                              );
                            }
                            GetStorage().write("name", _nameController.text);
                          },
                          child: NextContainer(text: "VERIFY"),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
