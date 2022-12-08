import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruit_market/view/login_screen.dart';

import '../constant/const.dart';
import '../widget/nexrContainer.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController _pageController = PageController(initialPage: 0);

  int isSelected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 560.h,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (value) {
                      setState(() {
                        isSelected = value;
                      });
                    },
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 29.w),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 87.h,
                            ),
                            Center(
                                child: SizedBox(
                                    height: 210.h,
                                    width: 272.w,
                                    child: SvgPicture.asset(images[index]))),
                            SizedBox(
                              height: 45.h,
                            ),
                            Text(
                              onTitle[index],
                              style: TextStyle(
                                  fontSize: 20.sp, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            Text(
                              onSubtitle[index],
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 550.h,
                  right: 165.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        height: 10.h,
                        width: isSelected == index ? 21.h : 10.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: isSelected == index
                              ? Color(0xff69A03A)
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 29.w),
              child: GestureDetector(
                onTap: () {
                  if (isSelected == 2) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  } else {
                    isSelected++;
                    _pageController.animateToPage(isSelected,
                        duration: Duration(seconds: 1), curve: Curves.easeOut);
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100.w),
                  child: NextContainer(text: "Next"),
                ),
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
          ],
        ),
      ),
    );
  }
}
