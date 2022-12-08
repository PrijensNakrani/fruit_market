import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fruit_market/service/favourite_controller.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../widget/text_16.dart';
import '../widget/text_size.dart';
import 'detail_screen.dart';

class VegetableScreen extends StatelessWidget {
  final tabSelected;
  final searchText;
  const VegetableScreen({Key? key, this.searchText, this.tabSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddFavouriteDataController addFavouriteDataController =
        Get.put(AddFavouriteDataController());
    return GetBuilder<AddFavouriteDataController>(
      builder: (controller) {
        print("-------------$tabSelected");
        return SizedBox(
          height: 800.h,
          width: 400,
          child: MasonryGridView.count(
            itemCount: 4,
            crossAxisCount: 1,
            itemBuilder: (context, index1) {
              return SizedBox(
                  height: 300.h,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          children: [
                            Text16(
                                text: index1 == 0
                                    ? "Organic Vegetables"
                                    : index1 == 1
                                        ? "Mixed Vegetables Pack"
                                        : index1 == 2
                                            ? "Allium"
                                            : "Root Vegetabels"),
                            SizedBox(
                              width: 10.w,
                            ),
                            TextSize(
                              text: "(20% off)",
                              size: 12.sp,
                              color: Color(0xff4CA300),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: TextSize(
                          text: index1 == 0
                              ? "Pick up from organic farms"
                              : index1 == 1
                                  ? "Vegetable mix fresh pack"
                                  : index1 == 2
                                      ? "Fresh Allium Vegetables"
                                      : "Root Vegetabels",
                          size: 12.sp,
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("Vagetables")
                            .doc("VegetablesDoc")
                            .collection(index1 == 0
                                ? "OrganicVegetable"
                                : index1 == 1
                                    ? "MixedVegetable"
                                    : index1 == 2
                                        ? "Allium"
                                        : "Root")
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Center(child: Text('Something went wrong'));
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: SizedBox());
                          }

                          List<DocumentSnapshot> info = snapshot.data!.docs;
                          print("length======>${info.length}");
                          print("Text======>${searchText}");
                          if (searchText.isNotEmpty) {
                            info = info.where((element) {
                              return element
                                  .get('name')
                                  .toString()
                                  .toLowerCase()
                                  .contains(searchText.toLowerCase());
                            }).toList();
                          }
                          return Column(
                            children: [
                              // TextSize(
                              //   text: info[index]["subCategoryName"],
                              //   weight: FontWeight.w600,
                              // ),
                              SizedBox(
                                height: 210.h,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: info.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var data =
                                        snapshot.data!.docs[index]["Favourite"];
                                    var cartData =
                                        snapshot.data!.docs[index]["Cart"];
                                    print("4444444444$cartData");
                                    var info2 = snapshot.data!.docs[index];
                                    var itemId = snapshot.data!.docs[index].id;
                                    var subCategoryName = snapshot
                                        .data!.docs[index]["subCategoryName"];
                                    print("********$subCategoryName");

                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              print("4444444444$cartData");
                                              Get.to(
                                                DetailScreen(
                                                  info2: info2,
                                                  data: cartData,
                                                  index1: index1,
                                                  itemId: itemId,
                                                  tabSelected: subCategoryName,
                                                  image: info[index]
                                                      ["itemImage"],
                                                  title: info[index]["name"],
                                                  description: info[index]
                                                      ["description"],
                                                  nutrition1: info[index]
                                                      ["nutrition1"],
                                                  nutrition2: info[index]
                                                      ["nutrition2"],
                                                  nutrition3: info[index]
                                                      ["nutrition3"],
                                                  nutrition4: info[index]
                                                      ["nutrition4"],
                                                  nutrition5: info[index]
                                                      ["nutrition5"],
                                                  price: info[index]["price"],
                                                ),
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                              child: Stack(
                                                children: [
                                                  Hero(
                                                    tag: info[index]
                                                        ["itemImage"],
                                                    child: Container(
                                                      height: 143.h,
                                                      width: 114.w,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.r),
                                                        color: Colors.red,
                                                      ),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            '${info[index]["itemImage"]}',
                                                        height:
                                                            Get.height * 0.1,
                                                        width: Get.width * 0.4,
                                                        fit: BoxFit.cover,
                                                        placeholder: (context,
                                                                url) =>
                                                            Shimmer.fromColors(
                                                          baseColor: Colors
                                                              .grey.shade200,
                                                          highlightColor: Colors
                                                              .grey.shade300,
                                                          child: Container(
                                                            height: Get.height *
                                                                0.1,
                                                            color: Colors
                                                                .grey.shade400,
                                                          ),
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(Icons.error),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 5.h,
                                                    right: 9.w,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        controller
                                                            .setFavouriteData(
                                                                data);

                                                        controller
                                                            .addFavouriteVegetable(
                                                          itemId,
                                                          index1,
                                                        );
                                                        controller.setFavourite(
                                                            itemId,
                                                            info2,
                                                            1,
                                                            int.parse(
                                                                info[index]
                                                                    ["price"]));

                                                        print(
                                                            "9999999999$data");
                                                        print(
                                                            "77777777777${snapshot.data!.docs[index].id}");
                                                      },
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.white,
                                                        radius: 12.5.r,
                                                        child: Icon(
                                                          data == false
                                                              ? Icons
                                                                  .favorite_border
                                                              : Icons.favorite,
                                                          color: Colors.orange,
                                                          size: 18.sp,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Row(
                                            children: List.generate(
                                              5,
                                              (index) => Icon(
                                                Icons.star,
                                                size: 14.sp,
                                                color: Color(0xffFFB238),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          TextSize(
                                            text: info[index]["name"],
                                            weight: FontWeight.w600,
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          TextSize(
                                            text:
                                                "\u{20B9} ${info[index]["price"]} Per/kg",
                                            size: 12.sp,
                                            weight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ));
            },
          ),
        );
      },
    );
  }
}
