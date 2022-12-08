import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AddFavouriteDataController extends GetxController {
  RxBool isAddLoading = false.obs;
  var newData;

  Future setFavouriteData(data) async {
    data = !data;
    newData = data;
    // update();
  }

  Future setFavourite(itemId, info2, counter, totalItemPrice) async {
    if (newData == true) {
      FirebaseFirestore.instance
          .collection("Favourite")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("Favourite1")
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
        "counter": counter,
        "totalItemPrice": totalItemPrice,
        "totalCartPrice": 0,
      });
    } else {
      FirebaseFirestore.instance
          .collection("Favourite")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("Favourite1")
          .doc(itemId)
          .delete();
    }
  }

  Future addFavouriteVegetable(
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
        .update({"Favourite": newData});
  }

  Future addFavouriteFruit(
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
        .update({"Favourite": newData});
  }

  Future addFavouriteDryFruit(
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
        .update({"Favourite": newData});
  }
}
