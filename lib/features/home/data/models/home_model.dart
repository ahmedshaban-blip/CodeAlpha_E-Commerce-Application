// class ProductModel {
//   int? id;
//   String? title;
//   double? price;
//   String? description;
//   String? category;
//   String? image;
//   double? rate; // بدلاً من موديل فرعي
//   double? count;

//   ProductModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     price = (json['price'] as num?)?.toDouble();
//     description = json['description'];
//     category = json['category'];
//     image = json['image'];
//     count = json['count'] as double?;

//     // هنا تفكيك الـ rating مباشرة
//     if (json['rating'] != null) {
//       rate = (json['rating']['rate'] as num?)?.toDouble();
//       count = (json['count'] as num?)?.toDouble();
//     }
//   }
// }

//   /*
//  {
//         "id": 1,
//         "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
//         "price": 109.95,
//         "description": "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
//         "category": "men's clothing",
//         "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
//         "rating": {
//             "rate": 3.9,
//             "count": 120
//         }
//     },

//  */

class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double? rating;
  final double? count;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    this.rating,
    this.count,
  });

  // Factory constructor for FakeStoreAPI (jewelry)
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: json['rating'] != null ? json['rating']['rate'].toDouble() : null,
      count: json['rating'] != null
          ? (json['rating']['count'] as num?)?.toDouble()
          : null,
    );
  }

  // Factory constructor for DummyJSON API (electronics)
  factory ProductModel.fromDummyJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['thumbnail'] ??
          (json['images'] != null && json['images'].isNotEmpty
              ? json['images'][0]
              : ''),
      rating: json['rating']?.toDouble(),
      count: (json['stock'] as num?)
          ?.toDouble(), // Using stock as count for DummyJSON
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'category': category,
        'image': image,
        'rating': {
          'rate': rating,
          'count': count,
        },
      };
}
