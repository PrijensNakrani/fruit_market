import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/service/counter_controller.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../widget/text_size.dart';
import 'detail_screen.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("&&&&&&&");
    CounterController counterController = Get.put(CounterController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff69A03A),
          title: TextSize(
            text: "Favourite",
            weight: FontWeight.bold,
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Favourite")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("Favourite1")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: SizedBox());
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                var info = snapshot.data!.docs;
                var info2 = snapshot.data!.docs[index];
                var itemId = snapshot.data!.docs[index].id;
                // num totalItemPrice =
                //     int.parse(info[index]["price"]) * info[index]["counter"];
                return SizedBox(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(
                              DetailScreen(
                                image: info[index]["image"],
                                title: info[index]["title"],
                                description: info[index]["description"],
                                nutrition1: info[index]["nutrition1"],
                                nutrition2: info[index]["nutrition2"],
                                nutrition3: info[index]["nutrition3"],
                                nutrition4: info[index]["nutrition4"],
                                nutrition5: info[index]["nutrition5"],
                                price: info[index]["price"],
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 16.h),
                            height: 95.h,
                            width: 95.w,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: CachedNetworkImage(
                                imageUrl: '${info[index]["image"]}',
                                height: Get.height * 0.1,
                                width: Get.width * 0.4,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.grey.shade200,
                                  highlightColor: Colors.grey.shade300,
                                  child: Container(
                                    height: Get.height * 0.1,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 16.h),
                              child: TextSize(
                                text: '${info[index]["title"]}',
                                size: 14.sp,
                                weight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            TextSize(
                              text: "Pick up from organic farms",
                              size: 10.sp,
                              weight: FontWeight.w400,
                              color: Colors.grey.shade700,
                            ),
                            SizedBox(
                              height: 6.5.h,
                            ),
                            Row(
                              children: List.generate(
                                5,
                                (index) => Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                  size: 14.sp,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            // Row(
                            //   children: [
                            //     InkWell(
                            //       onTap: () {
                            //         if (info[index]["counter"] > 1) {
                            //           counterController
                            //               .decrementFieldCounterFavourite(
                            //                   itemId, totalItemPrice);
                            //         }
                            //       },
                            //       child: Container(
                            //         height: 25.h,
                            //         width: 25.w,
                            //         decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(5.r),
                            //           border: Border.all(color: Colors.black),
                            //         ),
                            //         child: Center(
                            //           child: Icon(
                            //             Icons.remove,
                            //             size: 15.sp,
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       width: 16.w,
                            //     ),
                            //     TextSize(
                            //       text: "${info[index]["counter"]}",
                            //       size: 15.sp,
                            //     ),
                            //     SizedBox(
                            //       width: 16.w,
                            //     ),
                            //     InkWell(
                            //       onTap: () {
                            //         counterController
                            //             .incrementFieldCounterFavourite(
                            //                 itemId, totalItemPrice);
                            //       },
                            //       child: Container(
                            //         height: 25.h,
                            //         width: 25.w,
                            //         decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(5.r),
                            //           border: Border.all(color: Colors.black),
                            //         ),
                            //         child: Center(
                            //           child: Icon(
                            //             Icons.add,
                            //             size: 15.sp,
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // )
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 16.h),
                              child: TextSize(
                                text: '\u{20B9} ${info[index]["price"]} Per/kg',
                                size: 12.sp,
                                weight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 52.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                FirebaseFirestore.instance
                                    .collection("Cart")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection("Cart1")
                                    .doc(itemId)
                                    .set({
                                  "image": info2["image"],
                                  "title": info2["title"],
                                  "description": info2["description"],
                                  "nutrition1": info2["nutrition1"],
                                  "nutrition2": info2["nutrition2"],
                                  "nutrition3": info2["nutrition3"],
                                  "nutrition4": info2["nutrition4"],
                                  "nutrition5": info2["nutrition5"],
                                  "price": info2["price"],
                                  "counter": 1,
                                  "totalItemPrice":
                                      int.parse(info[index]["price"]),
                                  "totalCartPrice": 0,
                                }).then((value) => ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            content: Text(
                                                "Successfully Added In Cart"))));
                              },
                              child: Container(
                                height: 27.h,
                                width: 68.w,
                                decoration: BoxDecoration(
                                  color: Color(0xffCC7D00),
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: Center(
                                  child: TextSize(
                                    text: "Add",
                                    size: 12.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
