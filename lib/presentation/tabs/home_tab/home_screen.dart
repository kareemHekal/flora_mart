import 'package:flora_mart/core/resuable_comp/search_bar/custom_searchbar_widget.dart';
import 'package:flora_mart/core/utils/colors_manager.dart';
import 'package:flora_mart/core/utils/string_manager.dart';
import 'package:flora_mart/presentation/tabs/home_tab/widgets/best_seller_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/Category widget.dart';
import 'widgets/occasion_widget.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onViewAllTapped;
  const HomeScreen({required this.onViewAllTapped, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset(
              "assets/images/Logo.png",
              height: 25.h,
              width: 89.w,
            ),
            CustomSearchBar(
              margin: EdgeInsets.all(3),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomScrollView(
          slivers: [
            // address
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    Icon(Icons.location_on_outlined),
                    Text("Deliver to 2XVP+XC - Sheikh Zayed"),
                    Icon(
                      Icons.keyboard_arrow_down_sharp,
                      size: 50,
                      color: ColorManager.pinkBase,
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        AppStrings.categories,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: widget.onViewAllTapped,
                        child: Text(
                          AppStrings.viewAll,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: ColorManager.pinkBase,
                            decorationThickness: 2.0,
                            color: ColorManager.pinkBase,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return CategoryWidget();
                      },
                    ),
                  ),
                  SizedBox(height: 10,),

                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        AppStrings.bestSeller,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Spacer(),
                      Text(
                        AppStrings.viewAll,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: ColorManager.pinkBase,
                          decorationThickness: 2.0,
                          color: ColorManager.pinkBase,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return BestSellerWidget(
                          image: 'https://picsum.photos/200',
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10,),

                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        AppStrings.occasion,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Spacer(),
                      Text(
                        AppStrings.viewAll,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: ColorManager.pinkBase,
                          decorationThickness: 2.0,
                          color: ColorManager.pinkBase,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return OccasionWidget(image: 'https://picsum.photos/200',);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
