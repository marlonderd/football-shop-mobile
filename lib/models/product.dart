import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  int pk;
  String name;
  int price;
  int stock;
  String description;
  String category;
  String? thumbnail;
  String createdAt; 
  String? user; 
  bool isHot;
  int productViews;

  Product({
    required this.pk,
    required this.name,
    required this.price,
    required this.stock,
    required this.description,
    required this.category,
    this.thumbnail,
    required this.createdAt,
    this.user,
    required this.isHot,
    required this.productViews,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // Logic untuk menangani struktur JSON flat/nested
    Map<String, dynamic> fields = json; 
    if (json.containsKey("fields")) {
      fields = json["fields"];
    }
    
    dynamic userValue = fields["user"];
    String? userString;
    if (userValue != null) {
        userString = userValue.toString();
    }


    return Product(
        pk: json["pk"],
        name: fields["name"],
        
        price: double.parse(fields["price"].toString()).toInt(), 
        
        stock: fields["stock"] ?? 0,
        description: fields["description"],
        category: fields["category"],
        thumbnail: fields["thumbnail"],
        
        createdAt: fields["created_at"], 
        
        user: userString,
        
        isHot: fields["is_hot"] ?? false,
        productViews: fields["product_views"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "pk": pk,
        "fields": {
          "name": name,
          "price": price,
          "stock": stock,
          "description": description,
          "category": category,
          "thumbnail": thumbnail,
          "created_at": createdAt,
          "user": user,
          "is_hot": isHot,
          "product_views": productViews,
        },
      };
}