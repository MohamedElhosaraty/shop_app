class FavoriteModel {
  final bool status;
  final String message;

  FavoriteModel({
    required this.status,
    required this.message,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
    status: json["status"],
    message: json["message"],
  );

}

class Data {
  final int id;
  final Product product;

  Data({
    required this.id,
    required this.product,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    product: Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product": product.toJson(),
  };
}

class Product {
  final int id;
  final int price;
  final int oldPrice;
  final int discount;
  final String image;

  Product({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    price: json["price"],
    oldPrice: json["old_price"],
    discount: json["discount"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "price": price,
    "old_price": oldPrice,
    "discount": discount,
    "image": image,
  };
}
