import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_market/view/dry_fruit_screen.dart';
import 'package:fruit_market/view/fruit_screen.dart';
import 'package:fruit_market/view/vegetable_screen.dart';
import 'package:fruit_market/widget/fruit_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List<String> tabItems = ["Vegetable", "Fruit", "Dry Fruit"];
  TabController? tabController;
  int tabSelected = 0;
  TextEditingController searchController = TextEditingController();
  String searchText = '';

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 100.h,
                color: Color(0xff69A03A),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FruitText(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: -28.h,
                left: 20.h,
                right: 20.h,
                child: Material(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.h),
                  ),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 20.h,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.h),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.h),
                      ),
                      filled: true,
                      hintText: 'Search',
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          preferredSize: Size.fromHeight(100.h),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40.h, right: 30.w, left: 30.w),
              child: TabBar(
                indicatorWeight: 0,
                indicatorSize: TabBarIndicatorSize.tab,
                labelPadding: EdgeInsets.all(5),
                indicator: UnderlineTabIndicator(
                  insets: EdgeInsets.all(5),
                ),
                padding: EdgeInsets.zero,
                indicatorColor: Colors.green,
                physics: NeverScrollableScrollPhysics(),
                controller: tabController,
                onTap: (value) {
                  setState(() {
                    tabSelected = value;
                  });
                },
                tabs: List.generate(
                  tabItems.length,
                  (index) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: tabSelected == index
                          ? Color(0xffCC7D00)
                          : Colors.white,
                    ),
                    margin: EdgeInsets.zero,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 5),
                        child: Text(
                          tabItems[index],
                          style: TextStyle(
                              fontSize: 11,
                              color: tabSelected == index
                                  ? Colors.white
                                  : Colors.grey.shade700),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: tabController,
                children: [
                  VegetableScreen(
                      searchText: searchText, tabSelected: tabSelected),
                  FruitScreen(searchText: searchText, tabSelected: tabSelected),
                  DryFruitScreen(
                      searchText: searchText, tabSelected: tabSelected),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
