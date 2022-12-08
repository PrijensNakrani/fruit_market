import 'package:flutter/material.dart';
import 'package:fruit_market/view/home_screen.dart';
import 'package:fruit_market/view/shopping_cart.dart';

import 'favourite_screen.dart';
import 'my_account_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  var bottomSelected = 0;
  var screen = [
    HomeScreen(),
    ShoppingCartScreen(),
    FavouriteScreen(),
    MyAccountScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[bottomSelected],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomSelected,
        onTap: (value) {
          setState(
            () {
              bottomSelected = value;
            },
          );
        },
        selectedItemColor: Color(0xff69A03A),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        elevation: 20,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: "Shopping Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_sharp), label: "My Account"),
        ],
      ),
    );
  }
}
