import 'package:flora_mart/core/resuable_comp/flower_card_resuble/flower_card_builder.dart';
import 'package:flora_mart/data/model/products/Products.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Products> products = [
      //list of products for testing
      Products(
        title: "Wdding Flower",
        imgCover:
            "https://flower.elevateegy.com/uploads/fefa790a-f0c1-42a0-8699-34e8fc065812-cover_image.png",
        price: 440,
        priceAfterDiscount: 100,
        discount: 50,
      ),
      Products(
        title: "Red Wdding Flower",
        imgCover:
            "https://flower.elevateegy.com/uploads/5452abf4-2040-43d7-bb3d-3ae8f53c4576-cover_image.png",
        price: 440,
        priceAfterDiscount: 100,
        discount: 50,
      ),
      Products(
        title: "Wdding Flower",
        imgCover:
            "https://flower.elevateegy.com/uploads/5165a2c1-3e6c-44db-96f3-97ee83a29da9-cover_image.png",
        price: 440,
        priceAfterDiscount: 100,
        discount: 50,
      ),
      Products(
        title: "Wdding Flower",
        imgCover:
            "https://flower.elevateegy.com/uploads/5165a2c1-3e6c-44db-96f3-97ee83a29da9-cover_image.png",
        price: 440,
        priceAfterDiscount: 100,
        discount: 50,
      ),
      Products(
        title: "Wdding Flower",
        imgCover:
            "https://flower.elevateegy.com/uploads/5165a2c1-3e6c-44db-96f3-97ee83a29da9-cover_image.png",
        price: 440,
        priceAfterDiscount: 100,
        discount: 50,
      ),
      Products(
        title: "Wdding Flower",
        imgCover:
            "https://flower.elevateegy.com/uploads/5165a2c1-3e6c-44db-96f3-97ee83a29da9-cover_image.png",
        price: 440,
        priceAfterDiscount: 100,
        discount: 50,
      ),
      Products(
        title: "Wdding Flower",
        imgCover:
            "https://flower.elevateegy.com/uploads/5165a2c1-3e6c-44db-96f3-97ee83a29da9-cover_image.png",
        price: 440,
        priceAfterDiscount: 100,
        discount: 50,
      ),
      Products(
        title: "Wdding Flower",
        imgCover:
            "https://flower.elevateegy.com/uploads/5165a2c1-3e6c-44db-96f3-97ee83a29da9-cover_image.png",
        price: 440,
        priceAfterDiscount: 100,
        discount: 50,
      ),
      Products(
        title: "Wdding Flower",
        imgCover:
            "https://flower.elevateegy.com/uploads/5165a2c1-3e6c-44db-96f3-97ee83a29da9-cover_image.png",
        price: 440,
        priceAfterDiscount: 100,
        discount: 50,
      ),
      Products(
        title: "Wdding Flower",
        imgCover:
            "https://flower.elevateegy.com/uploads/5165a2c1-3e6c-44db-96f3-97ee83a29da9-cover_image.png",
        price: 440,
        priceAfterDiscount: 100,
        discount: 50,
      ),
    ];
    return FlowerCardBuilder(products: products); //this is a custom widget
  }
}
