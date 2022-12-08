import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/service/add_to_cart_controller.dart';
import 'package:fruit_market/service/place_order_controller.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../service/counter_controller.dart';
import '../widget/text_size.dart';
import 'detail_screen.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  CounterController counterController = Get.put(CounterController());
  AddToCartController addToCartController = Get.put(AddToCartController());
  PlaceOrderController placeOrderController = Get.put(PlaceOrderController());
  num totalPrice = 0;
  var itemId2;
  List prod = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff69A03A),
        title: TextSize(
          text: "Shopping Cart",
          weight: FontWeight.bold,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Cart")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("Cart1")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: SizedBox());
          }
          var data = snapshot.data!.docs;
          totalPrice = 0;
          for (int i = 0; i < data.length; i++) {
            totalPrice += data[i]['totalItemPrice'] as num;
          }
          // print('*******************$totalPrice');
          return SizedBox(
            height: 600.h,
            width: 400.w,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      var itemId = snapshot.data!.docs[index].id;
                      var info = snapshot.data!.docs;
                      var info2 = snapshot.data!.docs[index];

                      num totalItemPrice = int.parse(info[index]["price"]) *
                          info[index]["counter"];
                      print("---------$totalItemPrice");
                      counterController.incrementPrice(itemId, totalItemPrice);

                      // counterController.totalCartPrice(
                      //     info, itemId, totalItemPrice);
                      prod = [];
                      counterController.allCartItem(snapshot.data!.docs);

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
                                      size: 16.sp,
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
                                    height: 15.h,
                                  ),
                                  TextSize(
                                    text:
                                        '\u{20B9} ${info[index]["price"]} Per/kg',
                                    size: 14.sp,
                                    weight: FontWeight.w600,
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 16.h),
                                    child: InkWell(
                                        onTap: () {
                                          FirebaseFirestore.instance
                                              .collection("Cart")
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .collection("Cart1")
                                              .doc(itemId)
                                              .delete();
                                        },
                                        child: Icon(Icons.delete)),
                                  ),
                                  SizedBox(
                                    height: 52.h,
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (info[index]["counter"] > 1) {
                                            counterController
                                                .decrementFieldCounter(
                                                    itemId, totalItemPrice);
                                          }
                                        },
                                        child: Container(
                                          height: 25.h,
                                          width: 25.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.r),
                                            border:
                                                Border.all(color: Colors.black),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.remove,
                                              size: 15.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 16.w,
                                      ),
                                      TextSize(
                                        text: "${info[index]["counter"]}",
                                        size: 15.sp,
                                      ),
                                      SizedBox(
                                        width: 16.w,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          counterController
                                              .incrementFieldCounter(
                                                  itemId, totalItemPrice);
                                        },
                                        child: Container(
                                          height: 25.h,
                                          width: 25.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.r),
                                            border:
                                                Border.all(color: Colors.black),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.add,
                                              size: 15.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextSize(
                        text: "Total- Rs $totalPrice",
                        size: 16.sp,
                        weight: FontWeight.bold,
                      ),
                      GestureDetector(
                        onTap: () async {
                          counterController
                              .placeOrder(counterController.totalCartPrice2);
                          var info = await FirebaseFirestore.instance
                              .collection("Cart")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection('Cart1')
                              .get();
                          info.docs.forEach(
                            (element) {
                              FirebaseFirestore.instance
                                  .collection("Cart")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .collection('Cart1')
                                  .doc(element.id)
                                  .delete()
                                  .then(
                                    (value) => ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text("Order Placed"),
                                      ),
                                    ),
                                  );
                            },
                          );
                          print("uuuuuu${counterController.totalCartPrice2}");
                        },
                        child: Container(
                          height: 40.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: Color(0xff69A03A),
                          ),
                          child: Center(
                            child: TextSize(
                              text: "Place Order",
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// class TotalPrice extends StatelessWidget {
//   final total;
//   const TotalPrice({Key? key, this.total}) : super(key: key);
//
//
//   @override
//   Widget build(BuildContext context) {
//     CounterController counterController = Get.put(CounterController());
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20.w),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           TextSize(
//             text: "Total- Rs ${counterController.totalCartPrice2}",
//             size: 16.sp,
//             weight: FontWeight.bold,
//           ),
//           GestureDetector(
//             onTap: () {},
//             child: Container(
//               height: 40.h,
//               width: 100.w,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(5.r),
//                 color: Color(0xff69A03A),
//               ),
//               child: Center(
//                 child: TextSize(
//                   text: "Place Order",
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
