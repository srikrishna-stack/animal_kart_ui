import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/buffalo.dart';

final buffaloListProvider = Provider<List<Buffalo>>((ref) {
  return const [
    Buffalo(
      id: "MURRAH-001",
      breed: "Murrah Buffalo",
      milkYield: 12,
      price: 150000,
      inStock: true,
      insurance: 13000,
      image: "assets/images/murrah_bufflao.png", 
      description:
          "The Murrah is a premium dairy buffalo known for its jet-black coat, "
          "strong build, and curved horns. It is famous for high milk yield, "
          "rich fat content, and excellent adaptability to different climates.",
    ),
    Buffalo(
      id: "JAFF-001",
      breed: "Jaffarabadi Buffalo",
      milkYield: 10,
      price: 175000,
      inStock: true,
      insurance: 13000,
      image: "assets/images/buffalo_images.jpg",
      description:
          "The Jaffarabadi is one of the heaviest and strongest buffalo breeds. "
          "It offers good milk production and is valued for its robust health.",
    ),
    Buffalo(
      id: "SURTI-001",
      breed: "Surti Buffalo",
      milkYield: 8,
      price: 120000,
      inStock: false,
      insurance: 13000,
      image: "assets/images/buffalo_images2.jpg",
      description:
          "Surti buffaloes are medium-sized with sickle-shaped horns and are "
          "known for moderate milk yield and high-fat content.",
    ),
    Buffalo(
      id: "BHAD-001",
      breed: "Bhadawari Buffalo",
      milkYield: 7,
      price: 100000,
      inStock: false,
      insurance: 13000,
      image: "assets/images/buffalo_images3.jpeg",
      description:
          "Bhadawari buffaloes are hardy animals with high-fat milk and "
          "good heat tolerance.",
    ),
  ];
});
