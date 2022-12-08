import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/service/add_to_cart_controller.dart';
import 'package:fruit_market/service/counter_controller.dart';
import 'package:fruit_market/widget/text_size.dart';
import 'package:get/get.dart';

class DetailScreen extends StatelessWidget {
  final image;
  final title;
  final data;
  final tabSelected;
  final info2;
  final itemId;
  final index1;
  final description;
  final nutrition1;
  final nutrition2;
  final nutrition3;
  final nutrition4;
  final nutrition5;
  final price;
  const DetailScreen(
      {Key? key,
      this.image,
      this.title,
      this.description,
      this.nutrition1,
      this.nutrition2,
      this.nutrition3,
      this.nutrition4,
      this.nutrition5,
      this.price,
      this.data,
      this.info2,
      this.itemId,
      this.index1,
      this.tabSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nutrition = [
      nutrition1,
      nutrition2,
      nutrition3,
      nutrition4,
      nutrition5
    ];
    AddToCartController addToCartController = Get.put(AddToCartController());
    CounterController counterController = Get.put(CounterController());
    return GetBuilder<AddToCartController>(
      builder: (controller) {
        print("-------------");
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff69A03A),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Get.back();
              },
            ),
            title: TextSize(
              text: "Detail",
              weight: FontWeight.bold,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 24.h,
                  ),
                  Hero(
                    tag: image,
                    child: Container(
                      width: double.infinity,
                      height: 176.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        image: DecorationImage(
                            image: NetworkImage(image), fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  TextSize(
                    text: title,
                    weight: FontWeight.bold,
                    size: 18.sp,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  TextSize(
                    text: "$description",
                    weight: FontWeight.w400,
                    size: 14.sp,
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  TextSize(
                    text: "Nutrition",
                    weight: FontWeight.bold,
                    size: 18.sp,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  SizedBox(
                    height: 230.h,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: nutrition.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            CircleAvatar(
                              radius: 3.5.r,
                              backgroundColor: Colors.grey,
                            ),
                            SizedBox(
                              width: 13.w,
                            ),
                            TextSize(text: "${nutrition[index]}"),
                            SizedBox(
                              height: 22.h,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextSize(
                        text: "\u{20B9} ${price} Per/kg",
                        size: 16.sp,
                        weight: FontWeight.bold,
                      ),
                      GestureDetector(
                        onTap: () {
                          print("66666666$data");
                          controller.setAddToCartData(data);
                          print("+++++++++$tabSelected");
                          tabSelected == "Vagetables"
                              ? controller.addToCartVegetable(
                                  itemId,
                                  index1,
                                )
                              : tabSelected == "Fruit"
                                  ? controller.addToCartFruit(
                                      itemId,
                                      index1,
                                    )
                                  : controller.addToCartDryFruit(
                                      itemId,
                                      index1,
                                    );
                          controller.setAddToCart(
                              itemId, info2, int.parse(price));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Successfully Added In Cart")));
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
                              text: controller.newData == true
                                  ? "Added To Cart"
                                  : "Add To Cart",
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 40.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Color(0xff69A03A),
                        ),
                        child: Center(
                          child: TextSize(
                            text: "Buy Now",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
