class Item {
  final String name;
  final String price;
  final String imagePath;
  final String description;
  String selectedSize;
  int selectedQuantity;

  Item({
    required this.name,
    required this.price,
    required this.description,
    required this.imagePath,
    this.selectedSize = '',
    this.selectedQuantity = 0,
  });

  // Convert item to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'description': description,
      'imagePath': imagePath,
      'selectedSize': selectedSize,
      'selectedQuantity': selectedQuantity,
    };
  }

  // Get item from JSON
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'],
      price: json['price'],
      description: json['description'],
      imagePath: json['imagePath'],
      selectedSize: json['selectedSize'],
      selectedQuantity: json['selectedQuantity'],
    );
  }
}
