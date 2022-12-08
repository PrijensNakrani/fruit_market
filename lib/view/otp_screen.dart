import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/widget/nexrContainer.dart';
import 'package:get/get.dart';

import '../service/mobile_auth.dart';
import '../widget/textfield_demo.dart';

class OTPScreen extends StatelessWidget {
  String? phoneNumber;
  String? mobileCode;
  OTPScreen({Key? key, this.mobileCode, this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("555555555$phoneNumber");
    AuthController authController = Get.put(AuthController());
    final _smsCode = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 21.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                ),
                SizedBox(
                  height: 98.h,
                ),
                Text(
                  "Enter Code",
                  style:
                      TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  "We have sent you an SMS with the code\n your phone number",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 48.h,
                ),
                Container(
                  height: 55.h,
                  width: 250.w,
                  child: CommonTextField(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 30.w),
                    controller: _smsCode,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'please Enter the PhoneNumber';
                      }
                    },
                    hintText: 'Enter Your Mobile Number',
                    labelText: 'Enter Your Mobile Number',
                    obscureText: false,
                    keyboardType: TextInputType.phone,
                  ),
                ),
                SizedBox(
                  height: 81.h,
                ),
                Obx(
                  () => authController.isLoadingVeryfi.value == true
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : GestureDetector(
                          onTap: () async {
                            authController.veryfiOtp(
                                _smsCode.text, phoneNumber, context);
                          },
                          child: NextContainer(text: "Continue"),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
