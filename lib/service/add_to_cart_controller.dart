import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AddToCartController extends GetxController {
  RxBool isAddLoading = false.obs;
  var newData;
  var itemId2;

  Future setAddToCartData(data) async {
    data = true;
    newData = data;
    update();
  }

  Future setAddToCart(itemId, info2, totalItemPrice) async {
    if (newData == true) {
      FirebaseFirestore.instance
          .collection("Cart")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("Cart1")
          .doc(itemId)
          .set({
        "image": info2["itemImage"],
        "title": info2["name"],
        "description": info2["description"],
        "nutrition1": info2["nutrition1"],
        "nutrition2": info2["nutrition2"],
        "nutrition3": info2["nutrition3"],
        "nutrition4": info2["nutrition4"],
        "nutrition5": info2["nutrition5"],
        "price": info2["price"],
        "counter": 1,
        "totalItemPrice": totalItemPrice,
      });
    }
  }

  Future deleteCartItem(itemId) async {
    FirebaseFirestore.instance
        .collection("Cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Cart1")
        .doc(itemId)
        .delete();
  }

  Future addToCartVegetable(
    itemId,
    index1,
  ) async {
    FirebaseFirestore.instance
        .collection("Vagetables")
        .doc("VegetablesDoc")
        .collection(index1 == 0
            ? "OrganicVegetable"
            : index1 == 1
                ? "MixedVegetable"
                : index1 == 2
                    ? "Allium"
                    : "Root")
        .doc(itemId)
        .update({
      "Cart": newData,
    });
  }

  Future addToCartFruit(
    itemId,
    index1,
  ) async {
    FirebaseFirestore.instance
        .collection("Fruit")
        .doc("FruitDoc")
        .collection(index1 == 0
            ? "OrganicFruits"
            : index1 == 1
                ? "MixedFruitPack"
                : index1 == 2
                    ? "StoneFruits"
                    : "Melons")
        .doc(itemId)
        .update({"Cart": newData});
  }

  Future addToCartDryFruit(
    itemId,
    index1,
  ) async {
    FirebaseFirestore.instance
        .collection("DryFruit")
        .doc("DryFruitDoc")
        .collection(index1 == 0
            ? "IndehiscentDryFruits"
            : index1 == 1
                ? "MixedDryFruitsPack"
                : index1 == 2
                    ? "DehiscentDryFruits"
                    : "KashmiriDryFruits")
        .doc(itemId)
        .update({"Cart": newData});
  }
}
