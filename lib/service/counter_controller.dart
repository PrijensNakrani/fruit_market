import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CounterController extends GetxController {
  var totalCartPrice2;
  List prod = [];
  @override
  void onInit() async {
    // print("call onInit$itemId2"); // this line not printing
    super.onInit();
  }

  Future incrementPrice(itemId, totalItemPrice) async {
    FirebaseFirestore.instance
        .collection("Cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Cart1")
        .doc(itemId)
        .update({
      "totalItemPrice": totalItemPrice,
    });
  }

  bool isPlaceLoading = false;

  Future allCartItem(cartData) async {
    prod = [];
    cartData.map((DocumentSnapshot document) async {
      Map a = document.data() as Map<String, dynamic>;

      prod.add(a);
      a['id'] = document.id;
    }).toList();

    //print("yyyyyyy$prod");
  }

  Future placeOrder(total) async {
    FirebaseFirestore.instance
        .collection("Order")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Order1")
        .doc()
        .set({
      "totalCartPrice": total,
      'product': prod,
      "time": FieldValue.serverTimestamp()
    });
  }

  Future incrementFieldCounter(itemId, totalItemPrice) async {
    FirebaseFirestore.instance
        .collection("Cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Cart1")
        .doc(itemId)
        .update({
      "totalItemPrice": totalItemPrice,
      "counter": FieldValue.increment(1),
    });
    // FirebaseFirestore.instance
    //     .collection("Favourite")
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .collection("Favourite1")
    //     .doc(itemId)
    //     .update({
    //   "totalItemPrice": totalItemPrice,
    //   "counter": FieldValue.increment(1),
    // });
  }
  //
  // Future incrementFieldCounterFavourite(itemId, totalItemPrice) async {
  //   // FirebaseFirestore.instance
  //   //     .collection("Favourite")
  //   //     .doc(FirebaseAuth.instance.currentUser!.uid)
  //   //     .collection("Favourite1")
  //   //     .doc(itemId)
  //   //     .update({
  //   //   "totalItemPrice": totalItemPrice,
  //   //   "counter": FieldValue.increment(1),
  //   // });
  //   FirebaseFirestore.instance
  //       .collection("Cart")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection("Cart1")
  //       .doc(itemId)
  //       .update({
  //     "totalItemPrice": totalItemPrice,
  //     "counter": FieldValue.increment(1),
  //   });
  // }

  Future decrementFieldCounter(itemId, totalItemPrice) async {
    FirebaseFirestore.instance
        .collection("Cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Cart1")
        .doc(itemId)
        .update({
      "totalItemPrice": totalItemPrice,
      "counter": FieldValue.increment(-1),
    });
    // FirebaseFirestore.instance
    //     .collection("Favourite")
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .collection("Favourite1")
    //     .doc(itemId)
    //     .update({
    //   "totalItemPrice": totalItemPrice,
    //   "counter": FieldValue.increment(-1),
    // });
  }

  // Future decrementFieldCounterFavourite(itemId, totalItemPrice) async {
  //   // FirebaseFirestore.instance
  //   //     .collection("Favourite")
  //   //     .doc(FirebaseAuth.instance.currentUser!.uid)
  //   //     .collection("Favourite1")
  //   //     .doc(itemId)
  //   //     .update({
  //   //   "totalItemPrice": totalItemPrice,
  //   //   "counter": FieldValue.increment(-1),
  //   // });
  //   FirebaseFirestore.instance
  //       .collection("Cart")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection("Cart1")
  //       .doc(itemId)
  //       .update({
  //     "totalItemPrice": totalItemPrice,
  //     "counter": FieldValue.increment(-1),
  //   });
  // }
}
