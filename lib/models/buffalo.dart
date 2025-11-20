class Buffalo {
  final String id;
  final String breed;          // e.g. Murrah Buffalo
  final int milkYield;         // L / day
  final int price;             // per animal
  final bool inStock;
  final int insurance;
  final String image;          // asset path
  final String description;    // long text for detail page

  const Buffalo({
    required this.id,
    required this.breed,
    required this.milkYield,
    required this.price,
    required this.inStock,
    required this.insurance,
    required this.image,
    required this.description,
  });
}
